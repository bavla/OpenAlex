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


```


```



