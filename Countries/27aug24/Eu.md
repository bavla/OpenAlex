# Europe

## Merging years 1994:2003, 2004:2013, 2014:2023
```
> load("./EU/EuropeList.Rdata")
> EX <- list()
> s <- 5
> for(i in 1:3){
+   M <- E[[s]]$M
+   for(j in 1:9){ s <- s+1; M <- M+E[[s]]$M }
+   EX[[i]] <- M; s <- s+1 
+ }
> save(EX,file="EuropeXList.Rdata")
```
## Density and Balassa 1994:2003, 2004:2013, 2014:2023

```
> load("./EuRdata/EuropeXList.Rdata")
> EXb <- list()
> Y <- c("1994-2003","2004-2013","2014-2023")
> myPalette <- colorRampPalette(c("white","black"))(n=100)
> for(i in 1:length(EX)){
>    cat(i,"Years",Y[i],"\n"); flush.console()
>    P <- EX[[i]]; diag(P) <- 0; D <- rowSums(P) 
> # density
+    X <- Z <- log2(P)
+    Z[Z == -Inf] <- 0; Z[is.nan(Z)] <- 0 
+    X[X == -Inf] <- NA; X[is.nan(X)] <- 0 
+    X[,D==0] <- NA; X[D==0,] <- NA
+    h <- hclust(as.dist(CorEu(Z)),method="ward.D")
>    pdf(file=paste("EuXdensD",Y[i],".pdf",sep=""),width=11,height=11)
>    plot(h,cex=1,hang=-1,main=paste("Europe / density",Y[i]))
>    dev.off()
+    pdf(file=paste("EuXdens",Y[i],".pdf",sep=""),width=11,height=11)
+    heatmap.2(X,Rowv=as.dendrogram(h),Colv="Rowv",dendrogram="column",
+      scale="none",revC=TRUE,col=myPalette,na.color="yellow",
+      trace="none",density.info="none",keysize = 0.8,
+      main=paste("Europe ",Y[i]," / log2 w / Ward",sep=""))
+    dev.off()
> # Balassa
>    T <- sum(D); n <- nrow(P)
>    for(u in 1:(n-1)) for(v in (u+1):n) P[u,v] <- P[v,u] <- P[u,v]*T/D[u]/D[v]
>    X <- Z <- log2(P)
>    Z[Z == -Inf] <- 0; Z[is.nan(Z)] <- 0 
>    X[X == -Inf] <- NA; X[is.nan(X)] <- 0 
>    t <- hclust(as.dist(CorEu(Z)),method="ward.D")
>    EXb[[i]] <- list(h=h,t=t,M=X)
>    pdf(file=paste("EuXBalassaD",Y[i],".pdf",sep=""),width=11,height=11)
>    plot(t,cex=1,hang=-1,main=paste("Europe / Balassa",Y[i]))
>    dev.off()
>    pdf(file=paste("EuXBalassa",Y[i],".pdf",sep=""),width=11,height=11)
>    heatmap.2(X,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
>       scale="none",revC=TRUE,col = bluered(100),na.color="yellow",
>       trace = "none", density.info = "none",
>       main=paste("Europe ",Y[i]," / Balassa / Ward",sep=""))
>    dev.off()
> #  ans <- readline(paste(i,". Press Enter to continue >",sep=""))
> }
> save(EXb,file="EuropeXbList.Rdata")
```
