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
