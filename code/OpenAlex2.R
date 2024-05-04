# OpenAlex ver 2. March 27, 2024
# https://github.com/bavla/OpenAlex/tree/main/code
# http://vladowiki.fmf.uni-lj.si/doku.php?id=vlado:work:bib:alex
# by Vladimir Batagelj, March 2024
# source("https://raw.githubusercontent.com/bavla/OpenAlex/main/OpenAlex2.R")

keys = ls

eDict <- function(size=10000L) new.env(hash=TRUE,parent=emptyenv(),size=size)

getVals <- Vectorize(get,vectorize.args="x")

removeDuplicates <- function(inp,out){
  lst <- file(out,"w",encoding="UTF-8")
  cat(unique(read.table(inp)$V1),sep="\n",file=lst)
  close(lst)
}
 
dict2DF <- function(dict,ind) {
  V <- as.data.frame(t(as.data.frame(getVals(keys(dict),dict))))
  colnames(V)[1] <- ind
  for(n in colnames(V)) V[[n]] <- unname(unlist(V[[n]]))
  return(V[order(V[[ind]]),])
}

# Wid -> (wind,hit,cnt,inp,out)
putWork <- function(Wid,hit){ 
  if(exists(Wid,env=works,inherits=FALSE)){
    if(hit){ cat("W duplicate ",Wid,"\n",file=WC$tr)
      works[[Wid]][["cnt"]] <- works[[Wid]][["cnt"]]+1 
    } else works[[Wid]][["inp"]] <- works[[Wid]][["inp"]]+1
  } else {
    works[[Wid]] <- list(wind=length(works)+1,cnt=0,inp=0,out=0)
    if(hit) works[[Wid]][["cnt"]] <- 1 else works[[Wid]][["inp"]] <- 1 
  }
  return(works[[Wid]][["wind"]])
}

# Sid -> (sind)
putSrc <- function(Sid){
  if(!exists(Sid,env=srces,inherits=FALSE)){
    srces[[Sid]] <- list(sind=length(srces)+1,cnt=0)
  }
  srces[[Sid]][["cnt"]] <- srces[[Sid]][["cnt"]]+1
  return(srces[[Sid]][["sind"]]) 
}

# Aid -> (aind)
putAuth <- function(Aid,par=list(Aname=NA)){
  if(!exists(Aid,env=auths,inherits=FALSE)){
    auths[[Aid]] <- list(aind=length(auths)+1,cnt=0)
  }
  auths[[Aid]][["cnt"]] <- auths[[Aid]][["cnt"]]+1
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
  if(length(query)>0) {
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
        Works <- paste(WC$works,"/",WC$L[WC$l],sep="")
        WC$wd <- GET(Works,query=list(select=WC$Q[["select"]]))
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

processWorkCite <- function(w) {
  # cat(">>> Process:",WC$n,w$title,"\n"); flush.console()
  Wid <- getID(w$id); hit <- TRUE
  u <- putWork(Wid,hit=TRUE)
  # if(u==0) {cat(">>> duplicate ",Wid,"\n",file=WC$tr); return(NULL)}
  ## Sid <- getID(w$primary_location$source$id)
  ## if(length(Sid)==0) Sid <- "Sunknown"
  pYear <- w$publication_year; pDate <- w$publication_date
  type <- w$type; lang <- w$language
  ## vol <- w$biblio$volume; iss <- w$biblio$issue
  ## fPage <- w$biblio$first_page; lPage <- w$biblio$last_page
  title <- w$title; tit <- gsub(";",",",title) 
  ## autsh <- w$authorships
  ## if(typeof(autsh)=="list") if(length(autsh)>0) autsh <- w$authorships[[1]]
  ## if(length(autsh)==0) {# cat("W",WC$n,"no authors info\n",file=WC$tr)
  ##   WC$an <- WC$an + 1; fAName <- paste("Anon",WC$an,sep="")
  ## } else { fAName <- w$authorships$author$display_name[1]
  ##   if(length(w$authorships)==1) fAName <- w$authorships[[1]]$author$display_name[1]}
  ## sWname <- Gname(fAName,type,pYear,vol,fPage)
  sWname <- Wid
  # cat(u,Wid,hit,sWname,Sid,pYear,pDate,type,lang,vol,iss,fPage,lPage,fAName,tit,sep=";","\n"); flush.console()
  ## if(!is.na(Sid)) {j <- putSrc(Sid); cat(u,j,"\n",file=wj)}
  cat(u,Wid,hit,sWname,pYear,pDate,type,lang,tit,sep=";",file=wrk); cat("\n",file=wrk)
  ## cat(u,Wid,hit,sWname,Sid,pYear,pDate,type,lang,vol,iss,fPage,lPage,fAName,tit,
  ##   sep=";",file=wrk); cat("\n",file=wrk)
  refs <- w$referenced_works
  if(length(w$referenced_works)==1) refs <- w$referenced_works[[1]]
  works[[Wid]][["out"]] <- length(refs)
  for(wk in refs) {
    vid <- getID(wk) 
    v <- putWork(vid,hit=FALSE)
    cat(v,vid,FALSE,"",NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,sep=";",file=wrk)
    cat("\n",file=wrk); 
    cat(u,v,"\n",file=ci) }
  ## if(length(autsh)==0) {
  ##   v <- putAuth(fAName); cat(u,v,"\n",file=wa)
  ## } else {
  ##   auts <- w$authorships$author
  ##   if(is.null(auts)) if(length(w$authorships)>0)
  ##     auts <- w$authorships[[1]]$author 
  ##   if(length(auts)>0) for(a in 1:nrow(auts)) {
  ##     Aid <- getID(auts$id[a]); v <- putAuth(Aid)
  ##     cat(u,v,"\n",file=wa) } }
}

processWork <- function(w) {
  # cat(">>> Process:",WC$n,w$title,"\n"); flush.console()
  Wid <- getID(w$id); hit <- TRUE
  u <- putWork(Wid,hit=TRUE)
  # if(u==0) {cat(">>> duplicate ",Wid,"\n",file=WC$tr); return(NULL)}
  Sid <- getID(w$primary_location$source$id)
  if(length(Sid)==0) Sid <- "Sunknown"
  pYear <- w$publication_year; pDate <- w$publication_date
  type <- w$type; lang <- w$language
  vol <- w$biblio$volume; iss <- w$biblio$issue
  fPage <- w$biblio$first_page; lPage <- w$biblio$last_page
  title <- w$title; tit <- gsub(";",",",title) 
  autsh <- w$authorships
  if(typeof(autsh)=="list") if(length(autsh)>0) autsh <- w$authorships[[1]]
  if(length(autsh)==0) {# cat("W",WC$n,"no authors info\n",file=WC$tr)
    WC$an <- WC$an + 1; fAName <- paste("Anon",WC$an,sep="")
  } else { fAName <- w$authorships$author$display_name[1]
    if(length(w$authorships)==1) fAName <- w$authorships[[1]]$author$display_name[1]}
  sWname <- Gname(fAName,type,pYear,vol,fPage)
  # cat(u,Wid,hit,sWname,Sid,pYear,pDate,type,lang,vol,iss,fPage,lPage,fAName,tit,sep=";","\n"); flush.console()
  if(!is.na(Sid)) {j <- putSrc(Sid); cat(u,j,"\n",file=wj)}
  cat(u,Wid,hit,sWname,Sid,pYear,pDate,type,lang,vol,iss,fPage,lPage,fAName,tit,
    sep=";",file=wrk); cat("\n",file=wrk)
  refs <- w$referenced_works
  if(length(w$referenced_works)==1) refs <- w$referenced_works[[1]]
  works[[Wid]][["out"]] <- length(refs)
  for(wk in refs) {
    vid <- getID(wk) 
    v <- putWork(vid,hit=FALSE)
    cat(v,vid,FALSE,"",NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,sep=";",file=wrk)
    cat("\n",file=wrk); 
    cat(u,v,"\n",file=ci) }
  if(length(autsh)==0) {
    v <- putAuth(fAName); cat(u,v,"\n",file=wa)
  } else {
    auts <- w$authorships$author
    if(is.null(auts)) if(length(w$authorships)>0)
      auts <- w$authorships[[1]]$author 
    if(length(auts)>0) for(a in 1:nrow(auts)) {
      Aid <- getID(auts$id[a]); v <- putAuth(Aid)
      cat(u,v,"\n",file=wa) } }
}

closeWorks <- function() {close(WC$tr); rm(WC,inherits=TRUE)}

OpenAlex2PajekCite <- function(Q,nrun,netF="PajekCite.net",listF=NULL,save=FALSE,saveF="saveCite.ndjson",step=500){
  if(save) {json <<- file(saveF,"w",encoding="UTF-8")}
  if(is.null(listF)) listW <- NULL else listW <- unique(read.table(listF)$V1) # list of works
  cat("OpenAlex2Pajek / Cite - Start",date(),"\n")
  ci <<- file("Ci.tmp","w",encoding="UTF-8"); wrk <<- file("works.csv","w",encoding="UTF-8")
  cat("% OpenAlex2Pajek / Cite",date(),"\n",file=ci); cat("% OpenAlex2Pajek / Cite",date(),"\n",file=wrk)
  # cat("ind;Wid;hit;sWname;Sid;pYear;pDate;type;lang;vol;iss;fPage;lPage;fAName;title\n",file=wrk)
  works <<- eDict() 
  openWorks(query=Q,list=listW,file=NULL) 
  # print(ls.str(WC))
  cat("*** OpenAlex2Pajek / Cite - Process",date(),"\n"); flush.console()
  repeat{
    w <- nextWork()
    if(is.null(w)) break
    if(save) write(toJSON(w),file=json)
    if(WC$n %% step==0) cat(date()," n =",WC$n,"\n"); flush.console()
    tryCatch(
      processWorkCite(w),
      error=function(e){ WC$er <- WC$er + 1; cat("W",WC$n,w$id,WC$er,"\n")
        print(e); flush.console();
        if(WC$er > 20) stop("To many errors") }  )
  }
  cat("*** OpenAlex2Pajek / Cite - Data Collected",date(),"\n"); flush.console()
  # print(ls.str(WC))
  close(ci); close(wrk)
  if(save) close(json)
  cat("hits:",WC$n,"works:",length(works),"\n")
  # Citation Cite
  U <- dict2DF(works,"wind"); n <- nrow(U)
  net <- file(netF,"w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=net)
  cat("% OpenAlex2Pajek / Cite",date(),"\n*vertices",n,"\n",file=net)
  Ci <- read.csv("Ci.tmp",sep="",head=FALSE,skip=1,encoding="UTF-8")
  for(i in 1:n) cat(i,' "',row.names(U)[i],'"\n',sep="",file=net)
  cat("*arcs\n",file=net)
  for(i in 1:nrow(Ci)) cat(Ci$V1[i],Ci$V2[i],"\n",file=net)
  close(net); rm(Ci)
  cat("*** OpenAlex2Pajek / Cite - Stop",date(),"\n"); flush.console()
  closeWorks() 
}


