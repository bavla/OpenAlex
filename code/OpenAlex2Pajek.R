# OpenAlex2Pajek ver 1. March 22, 2024
# source("OpenAlex2Pajek.R")

# library(httr)
# library(jsonlite)
# source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex.R")
source("OpenAlex1.R")

# VBlist <- read.table("VladoWorks.csv")$V1
Q <- list(
  search="handball",
#  filter="publication_year:2015",
  select="id,primary_location,publication_year,publication_date,type,language,biblio,title,authorships,countries_distinct_count,cited_by_count,referenced_works_count,referenced_works",
  per_page="200"
#  per_page="3"
)
save <- TRUE; step <- 500
if(save) json <- file("save.ndjson","w",encoding="UTF-8")

cat("OpenAlex2Pajek - Start",date(),"\n")
ci <- file("Ci.tmp","w",encoding="UTF-8"); wa <- file("WA.tmp","w",encoding="UTF-8")
wj <- file("WJ.tmp","w",encoding="UTF-8"); wrk <- file("works.csv","w",encoding="UTF-8")
cat("% OpenAlex",date(),"\n",file=wa); cat("% OpenAlex",date(),"\n",file=wj)
cat("% OpenAlex",date(),"\n",file=ci); cat("% OpenAlex",date(),"\n",file=wrk)
cat("ind;Wid;hit;sWname;Sid;pYear;pDate;type;lang;vol;iss;fPage;lPage;fAName;title\n",file=wrk)

works <- eDict(); srces <- eDict(); auths <- eDict();

# openWorks(query=Q,list=VBlist,file="manual.ndjson")
# openWorks(query=Q,list=NULL,file="save.ndjson")
# openWorks(query=Q,list=VBlist,file=NULL)
openWorks(query=Q,list=NULL,file=NULL)
# print(ls.str(WC))
cat("*** OpenAlex2Pajek - Start",date(),"\n"); flush.console()
repeat{
  w <- nextWork()
  if(is.null(w)) break
  if(save) write(toJSON(w),file=json)
  if(WC$n %% step==0) cat(date()," n =",WC$n,"\n"); flush.console()
  tryCatch(
    processWork(w),
    error=function(e){ WC$er <- WC$er + 1; cat("W",WC$n,w$id,WC$er,"\n")
      print(e); flush.console();
      if(WC$er > 20) stop("To many errors") }  )
}
cat("*** OpenAlex2Pajek - Data Collected",date(),"\n"); flush.console()
# print(ls.str(WC))
close(ci);  close(wa); close(wj); close(wrk)
if(save) close(json)
cat("hits:",WC$n,"works:",length(works),"authors:",length(auths),
  "anon:",WC$an,"sources:",length(srces),"\n")

# Citation Cite
U <- dict2DF(works,"wind")
n <- nrow(U)
net <- file("Cite.net","w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=net)
nam <- file("Works.nam","w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=nam)
cat("% OpenAlex2Pajek",date(),"\n*vertices",n,"\n",file=net)
cat("% OpenAlex2Pajek",date(),"\n*vertices",n,"\n",file=nam)
Ci <- read.csv("Ci.tmp",sep="",head=FALSE,skip=1,encoding="UTF-8")
for(i in 1:n){
  cat(i,' "',row.names(U)[i],'"\n',sep="",file=net)
  cat(i,' "',ifelse(U[["sWname"]][i]=="",row.names(U)[i],U[["sWname"]][i]),'"\n',sep="",file=nam)
}
cat("*arcs\n",file=net)
for(i in 1:nrow(Ci)) cat(Ci$V1[i],Ci$V2[i],"\n",file=net)
close(net); close(nam) 
# publication year
cly <- file("year.clu","w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=cly)
cat("% OpenAlex2Pajek - publication year",date(),"\n*vertices",n,"\n",file=cly)
for(i in 1:n) cat(U$pyear[i],'\n',sep="",file=cly)
close(cly)
# hit 
clh <- file("DC.clu","w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=clh)
cat("% OpenAlex2Pajek - hit",date(),"\n*vertices",n,"\n",file=clh)
H <- as.integer(U$hit)
for(i in 1:n) cat(H[i],'\n',sep="",file=clh)
close(clh); rm(H)
# type of publication 
clt <- file("type.clu","w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=clt)
cat("% OpenAlex2Pajek / type of publication",date(),"\n*vertices",n,"\n",file=clt)
T <- factor(U$type); L <- levels(T)
cat("% ",paste(1:length(L),L,sep="-"),sep=", ","\n",file=clt)
for(i in 1:n) cat(T[i],'\n',sep="",file=clt)
close(clt); rm(T)
# language of publication 
cll <- file("lang.clu","w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=cll)
cat("% OpenAlex2Pajek - language of publication",date(),"\n*vertices",n,"\n",file=cll)
T <- factor(U$lang); L <- levels(T)
cat("% ",paste(1:length(L),L,sep="-"),sep=", ","\n",file=cll)
for(i in 1:n) cat(T[i],'\n',sep="",file=cll)
close(cll); rm(T)
rm(Ci)

# Authorship WA
A <- dict2DF(auths,"aind")
m <- nrow(A)
net <- file("WA.net","w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=net)
nam <- file("Authors.nam","w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=nam)
cat("% OpenAlex2Pajek",date(),"\n*vertices",n+m,n,"\n",file=net)
cat("% OpenAlex2Pajek",date(),"\n*vertices",m,"\n",file=nam)
WA <- read.csv("WA.tmp",sep="",head=FALSE,skip=1,encoding="UTF-8")
for(i in 1:n) cat(i,' "',row.names(U)[i],'"\n',sep="",file=net)
for(i in 1:m){
  cat(n+i,' "',row.names(A)[i],'"\n',sep="",file=net)
  cat(i,' "',ifelse(A[["sAname"]][i]=="",row.names(A)[i],A[["sAname"]][i]),'"\n',sep="",file=nam)
}
cat("*arcs\n",file=net)
for(i in 1:nrow(WA)) cat(WA$V1[i],n+WA$V2[i],"\n",file=net)
close(net); close(nam); rm(WA)

# Sources WJ
J <- dict2DF(srces,"sind")
m <- nrow(J)
net <- file("WJ.net","w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=net)
nam <- file("Sources.nam","w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=nam)
cat("% OpenAlex2Pajek",date(),"\n*vertices",n+m,n,"\n",file=net)
cat("% OpenAlex2Pajek",date(),"\n*vertices",m,"\n",file=nam)
WJ <- read.csv("WJ.tmp",sep="",head=FALSE,skip=1,encoding="UTF-8")
for(i in 1:n) cat(i,' "',row.names(U)[i],'"\n',sep="",file=net)
for(i in 1:m){
  cat(n+i,' "',row.names(J)[i],'"\n',sep="",file=net)
  cat(i,' "',ifelse(J[["Sname"]][i]=="",row.names(J)[i],J[["Sname"]][i]),'"\n',sep="",file=nam)
}
cat("*arcs\n",file=net)
for(i in 1:nrow(WJ)) cat(WJ$V1[i],n+WJ$V2[i],"\n",file=net)
close(net); close(nam); rm(WJ)

cat("*** OpenAlex2Pajek - Stop",date(),"\n"); flush.console()
closeWorks() 


