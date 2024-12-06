library(blockmodeling)
library(dynsbm)

# AUXILIARY FUNCTIONS -----------------------------------------------------

source("plotMatCol.R")

convertToLinkedNetworkNA <- function(nets) {
  netSizes <- unlist(lapply(nets, nrow))
  size <- sum(netSizes)
  tps <- length(nets)
  
  prt <- rep(1:tps, times = netSizes)
  tempNet <- matrix(0, nrow = size, ncol = size)
  for (i in 1:tps)  tempNet[prt == i, prt == i] <- nets[[i]]
  rownames(tempNet) <- colnames(tempNet) <- unlist(lapply(nets, rownames))
  
  for (k in 1:(tps-1)) {
    conn <- matrix(0, nrow = netSizes[k+1], ncol = netSizes[k])
    rownames(conn) <- rownames(nets[[k+1]])
    colnames(conn) <- colnames(nets[[k]])
    for (i in 1:nrow(conn)){
      for (j in 1:ncol(conn)){
        if (rownames(conn)[i] == colnames(conn)[j]) conn[i, j] <- 1
      }
    }
    tempNet[prt == k+1, prt == k] <- conn
  }
  
  return(list("net" = tempNet, "partitionNet" = prt))
}

compute.icl <- function(dynsbm) {
  T <- ncol(dynsbm$membership)
  Q <- nrow(dynsbm$trans)
  N <- nrow(dynsbm$membership)
  pen <- 0.5 * Q * log(N * (N - 1) * T / 2) + 0.25 * Q * (Q - 1) * T * log(N * (N - 1) / 2)
  
  if ("sigma" %in% names(dynsbm)) pen <- 2 * pen
  
  return(dynsbm$loglikelihood - ifelse(T > 1, 0.5 * Q * (Q - 1) * log(N * (T - 1)), 0) - pen)
}

reshape_multi_tnn <- function(res) {
  tps <- length(res)
  Y <- array(dim = c(tps, rep(nrow(res[[1]]), 2)))
  for (i in 1:tps){
    net <- matrix(0, nrow = nrow(res[[1]]), ncol = nrow(res[[1]]))
    rownames(net) <- colnames(net) <- rownames(res[[1]])
    net[rownames(res[[i]]), colnames(res[[i]])] <- res[[i]]
    Y[i,,] <- net
  }
  return(list("net" = Y))
}


# BALASSA -----------------------------------------------------------------

load("EuropeXbList.Rdata")

for (i in 1:3) EXb[[i]][is.na(EXb[[i]])] <- 0

# DYNSBM ------------------------------------------------------------------

# Blockmodeling
set.seed(1)
DSBM <- select.dynsbm(Y = reshape_multi_tnn(EXb)$net,
                      Qmin = 2,
                      Qmax = 15,
                      edge.type=c("continuous"),
                      directed=FALSE,
                      self.loop=FALSE,
                      iter.max=1000,
                      nstart=10000,
                      perturbation.rate=0.2,
                      fixed.param=TRUE,
                      plot=FALSE)

# ICL
ICL <- unlist(lapply(DSBM, compute.icl))
plot(ICL[1:9], x = c(2:15)[1:9], xlab = "Number of clusters", ylab = "ICL", type = "b")

# Visualisation
clusters <- lapply(apply(DSBM[[1]]$membership, 2, list), function(X) X[[1]][X[[1]] != 0])
tempNet <- convertToLinkedNetworkNA(EXb)
plotMatCol(tempNet$net, 
           clu = clusters, 
           main = "", 
           mar = c(1, 1, 1, 1), 
           par.line.width = 1,
           colPos = "red", 
           colNeg="blue")
