# First version of OpenAlexSources

```
> setwd(wdir <- "C:/OpenAlex/sources")
> library(httr); library(jsonlite)
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2Pajek.R")
> worksS <- "addWorks.csv"
> sID <- "s4210233660"; cond <- ""
> # cond <- ",publication_year:1990-2024" 
> works <- "https://api.openalex.org/works"
> cat("OpenAlex2Pajek / Sources",date(),"\n")
OpenAlex2Pajek / Sources Sun May  4 05:32:28 2025 
> # --- Wj ---
> cat("start",date(),"\n"); flush.console()
start Sun May  4 05:32:28 2025 
> Q <- list(
+   filter=paste0("primary_location.source.id:",sID,cond),
+   select="id,cited_by_count",
+   per_page="200", cursor="*"
+ )
> i <- 0; Wj <- NULL
> while(TRUE){
+   wd <- GET(works,query=Q)
+   if(wd$status_code!=200) break
+   wc <- fromJSON(rawToChar(wd$content))
+   Q$cursor <- wc$meta$next_cursor
+   if(is.null(Q$cursor)) break
+   df <- wc$results; nr <- nrow(df); i <- i+1
+   # cat(i,nr,"\n"); flush.console()
+   if(nr>0){df$id <- getID(df$id); Wj <- rbind(Wj,df)}
+ } 
> nj <- nrow(Wj)
> cat(nj,"source",sID,"works collected",date(),"\n"); flush.console()
2522 source s4210233660 works collected Sun May  4 05:32:31 2025 
> # --- Win ---
> Win <- NULL; nin <- 0
> for(k in 1:nj) if(Wj$cited_by_count[k]>0){wID <- Wj$id[k]; nin <- nin+1
+   Q <- list(
+     filter=paste0("cites:",wID,cond),
+     select="id,cited_by_count",
+     per_page="200", cursor="*"
+   )
+   i <- 0
+   while(TRUE){
+     wd <- GET(works,query=Q)
+     if(wd$status_code!=200) break
+     wc <- fromJSON(rawToChar(wd$content))
+     Q$cursor <- wc$meta$next_cursor
+     if(is.null(Q$cursor)) break
+     df <- wc$results; nr <- nrow(df); i <- i+1
+     # cat(k,i,nr,"\n"); flush.console()
+     if(nr>0){df$id <- getID(df$id); Win <- rbind(Win,df)}
+   } 
+ }
> cat(nrow(Win),"citing works collected",date(),"\n"); flush.console()
4090 citing works collected Sun May  4 05:39:21 2025 
> # --- Wout ---
> Wout <- NULL; ri <- 0
> while(TRUE) {
+   li <- ri+1; ri <- min(ri+50,nj)
+   if(li > ri) break
+   wID <- paste(Wj$id[li:ri],collapse="|")
+   Q <- list(
+     filter=paste0("openalex:",wID,cond),
+     select="id,referenced_works",
+     per_page="200", page="1"
+   )
+   wd <- GET(works,query=Q)
+   if(wd$status_code!=200) next
+   wc <- fromJSON(rawToChar(wd$content))
+   df <- wc$results; nr <- nrow(df)
+   if(nr>0){ # use current page data 
+     for(i in 1:nr){
+       Rid <- getID(unlist(df$referenced_works[i])); rn <- length(Rid)
+     # cat(i,nr,"\n"); flush.console()
+       if(rn>0) Wout <- rbind(Wout,data.frame(id=Rid,cited_by_count=rep(-1,rn)))
+     }
+   } 
+ }
> cat(nrow(Wout),"cited works collected",date(),"\n"); flush.console()
14515 cited works collected Sun May  4 05:39:31 2025 
> # --- save ---
> W <- union(Wout$id,union(Win$id,Wj$id))
> cat(length(W),"different works",date(),"\n"); flush.console()
17641 different works Sun May  4 05:39:31 2025 
> csv <- file(worksS,"w",encoding="UTF-8")
> write(W,sep="\n",file=csv)
> close(csv)
> cat("finish",date(),"\n"); flush.console()
finish Sun May  4 05:39:31 2025 
```

The creation of networks takes around 3 hours.
```
> Q <- NULL
> OpenAlex2PajekAll(Q,name="Dasha",listF=worksS)
OpenAlex2Pajek / All - Start Sun May  4 17:06:34 2025 
*** OpenAlex2Pajek / All - Process Sun May  4 17:06:34 2025 
Sun May  4 17:09:04 2025  n = 500 
Sun May  4 17:12:10 2025  n = 1000 
Sun May  4 17:15:16 2025  n = 1500 
Sun May  4 17:19:06 2025  n = 2000 
Sun May  4 17:22:45 2025  n = 2500 
2857 GET error
Sun May  4 17:26:43 2025  n = 3000 
Sun May  4 17:30:50 2025  n = 3500 
Sun May  4 17:34:54 2025  n = 4000 
Sun May  4 17:38:54 2025  n = 4500 
Sun May  4 17:43:13 2025  n = 5000 
Sun May  4 17:47:58 2025  n = 5500 
W 5969 https://openalex.org/W2064249557 1 
<simpleError in exists(cty, env = cntrs, inherits = FALSE): invalid first argument>
Sun May  4 17:52:31 2025  n = 6000 
Sun May  4 17:57:17 2025  n = 6500 
Sun May  4 18:02:26 2025  n = 7000 
Sun May  4 18:07:04 2025  n = 7500 
Sun May  4 18:12:24 2025  n = 8000 
Sun May  4 18:17:28 2025  n = 8500 
Sun May  4 18:22:35 2025  n = 9000 
Sun May  4 18:28:10 2025  n = 9500 
Sun May  4 18:34:10 2025  n = 10000 
Sun May  4 18:39:59 2025  n = 10500 
Sun May  4 18:45:49 2025  n = 11000 
Sun May  4 18:52:12 2025  n = 11500 
Sun May  4 18:58:56 2025  n = 12000 
Sun May  4 19:05:31 2025  n = 12500 
Sun May  4 19:13:38 2025  n = 13000 
Sun May  4 19:21:22 2025  n = 13500 
Sun May  4 19:28:23 2025  n = 14000 
Sun May  4 19:36:11 2025  n = 14500 
Sun May  4 19:42:58 2025  n = 15000 
Sun May  4 19:49:18 2025  n = 15500 
Sun May  4 20:00:04 2025  n = 16000 
Sun May  4 20:03:50 2025  n = 16500 
Sun May  4 20:07:59 2025  n = 17000 
Sun May  4 20:11:37 2025  n = 17500 
*** OpenAlex2Pajek / All - Data Collected Sun May  4 20:12:39 2025 
hits: 17640 works: 395453 authors: 29992 anon: 388 sources: 4077 
>>> Citation Cite
>>> publication year
>>> type of publication
>>> language of publication
>>> cited by count
>>> countries distinct count
>>> referenced works
>>> Authorship WA
>>> Sources WJ
>>> Countries WC
>>> Keywords WK
*** OpenAlex2Pajek / All - Stop Sun May  4 20:15:50 2025 
```

## Analysis with Pajek

  1. read WJ and Ci
  2. for both networks  Network/Create new network/Transform/Remove/Miltiple lines/Sum values [yes]
  3. transpose WJ -> JW
  4. multiply JW * Ci -> JciW
  5. multiply JciW * WJ -> JciJ
  6. remove loops (journal self citations) from JciJ -> JciJ'
  7. determine vector of weighted (all) degrees in JciJ'
  8. Vector/Make partition/by intervals [100]
  9. extract cluster 2 from JciJ' -> JJ100
  10. Network/Create new network/Transform/Line values/Ln  ->  JJln
  11. Cluster/Create complete cluster
  12. Operations/Network+Cluster/Dissimilarity/d5  ->  D, dendro.eps
  13. select JJln, File/Network/Export as matrix/EPS/Using permutation
  14. using Acrobat reader convert EPS files to PDF

[dendrogram](dendroCoEucLn.pdf), [matrix](matrix_wdeg100.pdf)
