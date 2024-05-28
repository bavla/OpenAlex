# Europe - co-authorship between countries 

Extracting from the world networks.

<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/Europe_ISO_3166-1.svg?sanitize=true" width="800">

| ISO | country  | ISO      | country    | ISO        | country    |
|-----|----------|-----|----------|-----|----------|
| AD  | Andorra  |	GB  | G Britain  |	  MK  | N Macedonia  |
| AL  | Albania  |	GE  | Georgia  |	  MT  | Malta  |
| AM  | Armenia  |	GG  | Guernsey/GB  |	  NL  | Netherlands  |
| AT  | Austria  |	GI  | Gibraltar/GB  |	  NO  | Norway  |
| AX  | Åland/FI  |	GR  | Greece  |		  PL  | Poland  |
| AZ  | Azerbaijan  |	HR  | Croatia  |	  PT  | Portugal  |
| BA  | Bosnia+Herz  |	HU  | Hungary  |	  RO  | Romania  |
| BE  | Belgium  |	IE  | Ireland  |	  RS  | Serbia  |
| BG  | Bulgaria  |	IM  | i of Man/GB  |	  RU  | Russia  |
| BY  | Belarus  |	IS  | Iceland  |	  SE  | Sweden  |
| CH  | Switzerland  |	IT  | Italy  |		  SI  | Slovenia  |
| CY  | Cyprus  |	JE  | Jersey/GB  |	  SJ  | Svalbard+JM  |
| CZ  | Czech rep  |	KZ  | Kazakhstan  |	  SK  | Slovakia  |
| DE  | Germany  |	LI  | Liechtenstein  |	  SM  | San Marino  |
| DK  | Denmark  |	LT  | Lithuania  |	  TR  | Turkey  |
| EE  | Estonia  |	LU  | Luxembourg  |	  UA  | Ukraine  |
| ES  | Spain  |	LV  | Latvia  |		  VA  | Vatican  |
| FI  | Finland  |	MC  | Monaco  |		  XK  | Kosovo  |
| FO  | Faroe i/DK  |	MD  | Moldova  |	      |         |
| FR  | France  |	ME  | Montenegro  |	      |         |



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
## Analyses

  * [1-neighbors and clustering](./eungb.md)
  * [Balassa](./eubal.md)
