# Europe - co-authorship between countries 

Extracting from the world networks.

<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/Europe_ISO_3166-1_%2BXK.svg?sanitize=true" width="800">

| ISO | country  | ISO      | country    | ISO        | country    | ISO      | country    | ISO        | country    |
|-----|----------|-----|----------|-----|----------|-----|----------|-----|----------|
| AD  | Andorra  |     CZ  | Czech rep  |    GR  | Greece  |	    LV  | Latvia  |	 RU  | Russia  |
| AL  | Albania  |     DE  | Germany  |	     HR  | Croatia  |	    MC  | Monaco  |	 SE  | Sweden  |
| AM  | Armenia  |     DK  | Denmark  |	     HU  | Hungary  |	    MD  | Moldova  |	 SI  | Slovenia  |
| AT  | Austria  |     EE  | Estonia  |	     IE  | Ireland  |	    ME  | Montenegro  |	 SJ  | Svalbard+JM  |
| AX  | Åland/FI  |    ES  | Spain  |	     IM  | i of Man/GB  |   MK  | N Macedonia  | SK  | Slovakia  |
| AZ  | Azerbaijan  |  FI  | Finland  |	     IS  | Iceland  |	    MT  | Malta  |	 SM  | San Marino  |
| BA  | Bosnia+Herz  | FO  | Faroe i/DK  |   IT  | Italy  |	    NL  | Netherlands  | TR  | Turkey  |
| BE  | Belgium  |     FR  | France  |	     JE  | Jersey/GB  |	    NO  | Norway  |	 UA  | Ukraine  |
| BG  | Bulgaria  |    GB  | G Britain  |    KZ  | Kazakhstan  |    PL  | Poland  |	 VA  | Vatican  |
| BY  | Belarus  |     GE  | Georgia  |	     LI  | Liechtenstein  | PT  | Portugal  |	 XK  | Kosovo  |
| CH  | Switzerland  | GG  | Guernsey/GB  |  LT  | Lithuania  |	    RO  | Romania  |	     |          |
| CY  | Cyprus  |      GI  | Gibraltar/GB  | LU  | Luxembourg  |    RS  | Serbia  |	     |          |





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
  * [Salton and Jaccard](./eunor.md)
  * [Balassa](./eubal.md)
