# OpenAlex ver 1. March 22, 2024
# https://github.com/bavla/OpenAlex/tree/main/code
# http://vladowiki.fmf.uni-lj.si/doku.php?id=vlado:work:bib:alex
# by Vladimir Batagelj, March 2024
# source("https://raw.githubusercontent.com/bavla/OpenAlex/main/OpenAlex.R")

keys = ls

eDict <- function(size=10000L) new.env(hash=TRUE,parent=emptyenv(),size=size)

getVals <- Vectorize(get,vectorize.args="x")

dict2DF <- function(dict,ind) {
  V <- as.data.frame(t(as.data.frame(getVals(keys(dict),dict))))
  colnames(V)[1] <- ind
  for(n in colnames(V)) V[[n]] <- unname(unlist(V[[n]]))
  return(V[order(V[[ind]]),])
}

# Wid -> (wind,sWname,hit,pyear,type,lang)
putWork <- function(Wid,val){ # val = list(sWname,hit,pyear,type,lang)
  if(exists(Wid,env=works,inherits=FALSE)){
    dHit <- works[[Wid]][["hit"]]; vHit <- val[["hit"]]
    if(vHit){dName <- works[[Wid]][["sWname"]]; vName <- val[["sWname"]]
      if(dHit){
        if(dName!=vName) cat("W",length(works),dName,vName,"\n",file=WC$tr) 
      } else works[[Wid]] <- c(wind=works[[Wid]][["wind"]],val)
    }
  } else works[[Wid]] <- c(wind=length(works)+1,val)
  return(works[[Wid]][["wind"]]) 
}

# Sid -> (sind,Sname)
putSrc <- function(Sid,par=list(Sname=NA)){
  Sname <- par[["Sname"]]
  if(exists(Sid,env=srces,inherits=FALSE)){
    dName <- srces[[Sid]][["Sname"]]
    if(is.na(dName)) srces[[Sid]][["Sname"]] <- Sname else {
      if(!is.na(Sname)) if(dName!=Sname)
        cat("S",length(srces),dName,Sname,"\n",file=WC$tr) }
  } else srces[[Sid]] <- list(sind=length(srces)+1,Sname=Sname)
  return(srces[[Sid]][["sind"]]) 
}

# Aid -> (aind,Aname)
putAuth <- function(Aid,par=list(Aname=NA)){
  Aname <- par[["Aname"]]
  sAnam <- ifelse(is.na(Aname),NA,sAname(Aname)) 
  if(exists(Aid,env=auths,inherits=FALSE)){
    dName <- auths[[Aid]][["Aname"]]
    if(is.na(dName)) {
      auths[[Aid]][["Aname"]] <- Aname; auths[[Aid]][["sAname"]] <- sAnam
    } else if(!is.na(Aname)) if(dName!=Aname) 
      cat("A",length(auths),dName,Aname,"\n",file=WC$tr) 
  } else auths[[Aid]] <- list(aind=length(auths)+1,Aname=Aname,sAname=sAnam)
  return(auths[[Aid]][["aind"]]) 
}

.Ty <- c("article"="AR","book-chapter"="BC","dissertation"="DS","book"="BK","dataset"="DS",        
  "paratext"="PT","other"="OT","reference-entry"="RE","report"="RP","peer-review"="PR",    
  "standard"="ST","editorial"="ED","erratum"="ER","grant"="GR","letter"="LT")

getID <- function(URLid) substring(URLid,22)

firstup <- function(n) {n <- tolower(n); substr(n,1,1) <- toupper(substr(n,1,1)); n}

Gname <- function(name,ty,py,vl,fp){L <- firstup(unlist(strsplit(name," "))); k <- length(L)
  H <- paste(substr(L[k],1,8),paste(substr(L[1:(k-1)],1,1),sep="",collapse=""),sep="_")
  if(ty=="article") paste(H,"(",py,")",vl,":",fp,sep="") else
    paste(H,"(",py,")",.Ty[ty],sep="")
}

sAname <- function(name){L <- firstup(unlist(strsplit(name," "))); k <- length(L)
  H <- paste(L[k],paste(substr(L[1:(k-1)],1,1),sep="",collapse=""))
}

openWorks <- function(query=NULL,list=NULL,file=NULL){
  WC <<- new.env(hash=TRUE,parent=emptyenv())
  WC$works <- "https://api.openalex.org/works"
  WC$Q <- query; WC$L <- list; WC$f <- file
  WC$n <- 0; WC$l <- 0; WC$m <- 0; WC$an <- 0; WC$er <- 0
  WC$tr <- file("trace.txt","w",encoding="UTF-8")
  cat("% OpenAlex",date(),"\n",file=WC$tr)
  if(length(query[["search"]])>0) {
    WC$k <- 0; WC$nr <- 0; WC$act <- "page"
    if(length(query[["per_page"]])==0) WC$Q$per_page <- "200"
    WC$Q$cursor <- "*"
  } else if(length(list)>0) { WC$act <- "list"
  } else if(length(file)>0) { WC$act <- "open"
  } else WC$act <- "stop"
}

nextWork <- function(){
  # repeat{
  for(t in 1:5){
    switch(WC$act,
      "page" = {
        # if(WC$n==10) {WC$act <- "list"; next}
        WC$k <- WC$k + 1
        if(WC$k>WC$nr){
          WC$wd <- GET(WC$works,query=WC$Q)
          if(WC$wd$status_code!=200) {WC$act <- "list"
            cat(WC$n,"GET error\n"); flush.console(); next}
          WC$k <- 1
          WC$wc <- fromJSON(rawToChar(WC$wd$content))
          WC$Q$cursor <- WC$wc$meta$next_cursor
          if(is.null(WC$Q$cursor)) {WC$act <- "list"; next}
          WC$df <- WC$wc$results; WC$nr <- nrow(WC$df)
          # cat(WC$k,wc$meta$count,WC$nr,"\n   ",WC$Q$cursor,"\n"); flush.console()
        }
        WC$n <- WC$n + 1
        return(WC$df[WC$k,])    
      },
      "list" = {
        WC$l <- WC$l + 1 
        if(WC$l>length(WC$L)) {WC$act <- "open"; next}
        works <- paste(WC$works,"/",WC$L[WC$l],sep="")
        WC$wd <- GET(works,query=list(select=WC$Q[["select"]]))
        if(WC$wd$status_code!=200) {cat(WC$n,"GET error\n")
          flush.console(); next}
        # cat("   >>>",WC$l,WC$L[WC$l],"\n"); flush.console()
        wc <- fromJSON(rawToChar(WC$wd$content))
        WC$n <- WC$n + 1
        return(wc)
      },
      "open" = {
        if(is.null(WC$f)) { WC$act <- "stop"; next }
        WC$ndj <- file(WC$f,open="r")
        WC$act <- "file"; next 
      },
      "file" = {
        wc <- readLines(con=WC$ndj,n=1)
        if(length(wc)==0){ close(WC$ndj); WC$act <- "stop"; next }
        WC$m <- WC$m + 1; WC$n <- WC$n + 1
        return(fromJSON(wc))
      },
      "stop" = { return(NULL) },
      stop(paste0("No handler for ",WC$act))
    ) 
  }
  stop("Too many errors")
}

processWork <- function(w) {
  # cat("   Process:",WC$n,w$title,"\n"); flush.console()
  Wid <- getID(w$id); hit <- TRUE
  Sid <- getID(w$primary_location$source$id)
  Sname <- w$primary_location$source$display_name 
  pYear <- w$publication_year; pDate <- w$publication_date
  type <- w$type; lang <- w$language
  vol <- w$biblio$volume; iss <- w$biblio$issue
  fPage <- w$biblio$first_page; lPage <- w$biblio$last_page
  title <- w$title; tit <- gsub(";",",",title) 
  autsh <- w$authorships[[1]]
  if(is.null(nrow(autsh))) autsh <- w$authorships
  if(nrow(autsh)==0) { cat("W",WC$n,"no authors info\n",file=WC$tr)
    WC$an <- WC$an + 1; fAName <- paste("Anon",WC$an,sep="")
  } else { fAName <- w$authorships$author$display_name[1]
    if(length(w$authorships)==1) fAName <- w$authorships[[1]]$author$display_name[1]}
  sWname <- Gname(fAName,type,pYear,vol,fPage)
  u <- putWork(Wid,list(sWname=sWname,hit=TRUE,pyear=pYear,type=type,lang=lang))
  # cat(u,Wid,hit,sWname,Sid,pYear,pDate,type,lang,vol,iss,fPage,lPage,fAName,tit,sep=";","\n"); flush.console()
  if(!is.na(Sid)) {j <- putSrc(Sid,list(Sname=Sname)); cat(u,j,"\n",file=wj)}
  cat(u,Wid,hit,sWname,Sid,pYear,pDate,type,lang,vol,iss,fPage,lPage,fAName,tit,
    sep=";",file=wrk); cat("\n",file=wrk)
  refs <- w$referenced_works
  if(length(w$referenced_works)==1) refs <- w$referenced_works[[1]]
  for(wk in refs) {
    vid <- getID(wk) 
    v <- putWork(vid,list(sWname="",hit=FALSE,pyear=0,type="",lang=""))
    cat(v,vid,FALSE,"",NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,sep=";",file=wrk)
    cat("\n",file=wrk); cat(u,v,"\n",file=ci) }
  if(nrow(autsh)==0) {
    v <- putAuth(fAName,list(Aname=fAName)); cat(u,v,"\n",file=wa)
  } else {
    auts <- w$authorships$author
    if(is.null(auts)) auts <- w$authorships[[1]]$author 
    for(a in 1:nrow(auts)) {
      Aid <- getID(auts$id[a]); v <- putAuth(Aid,list(Aname=auts$display_name[a]))
      cat(u,v,"\n",file=wa) } }
}

closeWorks <- function() {close(WC$tr); rm(WC,inherits=TRUE)}


