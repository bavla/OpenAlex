====== Balassa index ======


https://github.com/bavla/NormNet/blob/main/data/natalija/analysis.md

```
> wdir <- "C:/Users/vlado/work/OpenAlex/API"
> setwd(wdir)
>  
> library(httr)
> library(jsonlite)
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2.R")
> # source("OpenAlex2.R")
> library(gplots)

> CorEu <- function(W,p=1){
+    D <- W; diag(D) <- 0; n = nrow(D)
+    for(u in 1:(n-1)) for(v in (u+1):n) D[v,u] <- D[u,v] <- 
+       sqrt(sum((W[u,]-W[v,])**2) -
+       (W[u,u]-W[v,u])**2 - (W[u,v]-W[v,v])**2 +
+       p*((W[u,u]-W[v,v])**2 + (W[u,v]-W[v,u])**2)) 
+    return(D)
+ }

> load("./EU/EuropeList.Rdata")
> Y <- as.character(1990:2023)
> for(i in 1:length(E)){
>    cat(i,"Year",Y[i],"\n"); flush.console()
>    P <- E[[i]]$M; diag(P) <- 0
>    D <- rowSums(P); T <- sum(D); n <- nrow(P)
>    for(u in 1:(n-1)) for(v in (u+1):n) P[u,v] <- P[v,u] <- P[u,v]*T/D[u]/D[v]
>    X <- Z <- log2(P)
>    Z[Z == -Inf] <- 0; Z[is.nan(Z)] <- 0 
>    X[X == -Inf] <- NA; X[is.nan(X)] <- 0 
>    t <- hclust(as.dist(CorEu(Z)),method="ward.D")
>    pdf(file=paste("EuBalassa",Y[i],".pdf",sep=""),width=11,height=11)
>    heatmap.2(X,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
+       scale="none",revC=TRUE,col = bluered(100),na.color="yellow",
+       trace = "none", density.info = "none",
+       main=paste("Europe ",Y[i]," / log deviation / Ward",sep=""))
> #   ans <- readline(paste(i,". Press Enter to continue >",sep=""))
>    dev.off()
> }

```

