# OpenAlex2Pajek 
# source("CiteNet.R")

# library(httr)
# library(jsonlite)
# source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2.R")
source("OpenAlex2.R")

# HB1list <- read.table("HB1.csv")$V1
Q <- list(
  search="handball",
  # filter="publication_year:2015",
  select="id,primary_location,publication_year,publication_date,type,language,biblio,title,authorships,countries_distinct_count,cited_by_count,referenced_works_count,referenced_works",
  per_page="200"
)
save <- FALSE; step <- 500
if(save) json <- file("second.ndjson","w",encoding="UTF-8")

cat("OpenAlex2Pajek - Start",date(),"\n")
ci <- file("Ci.tmp","w",encoding="UTF-8"); wa <- file("WA.tmp","w",encoding="UTF-8")
wj <- file("WJ.tmp","w",encoding="UTF-8"); wrk <- file("works.csv","w",encoding="UTF-8")
cat("% OpenAlex",date(),"\n",file=wa); cat("% OpenAlex",date(),"\n",file=wj)
cat("% OpenAlex",date(),"\n",file=ci); cat("% OpenAlex",date(),"\n",file=wrk)
# cat("ind;Wid;hit;sWname;Sid;pYear;pDate;type;lang;vol;iss;fPage;lPage;fAName;title\n",file=wrk)

works <- eDict(); srces <- eDict(); auths <- eDict();

# openWorks(query=Q,list=VBlist,file="manual.ndjson")
# openWorks(query=Q,list=NULL,file="save.ndjson")
# openWorks(query=Q,list=HB1list,file=NULL)
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
net <- file("HB1Cite.net","w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=net)
# net <- file("HB2Cite.net","w",encoding="UTF-8"); cat('\xEF\xBB\xBF',file=net)
cat("% OpenAlex2Pajek",date(),"\n*vertices",n,"\n",file=net)
Ci <- read.csv("Ci.tmp",sep="",head=FALSE,skip=1,encoding="UTF-8")
for(i in 1:n) cat(i,' "',row.names(U)[i],'"\n',sep="",file=net)
cat("*arcs\n",file=net)
for(i in 1:nrow(Ci)) cat(Ci$V1[i],Ci$V2[i],"\n",file=net)
close(net); rm(Ci)

cat("*** OpenAlex2Pajek - Stop",date(),"\n"); flush.console()

# closeWorks() 


