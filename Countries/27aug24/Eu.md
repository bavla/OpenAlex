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
## Reordering

### Some functions

```
> flip <- function(k,T) {t <- T[k,1]; T[k,1] <- T[k,2]; T[k,2] <- t; return(T)}
> toFather <- function(tm){
+   n <- nrow(tm); T <- rep(0,2*n+1)
+   for(i in 1:n){
+     for(j in 1:2){
+       p <- tm[i,j]
+       if(p<0) T[-p] <- i+n+1 else T[n+1+p] <- i+n+1
+     }
+   }
+   return(T)
+ }
> minCl <- function(u,v,T){
+   if(min(u,v)==0) return(T[max(u,v)])
+   # cat(u," ",v,":",T[u]," ",T[v],"\n")
+   if(u==v) return(u)
+   return( if(T[u]<T[v]) minCl(T[u],v,T) else minCl(u,T[v],T) ) 
+ }
```

### Balassa

```
> i <- 1; t <- EXb[[i]]$t; h <- EXb[[3]]$h; X <- EXb[[i]]$M
> F <- toFather(t$merge); N <- rownames(X); n <- length(N)
> minCl(which(N=="JE"),which(N=="RO"),F) - n
[1] 50
> minCl(which(N=="SM"),which(N=="DE"),F) - n
[1] 39
> minCl(which(N=="TR"),which(N=="LT"),F) - n
[1] 53
> t$merge <- flip(39,flip(53,flip(50,t$merge)))
---
> i <- 2; t <- EXb[[i]]$t; h <- EXb[[i]]$h; X <- EXb[[i]]$M
> F <- toFather(t$merge); N <- rownames(X); n <- length(N)
> t$merge <- flip(43,flip(20,flip(51,flip(47,t$merge))))
---
> i <- 3; t <- EXb[[i]]$t; h <- EXb[[i]]$h; X <- EXb[[i]]$M
> F <- toFather(t$merge); N <- rownames(X); n <- length(N)
> t$merge <- flip(25,flip(50,flip(57,flip(29,flip(8,t$merge)))))
> t$merge <- flip(40,flip(52,flip(44,flip(38,t$merge))))
----
> heatmap.2(X,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
+   scale="none",revC=TRUE,col=bluered(100),na.color="yellow",
+   trace="none",density.info="none",keysize = 0.8,
+   main=paste("Europe ",Y[i]," / Balassa / Ward",sep=""))
> 
> pdf(file=paste("EuXBalassaR",Y[i],".pdf",sep=""),width=11,height=11)
> heatmap.2(X,Rowv=as.dendrogram(t),Colv="Rowv",dendrogram="column",
>   scale="none",revC=TRUE,col = bluered(100),na.color="yellow",
>   trace = "none", density.info = "none",keysize = 0.8,
>   main=paste("Europe ",Y[i]," / Balassa / Ward",sep=""))
> dev.off()

```

### Density

```
> i <- 1; cat(i,"Years",Y[i],"\n")
> P <- EX[[i]]; diag(P) <- 0; D <- rowSums(P)
> X <- Z <- log2(P)
> Z[Z == -Inf] <- 0; Z[is.nan(Z)] <- 0 
> X[X == -Inf] <- NA; X[is.nan(X)] <- 0 
> X[,D==0] <- NA; X[D==0,] <- NA
> h <- hclust(as.dist(CorEu(Z)),method="ward.D")

> F <- toFather(h$merge); N <- rownames(X); n <- length(N)
> h$merge <- flip(54,flip(57,flip(48,h$merge)))
> h$merge <- flip(40,flip(28,flip(33,flip(38,h$merge))))

-------------
> i <- 2; cat(i,"Years",Y[i],"\n")
> P <- EX[[i]]; diag(P) <- 0; D <- rowSums(P)
> X <- Z <- log2(P)
> Z[Z == -Inf] <- 0; Z[is.nan(Z)] <- 0 
> X[X == -Inf] <- NA; X[is.nan(X)] <- 0 
> X[,D==0] <- NA; X[D==0,] <- NA
> h <- hclust(as.dist(CorEu(Z)),method="ward.D")

> F <- toFather(h$merge); N <- rownames(X); n <- length(N)
> h$merge <- flip(50,flip(49,flip(56,flip(55,h$merge))))
> h$merge <- flip(52,flip(42,flip(54,flip(51,h$merge))))

-------------
> i <- 3; cat(i,"Years",Y[i],"\n")
> P <- EX[[i]]; diag(P) <- 0; D <- rowSums(P)
> X <- Z <- log2(P)
> Z[Z == -Inf] <- 0; Z[is.nan(Z)] <- 0 
> X[X == -Inf] <- NA; X[is.nan(X)] <- 0 
> X[,D==0] <- NA; X[D==0,] <- NA
> h <- hclust(as.dist(CorEu(Z)),method="ward.D")
> h$merge <- flip(52,flip(41,flip(57,h$merge)))
--------------------

> heatmap.2(X,Rowv=as.dendrogram(h),Colv="Rowv",dendrogram="column",
+   scale="none",revC=TRUE,col=myPalette,na.color="yellow",
+   trace="none",density.info="none",keysize = 0.8,
+   main=paste("Europe ",Y[i]," / log density / Ward",sep=""))
> 

> pdf(file=paste("EuXdensR",Y[i],".pdf",sep=""),width=11,height=11)
> heatmap.2(X,Rowv=as.dendrogram(h),Colv="Rowv",dendrogram="column",
>   scale="none",revC=TRUE,col=myPalette,na.color="yellow",
>   trace="none",density.info="none",keysize=0.8,
>   main=paste("Europe ",Y[i]," / log density / Ward",sep=""))
> dev.off()
```

## Co-authorship growth

### Growth matrix G

G[countries,years]
```
> load("./EU/EuropeList.Rdata")
> ny <- length(E); n <- nrow(E[[1]]$M)
> G <- matrix(0,nrow=n,ncol=ny)
> for(y in 1:ny) G[,y] <- diag(E[[y]]$M)
> rownames(G) <- rownames(E[[1]]$M); colnames(G) <- 1990:2023
> save(G,file="EuGrowth.Rdata")
```

### Plotting

```
> ym <- max(G); x <- 1990:2023; n <- nrow(G)
> plot(x,x,ylim=c(0,ym),type="n",main="Europe co-authorship growth")
> for(c in 1:n) lines(x,G[c,])

> Log <- function(v) ifelse(v>1,log(v),0)
> xl <- sample(1990:2023,n,replace=TRUE)
> N <- rownames(G); yl <- rep(0,n)
> plot(x,x,ylim=c(0,Log(ym)),type="n",main="Europe log growth")
> for(c in 1:n) {yl[c] <- Log(G[c,xl[c]-1989]); lines(x,Log(G[c,]))}
> text(xl,yl,labels=N,cex=0.7,col="red")

> y <- Log(G["GB",])
> reg = lm(y~x)
> plot(x,y,main="line GB")
> abline(reg,col="blue",lw=2)
> a <- reg$coef[2]; b <- reg$coef[1]
> A <- exp(a); C <- exp(b)
> c(a,b,A,C)
            x   (Intercept)             x   (Intercept) 
 9.021400e-02 -1.700968e+02  1.094408e+00  1.342497e-74 

> z <- exp(a*x+b)
> plot(x,G["GB",],main="Growth GB")
> lines(x,z,type="l",col="red",lw=2)
```
## Weight distributions

```
> library(ggplot2)
> i <- 3; cat(i,"Years",Y[i],"\n")
> P <- EX[[i]]; diag(P) <- 0; V <- P[P>0]

> # Histogram
> hist(V,col="green",border="black",prob=TRUE,xlab="w",breaks=50,
+   main=paste0("Europe ",Y[i]," Weights Distribution"))

> # Log
> T <- log(V)
> hist(T,col="green",border="black",prob=TRUE,xlab="log(w)",breaks=20,
+   main=paste0("Europe ",Y[i]," Log Weights Distribution"))
> lines(density(T,n=64),lwd=2,col="blue")
> c(m <- mean(T),s <- sd(T))
> curve(dnorm(x,m,s),from=0,to=12,lwd=2,col="red",xaxt="n",yaxt="n",add=TRUE)

> # Power
> a <- 0.02; T <- (1000*V)**a
> hist(T,col="green",border="black",prob=TRUE,ylim=c(0,6.5),
+   xlab="(1000*w)^0.02",main=paste0("Europe ",Y[i]," (1000*w)^",a," Distribution"))
> c(m <- mean(T),s <- sd(T))
[1] 1.28794540 0.07122478
> curve(dnorm(x,m,s),from=0.6,to=2.6,lwd=2,col="red",xaxt="n",yaxt="n",add=TRUE)
> lines(density(T,n=64),lwd=2,col="blue")

> # Balassa
> P <- EXb[[i]]$M; T <- P[!is.na(P)]
> hist(T,col="green",border="black",prob=TRUE,xlab="Balassa(w)",breaks=20,
+   main=paste0("Europe ",Y[i]," Balassa Weights Distribution"))
> lines(density(T,n=128),lwd=2,col="blue")
> c(m <- mean(T),s <- sd(T))
> curve(dnorm(x,m,s),from=-4,to=7,lwd=2,col="red",xaxt="n",yaxt="n",add=TRUE)
```


