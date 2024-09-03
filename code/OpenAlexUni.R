# OpenAlex2PajekUni 
# special version without citation network
# September 3, 2024

processWorkUni <- function(w,test) {
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

OpenAlex2PajekUni <- function(Q,name="test",listF=NULL,save=FALSE,
  saveF="saveCite.ndjson",step=500,test=0){
  if(save) json <<- file(saveF,"w",encoding="UTF-8")
  if(is.null(listF)) listW <- NULL else listW <- unique(read.table(listF)$V1) # list of works
  cat("OpenAlex2Pajek / Uni - Start",date(),"\n")
  wrk <<- file("works.csv","w",encoding="UTF-8")
  wa <<- file("WA.tmp","w",encoding="UTF-8"); wj <<- file("WJ.tmp","w",encoding="UTF-8");
  wk <<- file("WK.tmp","w",encoding="UTF-8"); wl <<- file("WC.tmp","w",encoding="UTF-8");
  cat("% OpenAlex2Pajek / All",date(),"\n",file=wrk)
  cat("% OpenAlex2Pajek / All",date(),"\n",file=wa); cat("% OpenAlex2Pajek / All",date(),"\n",file=wj)
  cat("% OpenAlex2Pajek / All",date(),"\n",file=wk); cat("% OpenAlex2Pajek / All",date(),"\n",file=wl);
  # cat("ind;Wid;hit;sWname;Sid;pYear;pDate;type;lang;vol;iss;fPage;lPage;fAName;title\n",file=wrk)
  cat("ind;Wid;hit;sWname;Sid;pYear;pDate;type;lang;vol;iss;fPage;lPage;cdc;cbc;fAName;title\n",file=wrk)
  works <<- eDict(); srces <<- eDict(); auths <<- eDict(); keyws <<- eDict(); cntrs <<- eDict()
  openWorks(query=Q,list=listW,file=NULL,name) 
  if(test>1) print(ls.str(WC))
  cat("*** OpenAlex2Pajek / Uni - Process",date(),"\n"); flush.console()
  repeat{
    w <- nextWork()
    if(is.null(w)) break
    if(save) write(toJSON(w),file=json)
    if(WC$n %% step==0) cat(date()," n =",WC$n,"\n"); flush.console()
    tryCatch(
      processWorkUni(w,test),
      error=function(e){ WC$er <- WC$er + 1; cat("W",WC$n,w$id,WC$er,"\n")
        print(e); flush.console();
        if(WC$er > 20) stop("To many errors") }  )
  }
  cat("*** OpenAlex2Pajek / Uni - Data Collected",date(),"\n"); flush.console()
  if(test>1) print(ls.str(WC))
  close(wrk); close(wa); close(wj); close(wk); close(wl)
  if(save) close(json)
  cat("hits:",WC$n,"works:",length(works),"authors:",length(auths),
    "anon:",WC$an,"sources:",length(srces),"\n"); flush.console()
  U <- dict2DF(works,"wind"); n <- nrow(U)
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
  cat("*** OpenAlex2Pajek / Uni - Stop",date(),"\n"); flush.console()
  # close(WC$tr) 
  closeWorks() 
}

