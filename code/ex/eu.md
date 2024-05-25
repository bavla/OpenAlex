# Europe - co-authorship between countries 

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
  * Remove node 59
  * Remove arcs except max
  * Weights 1 + ln
  * Draw




<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/code/ex/EU1995_1n.svg?sanitize=true">

<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/code/ex/EU2020_1n.svg?sanitize=true">
