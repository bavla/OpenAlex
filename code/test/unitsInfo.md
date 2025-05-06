# unitsInfo

## Function `unitsInfo`

I converted a short program from [first](first.md) into a function `unitsInfo` that collects from OpenAlex the basic information about units from a given list of OpenAlex IDs (of the same type). The function `unitsInfo` is included in the package `OpenAlex2Pajek`.

```
unitsInfo <- function(IDs=NULL,units="works",select="id",trace=TRUE,cond=""){
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
  return(W[order(W$id),])
}
```
## Sources

id, issn_l, issn, display_name, host_organization, host_organization_name, 
host_organization_lineage, relevance_score, works_count, cited_by_count, summary_stats, 
is_oa, is_in_doaj, is_indexed_in_scopus, is_core, ids, homepage_url, apc_prices,
 apc_usd, country, country_code, societies, alternate_titles, abbreviated_title, type, 
topics, topic_share, x_concepts, counts_by_year, works_api_url, updated_date, 
created_date.

```
> SIDs <- trimws(read.csv("./Dasha/wdeg100.dat",head=FALSE)$V1)
> selS <- "id,issn_l,country_code,type,is_oa,cited_by_count,works_count,display_name"
> RS <- unitsInfo(IDs=SIDs,units="sources",select=selS)
li = 1  ri = 50  nr = 50 
li = 51  ri = 100  nr = 50 
li = 101  ri = 139  nr = 39 
> write.csv2(RS,file="./Dasha/sourcesTest.csv")
> head(RS)
            id    issn_l country_code        type is_oa cited_by_count works_count
128 S100176667 1751-9020           GB     journal FALSE          41545        1740
29   S10288104 0046-2772           GB     journal FALSE         194636        3703
74   S10591207 0011-3921           US     journal FALSE          53332        2499
134 S106560479 0065-2601           US book series FALSE         203099         755
16  S106822843 0277-9536           GB     journal FALSE        1333368       20525
114 S107737141 0021-9916           US     journal FALSE         252330        5090
                                  display_name
128                          Sociology Compass
29       European Journal of Social Psychology
74                           Current Sociology
134 Advances in experimental social psychology
16                   Social Science & Medicine
114                   Journal of Communication
```


```

```

```

```

