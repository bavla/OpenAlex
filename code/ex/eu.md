# Europe - co-authorship between countries 

Extracting from the world networks.

## Single year
```
> load("MatrixList.Rdata")
> length(S)
[1] 34
> i <- 34
> TM <- S[[i]]$M
> cont <- clu2vector("continents.clu",skip=3)
> cn <- rownames(TM)
> eu <- which(cont %in% c(0,4))
> cn[eu]
> EM <- TM[eu,eu]
> m <- nrow(EM)+1
> EM <- rbind(cbind(EM,rep(NA,m-1)),rep(NA,m))
> rownames(EM)[m] <- colnames(EM)[m] <- "OTH"
> oth <- which(!(cont %in% c(0,4)))
> rs <- rowSums(TM[eu,oth])
> EM[1:(m-1),m] <- rs; EM[m,1:(m-1)] <- rs
> OM <- TM[oth,oth]; OM[lower.tri(OM)] <- 0
> EM[m,m] <- sum(OM)
> matrix2net(EM,"EU2020.net")
```

  * Read network in Pajek
  * Info
  * Remove loops
  * Weights 1 + ln
  * Remove node 59
  * Remove arcs except max
  * Arcs -> Edges (bidirected, min)
  * Draw

Macro [Eu1neighbors](https://raw.githubusercontent.com/bavla/OpenAlex/main/code/Eu1neighbors.mcr)

  * Select the 1+ln network produced by Eu1neighbors
  * Create Complete Cluster on 59 nodes
  * Operations/network+cluster/Dissimilarity based on network [Corr Euclidean][1]
  * Hierarchical Clustering (automatic) save dendro.eps
  * file/network/export matrix using permutation matrix.eps

Macro [EuCluster](https://raw.githubusercontent.com/bavla/OpenAlex/main/code/EuCluster.mcr)

## All years
```
> cat("started",date(),"\n")
> load("MatrixList.Rdata")
> s <- length(S); E <- list()
> cont <- clu2vector("continents.clu",skip=3)
> for(i in 1:s){
+   TM <- S[[i]]$M; year <- 1989+i
+   cn <- rownames(TM); eu <- which(cont %in% c(0,4))
+   EM <- TM[eu,eu]; m <- nrow(EM)+1
+   EM <- rbind(cbind(EM,rep(NA,m-1)),rep(NA,m))
+   rownames(EM)[m] <- colnames(EM)[m] <- "OTH"
+   oth <- which(!(cont %in% c(0,4)))
+   rs <- rowSums(TM[eu,oth])
+   EM[1:(m-1),m] <- rs; EM[m,1:(m-1)] <- rs
+   OM <- TM[oth,oth]; OM[lower.tri(OM)] <- 0
+   EM[m,m] <- sum(OM)
+   WG <- S[[i]]$G; EG <- c(WG[eu],OTH=200)
+   WT <- S[[i]]$T; ET <- WT[eu]; ET <- c(ET,OTH=sum(WT)-sum(ET))
+   E[[i]] <- list(M=EM,G=EG,T=ET)
+   matrix2net(EM,paste0("EU",year,".net"))
+   vector2clu(EG,Clu=paste0("EU",year,"G.clu"))
+   vector2vec(ET,Vec=paste0("EU",year,"T.vec"))
+ }
> save(E,file="EuropeList.Rdata")
> cat("finished",date(),"\n")

started Sat May 25 00:52:27 2024 
finished Sat May 25 00:52:30 2024 
```

### 1995
<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/EU1995_1n.svg?sanitize=true" width="600">

### 2020
<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/EU2020_1n.svg?sanitize=true" width="600">

<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/EUdend2020.svg?sanitize=true" width="500">

<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/EUmat2020.svg?sanitize=true" width="700">

### 2023

<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/EU2023_1n.svg?sanitize=true" width="600">

<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/EUmat2023.svg?sanitize=true" width="700">
