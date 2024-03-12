# cat("works:",length(works),"authors:",length(auths),"sources:",length(srces),"\n") 
# rm(works,auths,srces)
# source("nets.R")

source("https://raw.githubusercontent.com/bavla/OpenAlex/main/OpenAlex.R")
# source("OpenAlex.R")

cat("OpenAlex2Pajek - Start",date(),"\n")
wrk <- file("works.csv","w",encoding="UTF-8")
ci <- file("Ci.tmp","w",encoding="UTF-8")
wa <- file("WA.tmp","w",encoding="UTF-8")
wj <- file("WJ.tmp","w",encoding="UTF-8")
cat("% OpenAlex",date(),"\n",file=wrk)
cat("% OpenAlex",date(),"\n",file=wa)
cat("% OpenAlex",date(),"\n",file=wj)
cat("% OpenAlex",date(),"\n",file=ci)
cat("ind;Wid;hit;sWname;Sid;pYear;pDate;type;lang;vol;iss;fPage;lPage;fAName;title\n",file=wrk)
works <- eDict(); srces <- eDict(); auths <- eDict();
nr <- nrow(wr); n <- 0
for(i in 1:nr){
  Wid <- getID(wr$id[[i]]); hit <- TRUE
  Sid <- getID(wr$primary_location[i,]$source$id)
  Sname <- wr$primary_location[i,]$source$display_name 
  pYear <- wr$publication_year[[i]]; pDate <- wr$publication_date[[i]]
  type <- wr$type[[i]]
  lang <- wr$language[[i]]
  vol <- wr$biblio[i,]$volume; iss <- wr$biblio[i,]$issue
  fPage <- wr$biblio[i,]$first_page; lPage <- wr$biblio[i,]$last_page
  title <- wr$title[[i]]; tit <- gsub(";",",",title)
  fAName <- wr$authorships[[i]]$author$display_name[1]
  sWname <- Gname(fAName,type,pYear,vol,fPage)
  n <- n+1; u <- putWork(Wid,sWname)
  if(!is.na(Sid)) {j <- putSrc(Sid,Sname); cat(u,j,"\n",file=wj)}
  cat(u,Wid,hit,sWname,Sid,pYear,pDate,type,lang,vol,iss,fPage,lPage,fAName,tit,
    sep=";",file=wrk); cat("\n",file=wrk)
  for(w in wr$referenced_works[[i]]) {
    vid <- getID(w); v <- putWork(vid,"")
    cat(v,vid,FALSE,"",NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,sep=";",file=wrk)
    cat("\n",file=wrk); cat(u,v,"\n",file=ci) }
  auts <- wr$authorships[[i]]$author; na <- nrow(auts)
  for(a in 1:na) {
    Aid <- getID(auts$id[a]); v <- putAuth(Aid,Aname=auts$display_name[a])
    cat(u,v,"\n",file=wa) }
}
close(ci); close(wj); close(wa); close(wrk)
cat("works:",length(works),"authors:",length(auths),"sources:",length(srces),"\n")
cat("OpenAlex2Pajek - Stop",date(),"\n")

