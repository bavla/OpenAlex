# OpenAlex2Pajek ver 4. March 18, 2024 / May 11, 2024 / June 18, 2024 
# https://github.com/bavla/OpenAlex/tree/main/code
# http://vladowiki.fmf.uni-lj.si/doku.php?id=vlado:work:bib:alex
# by Vladimir Batagelj, March 2024
# source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2Pajek.R")
# http://localhost:8800/doku.php?id=work:bib:alex
#

# library(xml2)
# library(httr)
# library(jsonlite)

# version 0. March 18, 2024
# version 1. March 22, 2024; added partitions pYear, hit, type, lang
# version 2. May 5, 2024; OpenAlex2Pajek split to Cite and All parts
# version 3. May 11, 2024; Collaboration between countries
# version 4. June 18, 2024; Problem with the NULL values, sourceNames
# version 5. May 4-6, 2025; OpenAlexSources, unitsInfo
# version 6. May 18. 2025; unitsInfo(order)

selPub  <- "id,primary_location,title,publication_year,cited_by_count,countries_distinct_count"
selRef  <- "biblio,type,language,referenced_works_count,referenced_works"
selAut  <- "authorships,keywords,publication_date"
selCite <- paste(selPub,selRef,sep=",") 
selAll  <- paste(selCite,selAut,sep=",") 
selInfo <- "id,title,type,publication_year"

keys = ls

eDict <- function(size=10000L) new.env(hash=TRUE,parent=emptyenv(),size=size)

setDic <- function(dic,did,att,val)
  if(!is.null(val)) dic[[did]][[att]] <- val

getVals <- Vectorize(get,vectorize.args="x")

getISO <- function(URLid) substring(URLid,32)

Fn <- function(F) paste0(WC$name,F)

removeDuplicates <- function(inp,out){
  lst <- file(out,"w",encoding="UTF-8")
  cat(unique(read.table(inp)$V1),sep="\n",file=lst)
  close(lst)
}

joinLists <- function(oldF,newF,lstF){
  lst <- file(lstF,"w",encoding="UTF-8")
  if(is.null(oldF)) old <- c() else old <- read.table(oldF)$V1
  new <- read.table(newF)$V1 
  list <- union(old,new); OiN <- intersect(old,new)
  OmN <- setdiff(old,new); NmO <- setdiff(new,old)
  cat("O∩N =",length(OiN)," O\\N =",length(OmN),
    " N\\O =",length(NmO)," O∪N =",length(list),"\n")
  cat(as.vector(list),sep="\n",file=lst)
  close(lst)
}

# https://stackoverflow.com/questions/23541137/r-environment-to-data-frame
# https://sparkbyexamples.com/r-programming/convert-list-to-r-dataframe/
dict2DF <- function(dict,ind) {
  DF <- as.data.frame(do.call(rbind, as.list(dict)))
  return(DF[order(unlist(unname(DF[[ind]]))),])
}

saveClu <- function(V,lab="clustering",file="Cling",na=99999){ 
  V <- unlist(unname(V))
  cat(paste0(">>> ",lab,"\n")); flush.console(); n <- length(V)
  V[is.na(V)] <- na
  clu <- file(Fn(paste0(file,".clu")),"w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=clu)
  cat("% OpenAlex2Pajek / All -",lab,date(),"\n*vertices",n,"\n",file=clu)
  for(i in 1:length(V)) cat(V[i],'\n',sep="",file=clu)
  close(clu)
}

saveFac <- function(V,lab="clustering",file="Cling",na=0){ 
  V <- unlist(unname(V))
  cat(paste0(">>> ",lab,"\n")); flush.console(); n <- length(V)
  clu <- file(Fn(paste0(file,".clu")),"w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=clu)
  cat("% OpenAlex2Pajek / All -",lab,date(),"\n",file=clu)
  T <- factor(V); L <- levels(T); T <- as.integer(T); T[is.na(T)] <- na
  cat("% ",paste(1:length(L),L,sep="-"),sep=", ","\n",file=clu)
  cat("*vertices",n,"\n",file=clu)
  for(i in 1:length(V)) cat(T[i],'\n',sep="",file=clu)
  close(clu)
}

saveCite <- function(U,name,lab,file,names=FALSE){
  o.scipen <- options("scipen")$scipen; options(scipen=999)
  cat(paste0(">>> ",lab,"\n")); flush.console(); n <- nrow(U)
  net <- file(Fn("Ci.net"),"w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=net)
  cat("% OpenAlex2Pajek /",lab,date(),"\n*vertices",n,"\n",file=net)
  Ci <- read.csv("Ci.tmp",sep="",head=FALSE,skip=1,encoding="UTF-8")
  for(i in 1:n) cat(i,' "',row.names(U)[i],'"\n',sep="",file=net)
  cat("*arcs\n",file=net)
  for(i in 1:nrow(Ci)) cat(Ci$V1[i],Ci$V2[i],"\n",file=net)
  close(net) 
  if(names){
    sn <- unlist(unname(U$sWname))
    nam <- file(Fn("W.nam"),"w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=nam)
    cat("% OpenAlex2Pajek /",lab,date(),"\n*vertices",n,"\n",file=nam)
    for(i in 1:n) cat(i,' "',ifelse(is.na(sn[i]),row.names(U)[i],sn[i]),
      '"\n',sep="",file=nam)
    close(nam)
  }
  options(scipen=o.scipen)
}

saveTwoMode <- function(U,name,dict,ind,lab,file,names=FALSE,nind=NA){
  o.scipen <- options("scipen")$scipen; options(scipen=999)
  cat(paste0(">>> ",lab,"\n")); flush.console()
  DF <- dict2DF(dict,ind);  m <- nrow(DF); n <- nrow(U)
  net <- file(Fn(paste0(file,".net")),"w",encoding="UTF-8")
  cat('\xEF\xBB\xBF',file=net)
  cat("% OpenAlex2Pajek / All -",lab,date(),"\n*vertices",n+m,n,"\n",file=net)
  WX <- read.csv(paste0(file,".tmp"),sep="",head=FALSE,skip=1,encoding="UTF-8")
  for(i in 1:n) cat(i,' "',row.names(U)[i],'"\n',sep="",file=net)
  for(i in 1:m) cat(n+i,' "',row.names(DF)[i],'"\n',sep="",file=net)
  cat("*arcs\n",file=net)
  for(i in 1:nrow(WX)) cat(WX$V1[i],n+WX$V2[i],"\n",file=net)
  close(net)
  if(names){
    sn <- unlist(unname(DF[[nind]]))
    nam <- file(Fn(paste0(file,".nam")),"w",encoding="UTF-8")
    cat('\xEF\xBB\xBF',file=nam)
    cat("% OpenAlex2Pajek / All - names:",lab,date(),"\n*vertices",m,"\n",file=nam)
    # for(i in 1:n) cat(i,' "',row.names(U)[i],'"\n',sep="",file=nam)
    for(i in 1:m) cat(i,' "',ifelse(is.na(sn[i]),row.names(DF)[i],sn[i]),
      '"\n',sep="",file=nam)
    close(nam)
  }
  options(scipen=o.scipen)
}

# Wid -> (wind,cnt,inp,out,py,cbc,typ,lan,cdc,sWname)
putWork <- function(Wid,hit){ 
  if(exists(Wid,env=works,inherits=FALSE)){
    if(hit){ cat("W duplicate ",Wid,"\n",file=WC$tr)
      works[[Wid]][["cnt"]] <- works[[Wid]][["cnt"]]+1 
    } else works[[Wid]][["inp"]] <- works[[Wid]][["inp"]]+1
  } else {
    works[[Wid]] <- list(wind=length(works)+1,cnt=0,inp=0,out=0,py=NA,cbc=0,
      typ=NA,lan=NA,cdc=0,sWname=NA)
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

# Aid -> (aind, Aname)
putAuth <- function(Aid,Aname=NA){
  if(!exists(Aid,env=auths,inherits=FALSE)){
    auths[[Aid]] <- list(aind=length(auths)+1,cnt=0,Aname=Aname)
  }
  auths[[Aid]][["cnt"]] <- auths[[Aid]][["cnt"]]+1
  if(is.na(auths[[Aid]][["Aname"]])) if(!is.na(Aname)) auths[[Aid]][["Aname"]] <- Aname
  return(auths[[Aid]][["aind"]]) 
}

# key -> (kind)
putKeyw <- function(key){
  if(!exists(key,env=keyws,inherits=FALSE)){
    keyws[[key]] <- list(kind=length(keyws)+1,cnt=0)
  }
  keyws[[key]][["cnt"]] <- keyws[[key]][["cnt"]]+1
  return(keyws[[key]][["kind"]]) 
}

# cty -> (cind)
putCtry <- function(cty){
  if(!exists(cty,env=cntrs,inherits=FALSE)){
    cntrs[[cty]] <- list(cind=length(cntrs)+1,cnt=0)
  }
  cntrs[[cty]][["cnt"]] <- cntrs[[cty]][["cnt"]]+1
  return(cntrs[[cty]][["cind"]]) 
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

openWorks <- function(query=NULL,list=NULL,file=NULL,name){
  WC <<- new.env(hash=TRUE,parent=emptyenv())
  WC$works <- "https://api.openalex.org/works"
  WC$Q <- query; WC$L <- list; WC$f <- file; WC$name <- name
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
  pYear <- w$publication_year; pDate <- w$publication_date
  type <- w$type; lang <- w$language
  cdc <- w$countries_distinct_count; cbc <- w$cited_by_count
  title <- w$title; tit <- gsub(";",",",title) 
  sWname <- Wid
  # cat(u,Wid,hit,sWname,Sid,pYear,pDate,type,lang,vol,iss,fPage,lPage,fAName,tit,sep=";","\n"); flush.console()
  cat(u,Wid,hit,sWname,pYear,pDate,type,lang,tit,sep=";",file=wrk); cat("\n",file=wrk)
  refs <- w$referenced_works
  if(length(w$referenced_works)==1) refs <- w$referenced_works[[1]]
  setDic(works,Wid,"py",pYear); setDic(works,Wid,"typ",type)
  setDic(works,Wid,"cbc",cbc); setDic(works,Wid,"cdc",cdc)
  setDic(works,Wid,"out",length(refs)); setDic(works,Wid,"lan",lang)
  for(rwk in refs) {
    vid <- getID(rwk) 
    v <- putWork(vid,hit=FALSE)
    cat(v,vid,FALSE,"",NA,NA,NA,NA,NA,sep=";",file=wrk)
    cat("\n",file=wrk); 
    cat(u,v,"\n",file=ci) }
}

processWork <- function(w,test) {
  # cat(">>> Process:",WC$n,w$title,"\n"); flush.console()
  Wid <- getID(w$id); hit <- TRUE;  u <- putWork(Wid,hit=TRUE)
  # if(u==0) {cat(">>> duplicate ",Wid,"\n",file=WC$tr); return(NULL)}
  Sid <- getID(w$primary_location$source$id)
  if(length(Sid)==0) Sid <- "Sunknown"
  pYear <- w$publication_year; pDate <- w$publication_date
  type <- w$type; lang <- w$language
  vol <- w$biblio$volume; iss <- w$biblio$issue
  fPage <- w$biblio$first_page; lPage <- w$biblio$last_page
  cdc <- w$countries_distinct_count; cbc <- w$cited_by_count
  setDic(works,Wid,"py",pYear); setDic(works,Wid,"lan",lang)
  setDic(works,Wid,"cbc",cbc); setDic(works,Wid,"cdc",cdc)
  setDic(works,Wid,"typ",type)
  title <- w$title; tit <- gsub(";",",",title) 
  autsh <- w$authorships
  if(typeof(autsh)=="list") if(length(autsh)>0) autsh <- w$authorships[[1]]
  if(length(autsh)==0) {# cat("W",WC$n,"no authors info\n",file=WC$tr)
    WC$an <- WC$an + 1; fAName <- paste("Anon",WC$an,sep="")
  } else { fAName <- w$authorships$author$display_name[1]
    if(length(w$authorships)==1) fAName <- w$authorships[[1]]$author$display_name[1]}
  sWname <- Gname(fAName,type,pYear,vol,fPage)
  setDic(works,Wid,"sWname",sWname)
  # cat(u,Wid,hit,sWname,Sid,pYear,pDate,type,lang,vol,iss,fPage,lPage,fAName,tit,sep=";","\n"); flush.console()
  if(!is.na(Sid)) {j <- putSrc(Sid); cat(u,j,"\n",file=wj)}
  cat(u,Wid,hit,sWname,Sid,pYear,pDate,type,lang,vol,iss,fPage,lPage,cdc,cbc,fAName,tit,
    sep=";",file=wrk); cat("\n",file=wrk)
  refs <- w$referenced_works
  if(length(w$referenced_works)==1) refs <- w$referenced_works[[1]]
  setDic(works,Wid,"out",length(refs))
  for(wr in refs) {
    vid <- getID(wr) 
    v <- putWork(vid,hit=FALSE)
    cat(v,vid,FALSE,"",NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,sep=";",file=wrk)
    cat("\n",file=wrk); 
    cat(u,v,"\n",file=ci) }
  if(length(autsh)==0) {
    v <- putAuth(fAName,fAName); cat(u,v,"\n",file=wa)
  } else {
    auts <- w$authorships$author; cntries <- w$authorships$countries;
    if(is.null(auts)) if(length(w$authorships)>0) {
      auts <- w$authorships[[1]]$author; cntries <- w$authorships[[1]]$countries }  
    if(length(auts)>0) {
      for(a in 1:nrow(auts)) {
        Aname <- auts$display_name[a]; Aid <- getID(auts$id[a])
        v <- putAuth(Aid,Aname); cat(u,v,"\n",file=wa) 
    } } 
    if(is.null(auts)) if(length(w$authorships)>0) auts <- w$authorships[[1]]$author
    cns <- union(c(),unlist(cntries))
    for(ct in cns) {v <- putCtry(ct); cat(u,v,"\n",file=wl)}   
  }
  knams <- w$keywords$display_name
  if(is.null(knams)) if(length(w$keywords)>0) knams <- w$keywords[[1]]$display_name
  for(key in knams) {v <- putKeyw(key); cat(u,v,"\n",file=wk)} 
}

closeWorks <- function() {close(WC$tr); rm(WC,inherits=TRUE)}

OpenAlex2PajekCite <- function(Q,nrun,name="test",listF=NULL,save=FALSE,
    saveF="saveCite.ndjson",prop=FALSE,step=500,test=0){
  if(save) json <<- file(saveF,"w",encoding="UTF-8")
  if(is.null(listF)) listW <- NULL else listW <- unique(read.table(listF)$V1) # list of works
  cat("OpenAlex2Pajek / Cite - Start",date(),"\n")
  ci <<- file("Ci.tmp","w",encoding="UTF-8"); wrk <<- file("works.csv","w",encoding="UTF-8")
  cat("% OpenAlex2Pajek / Cite",date(),"\n",file=ci); cat("% OpenAlex2Pajek / Cite",date(),"\n",file=wrk)
  # cat("ind;Wid;hit;sWname;Sid;pYear;pDate;type;lang;vol;iss;fPage;lPage;fAName;title\n",file=wrk)
  works <<- eDict() 
  openWorks(query=Q,list=listW,file=NULL,paste0(name,nrun)) 
  if(test>1) print(ls.str(WC))
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
  if(test>1) print(ls.str(WC))
  close(ci); close(wrk)
  if(save) close(json)
  cat("hits:",WC$n,"works:",length(works),"\n")
  # Citation Cite
  U <- dict2DF(works,"wind"); n <- nrow(U)
  saveCite(U,name,"Citation Cite","Ci")
  # properties
  if(prop){
    saveClu(U$py,"publication year","Year")
    saveFac(U$typ,"type of publication","Type")
    saveFac(U$lan,"language of publication","Lang")
    saveClu(U$cbc,"cited by count","Cbc")
    saveClu(U$cdc,"countries distinct count","Cdc")
    saveClu(U$out,"referenced works","Out")
  }
  cat("*** OpenAlex2Pajek / Cite - Stop",date(),"\n"); flush.console()
  # close(WC$tr) 
  closeWorks() 
}

OpenAlex2PajekAll <- function(Q,name="test",listF=NULL,save=FALSE,
  saveF="saveCite.ndjson",step=500,test=0){
  if(save) json <<- file(saveF,"w",encoding="UTF-8")
  if(is.null(listF)) listW <- NULL else listW <- unique(read.table(listF)$V1) # list of works
  cat("OpenAlex2Pajek / All - Start",date(),"\n")
  ci <<- file("Ci.tmp","w",encoding="UTF-8"); wrk <<- file("works.csv","w",encoding="UTF-8")
  wa <<- file("WA.tmp","w",encoding="UTF-8"); wj <<- file("WJ.tmp","w",encoding="UTF-8");
  wk <<- file("WK.tmp","w",encoding="UTF-8"); wl <<- file("WC.tmp","w",encoding="UTF-8");
  cat("% OpenAlex2Pajek / All",date(),"\n",file=ci); cat("% OpenAlex2Pajek / All",date(),"\n",file=wrk)
  cat("% OpenAlex2Pajek / All",date(),"\n",file=wa); cat("% OpenAlex2Pajek / All",date(),"\n",file=wj)
  cat("% OpenAlex2Pajek / All",date(),"\n",file=wk); cat("% OpenAlex2Pajek / All",date(),"\n",file=wl);
  # cat("ind;Wid;hit;sWname;Sid;pYear;pDate;type;lang;vol;iss;fPage;lPage;fAName;title\n",file=wrk)
  cat("ind;Wid;hit;sWname;Sid;pYear;pDate;type;lang;vol;iss;fPage;lPage;cdc;cbc;fAName;title\n",file=wrk)
  works <<- eDict(); srces <<- eDict(); auths <<- eDict(); keyws <<- eDict(); cntrs <<- eDict()
  openWorks(query=Q,list=listW,file=NULL,name) 
  if(test>1) print(ls.str(WC))
  cat("*** OpenAlex2Pajek / All - Process",date(),"\n"); flush.console()
  repeat{
    w <- nextWork()
    if(is.null(w)) break
    if(save) write(toJSON(w),file=json)
    if(WC$n %% step==0) cat(date()," n =",WC$n,"\n"); flush.console()
    tryCatch(
      processWork(w,test),
      error=function(e){ WC$er <- WC$er + 1; cat("W",WC$n,w$id,WC$er,"\n")
        print(e); flush.console();
        if(WC$er > 20) stop("To many errors") }  )
  }
  cat("*** OpenAlex2Pajek / All - Data Collected",date(),"\n"); flush.console()
  if(test>1) print(ls.str(WC))
  close(ci); close(wrk); close(wa); close(wj); close(wk); close(wl)
  if(save) close(json)
  cat("hits:",WC$n,"works:",length(works),"authors:",length(auths),
    "anon:",WC$an,"sources:",length(srces),"\n"); flush.console()
  U <- dict2DF(works,"wind"); n <- nrow(U)
  saveCite(U,name,"Citation Cite","Ci",TRUE)
  # properties
  saveClu(U$py,"publication year","Year")
  saveFac(U$typ,"type of publication","Type")
  saveFac(U$lan,"language of publication","Lang")
  saveClu(U$cbc,"cited by count","Cbc")
  saveClu(U$cdc,"countries distinct count","Cdc")
  saveClu(U$out,"referenced works","Out")
  # two-mode networks
  saveTwoMode(U,name,auths,"aind","Authorship WA","WA",TRUE,"Aname")
  saveTwoMode(U,name,srces,"sind","Sources WJ","WJ")
  saveTwoMode(U,name,cntrs,"cind","Countries WC","WC")
  saveTwoMode(U,name,keyws,"kind","Keywords WK","WK")
  cat("*** OpenAlex2Pajek / All - Stop",date(),"\n"); flush.console()
  # close(WC$tr) 
  closeWorks() 
}

sourceNames <- function(netF="WJ.net",namF="Sources.nam",step=500){
  cat("OpenAlex2Pajek - Names of sources",date(),"\n")
  net <- file(netF,"r"); nam <- file(namF,"w")
  line <- readLines(net,n=1); n <- 1
  while(substr(line,1,1)!="*") {line <- readLines(net,n=1); n <- n+1}
  S <- unlist(strsplit(line," "))
  n1 <- as.integer(S[3]); n2 <- as.integer(S[2])-n1
  close(net)
  L <- read.table(netF,skip=n+n1,nrows=n2)$V2
  cat("% OpenAlex2Pajek - names of sources",date(),"\n",file=nam)
  cat("*vertices ",n2,"\n",file=nam)
  cat("# of vertices = ",n2,"\n"); flush.console()
  for(i in 1:length(L)){ 
    if(i %% step==0) cat(date()," n =",i,"\n"); flush.console()
    src <- paste0("https://api.openalex.org/sources/",L[i])
    wd <- GET(src,query=list(select="id,display_name"))
    if(wd$status_code!=200) {cat(i,L[i],"GET error\n"); flush.console() 
      cat(format(i,width=6),' "',L[i],'"\n',sep='',file=nam); next}
    wc <- fromJSON(rawToChar(wd$content))
    cat(format(i,width=6),' "',wc$display_name,'"\n',sep='',file=nam)
  }
  close(nam); cat("Finished",date(),"\n"); flush.console()
}

coAuthorship <- function(CC,year=NULL){
  n <- length(CC)
  M <- matrix(0,nrow=n,ncol=n); rownames(M) <- colnames(M) <- CC
  T <- rep(0,n); names(T) <- CC; G <- rep(0,n); names(G) <- CC
  Q1 <- "https://api.openalex.org/works?filter=authorships.countries:"
  Q3 <- ",countries_distinct_count:>1&group-by=authorships.countries"
  if(is.null(year)) lab <- "\nComplete search" else { 
    lab <- paste0("\nYear =",year); Q3 <- paste0(",publication_year:",year,Q3)}
  cat(lab,date(),"\n"); flush.console()
  for(cy in CC){
    Q <- paste0(Q1,cy,Q3)
    S <- GET(Q)
    C <- fromJSON(rawToChar(S$content))
    D <- C$group_by; T[cy] <- C$meta$count; G[cy] <- C$meta$groups_count
    J <- unname(sapply(D$key,getISO))
    if(length(J)>0){
      V <- D$count; names(V) <- J
      for(j in J) M[cy,j] <- V[j]
    }
  }
  cat("collected",date(),"\n"); flush.console()
  k <- 0; a <- 0; dm <- 0
  for(i in 2:n){
    for(j in 1:(i-1)){
      if(M[i,j]!=M[j,i]) { 
        if(min(M[i,j],M[j,i])==0) { m <- max(M[i,j],M[j,i])
          M[i,j] <- M[j,i] <- m; k <- k+1
        } else {a <- a+1; d <- M[i,j]-M[j,i]; dm <- max(abs(d),dm) 
          cat(i,j,CC[i],CC[j],M[i,j],M[j,i],d,"\n")}
      }
    }
  }
  cat("k =",k,"  a =",a,"  dmax =",dm,"\n"); flush.console()
  return(list(T=T,G=G,M=M))
}

authors <- function(L) {A <- L$authorships; k <- length(A); N <- rep("",k)
  for (i in 1:k) N[i] <- paste(A[i][[1]]$author$display_name,collapse=", ")
  return(N)
}
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
# --- save ---
  W <- union(Wout$id,union(Win$id,Wj$id))
  cat(length(W),"different works",date(),"\n"); flush.console() 
  return(W)
}

unitsInfo <- function(IDs=NULL,units="works",select="id",trace=TRUE,cond="",order="alpha"){
  Units <- paste0("https://api.openalex.org/",units) 
  W <- NULL; ri <- 0; nj <- length(IDs)
  while(TRUE) {
    li <- ri+1; ri <- min(ri+50,nj)
    if(li > ri) break
    wID <- paste(IDs[li:ri],collapse="|")
    Q <- list(filter=paste0("openalex:",wID,cond),select=select,per_page="200",page="1")
    wd <- GET(Units,query=Q)
    if(wd$status_code!=200) {cat("Error:",wd$status_code,"\n"); flush.console(); next}
    wc <- fromJSON(rawToChar(wd$content))
    df <- wc$results; nr <- nrow(df)
    if(trace){cat("li =",li," ri =",ri," nr =",nr,"\n"); flush.console()}
    if(nr>0){df$id <- getID(df$id); W <- rbind(W,df)}
  }
  if(order=="alpha") return(W[order(W$id),]) else return(W[match(IDs,W$id),])
}




