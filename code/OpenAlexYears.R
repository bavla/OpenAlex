# OpenAlex - All works by years 1990-2023
# Vladimir Batagelj, May 12, 2024

wdir <- "C:/Users/vlado/work/OpenAlex/API"
setwd(wdir)
library(httr)
library(jsonlite)
source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")

CD <- read.csv2("ISO2codes.csv",head=TRUE,na.strings="--")
CN <- CD$name; CC <- CD$code

n <- length(CC) 
for(year in 1990:2023){
  M <- matrix(0,nrow=n,ncol=n); rownames(M) <- colnames(M) <- CC
  T <- rep(0,n); names(T) <- CC; G <- rep(0,n); names(G) <- CC
  cat("\nYear =",year,date(),"\n"); flush.console()
  for(cy in CC){
    Q <- paste0("https://api.openalex.org/works?filter=",
      "authorships.countries:",cy,
      ",publication_year:",year,"&group-by=authorships.countries")
    S <- GET(Q)
    C <- fromJSON(rawToChar(S$content))
    D <- C$group_by; T[cy] <- C$meta$count; G[cy] <- C$meta$groups_count
    J <- unname(sapply(D$key,getISO))
    if(length(J)>0){
      V <- D$count; names(V) <- J
      for(j in J) M[cy,j] <- V[j]
    }
  }
  cat("collected",date(),"\n"); flush.console()
  save(T,G,M,file=paste0("Matrix",year,".Rdata"))
  k <- 0; a <- 0; dm <- 0
  for(i in 2:n){
    for(j in 1:(i-1)){
      if(M[i,j]!=M[j,i]) { 
        if(min(M[i,j],M[j,i])==0) { m <- max(M[i,j],M[j,i])
          M[i,j] <- M[j,i] <- m; k <- k+1
        } else {a <- a+1; d <- M[i,j]-M[j,i]; dm <- max(abs(d),dm) 
          cat(i,j,CC[i],CC[j],M[i,j],M[j,i],d,"\n")}
      }
    }
  }
  cat("k =",k,"  a =",a,"  dmax =",dm,"\n"); flush.console()
  matrix2net(M,Net=paste0("WorldCo",year,".net"))
}
cat("finished",date(),"\n"); flush.console()
