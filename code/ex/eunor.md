# Salton and Jaccard 

```
> i <- 34
> P <- E[[i]]$M; diag(P) <- 0; diag(P) <- rowSums(P)
> S <- P; diag(S) <- 1; J <- P; diag(J) <- 1
> n = nrow(S)
> for(u in 1:(n-1)) for(v in (u+1):n) {
+    S[v,u] <- S[u,v] <- P[u,v]/sqrt(P[u,u]*P[v,v])
+    J[v,u] <- J[u,v] <- P[u,v]/(P[u,u]+P[v,v]-P[u,v]) }
> matrix2net(S,Net="EuSalton2023.net")
> matrix2net(J,Net="EuJaccard2023.net")
> DS <- as.dist(1-S)
> t <- hclust(DS,method="ward.D")
> plot(t,hang=0.2,main="Europe 2023 / Salton / Ward",cex=0.7)
> DJ <- as.dist(1-J)
> h <- hclust(DJ,method="ward.D")
> plot(h,hang=0.2,main="Europe 2023 / Jaccard / Ward",cex=0.7)
```

