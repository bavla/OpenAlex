# OpenAlex
# https://github.com/bavla/OpenAlex/tree/main/code
# http://vladowiki.fmf.uni-lj.si/doku.php?id=vlado:work:bib:alex
# by Vladimir Batagelj, March 2024

getID <- function(URLid) substring(URLid,22)

firstup <- function(n) {n <- tolower(n); substr(n,1,1) <- toupper(substr(n,1,1)); n}

Gname <- function(name,ty,py,vl,fp){L <- firstup(unlist(strsplit(name," "))); k <- length(L)
  H <- paste(substr(L[k],1,8),paste(substr(L[1:(k-1)],1,1),sep="",collapse=""),sep="_")
  if(ty=="article") paste(H,"(",py,")",vl,":",fp,sep="") else
    paste(H,"(",py,")",ty,sep="")
}

