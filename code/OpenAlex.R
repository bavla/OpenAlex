# OpenAlex
# https://github.com/bavla/OpenAlex/tree/main/code
# http://vladowiki.fmf.uni-lj.si/doku.php?id=vlado:work:bib:alex
# by Vladimir Batagelj, March 2024
# source("https://raw.githubusercontent.com/bavla/OpenAlex/main/OpenAlex.R")

keys = ls

eDict <- function(size=10000L) new.env(hash=TRUE,parent=emptyenv(),size=size)

putWork <- function(Wid,sWname=""){
  if(exists(Wid,env=works,inherits=FALSE)){
    if(works[[Wid]]["sWname"]!=sWname){
      if(works[[Wid]]["sWname"]=="") {works[[Wid]]["sWname"] <- sWname} else {
        cat("W",length(works),works[[Wid]]["sWname"],sWname,"\n")
        flush.console() }}
  } else works[[Wid]] <- c(wind=length(works)+1,sWname=sWname)
  return(works[[Wid]]["wind"]) 
}

putSrc <- function(Sid,Sname=NA){
  if(exists(Sid,env=srces,inherits=FALSE)){
    if(srces[[Sid]]["Sname"]!=Sname){
      if(is.na(srces[[Sid]]["Sname"])) {srces[[Sid]]["Sname"] <- Sname} else {
        cat("S",length(srces),srces[[Sid]]["Sname"],Sname,"\n")
        flush.console() }}
  } else srces[[Sid]] <- c(sind=length(srces)+1,Sname=Sname)
  return(srces[[Sid]]["sind"]) 
}

putAuth <- function(Aid,Aname=NA){
  sAnam <- ifelse(is.na(Aname),NA,sAname(Aname)) 
  if(exists(Aid,env=auths,inherits=FALSE)){
    if(auths[[Aid]]["Aname"]!=Aname){
      if(is.na(auths[[Aid]]["Aname"])) {auths[[Aid]]["Aname"] <- Aname} else {
        cat("A",length(auths),auths[[Aid]]["Aname"],Aname,"\n")
        flush.console() }}
  } else auths[[Aid]] <- c(aind=length(auths)+1,Aname=Aname,sAname=sAnam)
  return(auths[[Aid]]["aind"]) 
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

