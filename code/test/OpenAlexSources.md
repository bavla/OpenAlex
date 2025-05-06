## OpenAlexSources

May 6, 2025

I converted the program from [First version](first.md) into a function `OpenAlexSources`. It is included in the package [`OpenAlex2Pajek`](https://github.com/bavla/OpenAlex/tree/main/OpenAlex2Pajek).
```
OpenAlexSources <- function(sID,step=100,cond=""){
  cat("OpenAlex2Pajek / Sources",date(),"\n"); flush.console()
  works <- "https://api.openalex.org/works"
# --- Wj ---
  Q <- list(filter=paste0("primary_location.source.id:",sID,cond),
    select="id,cited_by_count", per_page="200", cursor="*")
  i <- 0; Wj <- NULL
  while(TRUE){
    wd <- GET(works,query=Q)
    if(wd$status_code!=200) break
    wc <- fromJSON(rawToChar(wd$content))
    Q$cursor <- wc$meta$next_cursor
    if(is.null(Q$cursor)) break
    df <- wc$results; nr <- nrow(df); i <- i+1
    if(step>0) {cat("i =",i," nr =",nr,"\n"); flush.console()}
    if(nr>0){df$id <- getID(df$id); Wj <- rbind(Wj,df)}
  } 
  nj <- nrow(Wj)
  cat(nj,"source",sID,"works collected",date(),"\n"); flush.console()
# --- Win ---
  Win <- NULL; ni <- 0
  for(k in 1:nj) if(Wj$cited_by_count[k]>0){
    wID <- Wj$id[k]
    Q <- list(filter=paste0("cites:",wID),
      select="id,cited_by_count", per_page="200", cursor="*")
    i <- 0
    while(TRUE){
      wd <- GET(works,query=Q)
      if(wd$status_code!=200) break
      wc <- fromJSON(rawToChar(wd$content))
      Q$cursor <- wc$meta$next_cursor
      if(is.null(Q$cursor)) break
      df <- wc$results; nr <- nrow(df); ni <- ni+1
      if(step>0) if(ni%%step==0) {cat(ifelse(ni%%(step*50)==0,".\n","."));
        flush.console()}
      # cat(k,nin,nr,"\n"); flush.console()
      if(nr>0){df$id <- getID(df$id); Win <- rbind(Win,df)}
    } 
  }
  cat("\n",nrow(Win),"citing works collected",date(),"\n"); flush.console()
# --- Wout ---
  Wout <- NULL; ri <- 0; no <- 0
  while(TRUE) {
    li <- ri+1; ri <- min(ri+50,nj)
    if(li > ri) break
    wID <- paste(Wj$id[li:ri],collapse="|")
    Q <- list(filter=paste0("openalex:",wID),
      select="id,referenced_works", per_page="200", page="1")
    wd <- GET(works,query=Q)
    if(wd$status_code!=200) next
    wc <- fromJSON(rawToChar(wd$content))
    df <- wc$results; nr <- nrow(df)
    if(nr>0){ 
      for(i in 1:nr){
        Rid <- getID(unlist(df$referenced_works[i])); rn <- length(Rid); no <- no+1
        if(step>0) if(no%%step==0) {cat(ifelse(no%%(step*50)==0,".\n","."));
          flush.console()}
        if(rn>0) Wout <- rbind(Wout,data.frame(id=Rid,cited_by_count=rep(-1,rn)))
      }
    } 
  }
  cat("\n",nrow(Wout),"cited works collected",date(),"\n"); flush.console()
# --- combine ---
  W <- union(Wout$id,union(Win$id,Wj$id))
  cat(length(W),"different works",date(),"\n"); flush.console() 
  return(W)
}
```

[Index](README.md)

