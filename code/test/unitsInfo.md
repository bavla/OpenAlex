# unitsInfo

May 6, 2025

## Function `unitsInfo`

I converted a short program from [first](first.md) into a function `unitsInfo` that collects from OpenAlex the basic information about units from a given list of OpenAlex IDs (of the same type). The function `unitsInfo` is included in the package  [`OpenAlex2Pajek`](https://github.com/bavla/OpenAlex/tree/main/OpenAlex2Pajek).

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

id, issn_l, issn, display_name, host_organization, host_organization_name, host_organization_lineage, relevance_score, works_count, cited_by_count, summary_stats, is_oa, is_in_doaj, is_indexed_in_scopus, is_core, ids, homepage_url, apc_prices, apc_usd, country, country_code, societies, alternate_titles, abbreviated_title, type, topics, topic_share, x_concepts, counts_by_year, works_api_url, updated_date, created_date.

```
> # source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2Pajek.R")
> SIDs <- trimws(read.csv("wdeg100.dat",head=FALSE)$V1)
> selS <- "id,issn_l,country_code,type,is_oa,cited_by_count,works_count,display_name"
> RS <- unitsInfo(IDs=SIDs,units="sources",select=selS)
li = 1  ri = 50  nr = 50 
li = 51  ri = 100  nr = 50 
li = 101  ri = 139  nr = 39 
> write.csv2(RS,file="sourcesTest.csv")
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
## Works

id, doi, title, display_name, relevance_score, publication_year, publication_date, ids, language, primary_location, sources, type, type_crossref, indexed_in, open_access, authorships, institution_assertions, countries_distinct_count, institutions_distinct_count, corresponding_author_ids, corresponding_institution_ids, apc_list, apc_paid, fwci, is_authors_truncated, has_fulltext, fulltext_origin, cited_by_count, citation_normalized_percentile, cited_by_percentile_year, biblio, is_retracted, is_paratext, primary_topic, topics, keywords, concepts, mesh, locations_count, locations, best_oa_location, sustainable_development_goals, grants, datasets, versions, referenced_works_count, referenced_works, related_works, abstract_inverted_index, abstract_inverted_index_v3, cited_by_api_url, counts_by_year, updated_date, created_date.

```
> WIDs <- trimws(read.csv("worksTest.dat",head=FALSE)$V1)
> selW <- paste0("id,language,countries_distinct_count,cited_by_count,",
+   "relevance_score,publication_year,title")
> RW <- unitsInfo(IDs=WIDs,units="works",select=selW)
li = 1  ri = 50  nr = 50 
li = 51  ri = 90  nr = 40 
> write.csv2(RW,file="worksTest.csv")
> head(RW)
            id language countries_distinct_count cited_by_count publication_year
43  W113241274       en                        0            159             1992
45  W120428109       en                        1            108             1998
21  W143336295       en                        1           1847             1993
41 W1504472087       en                        0            181             1993
8  W1539609515       en                        1           5610             1975
67 W1552061030       en                        0           1747             1998
                                                                      title
43     Psychological Distress/Well-Being and Cognitive Functioning Measures
45                                    Subjective Well-Being and Personality
21 Quality of Life Enjoyment and Satisfaction Questionnaire: a new measure.
41                        The Pursuit of Happiness: Who Is Happy - and Why?
8                                                Beyond boredom and anxiety
67                                            Multiple Regression: A Primer
```

## Authors

id, orcid, display_name, display_name_alternatives, relevance_score, works_count, cited_by_count, summary_stats, ids, affiliations, last_known_institutions, topics, topic_share, x_concepts, counts_by_year, works_api_url, updated_date, created_date.

```
> AIDs <- trimws(read.csv("authorsTest.dat",head=FALSE)$V1)
> selA <- "id,orcid,works_count,cited_by_count,relevance_score,display_name"
> RA <- unitsInfo(IDs=AIDs,units="authors",select=selA)
li = 1  ri = 50  nr = 50 
li = 51  ri = 98  nr = 48 
> write.csv2(RA,file="authorsTest.csv")
> head(RA)
            id                                 orcid works_count cited_by_count        display_name
36 A5000166339                                  <NA>          98           3046  Colin Tucker Smith
71 A5001125856 https://orcid.org/0000-0002-5539-783X          95           2396  Panagiotis Metaxas
19 A5003112909 https://orcid.org/0000-0001-7102-2491         222          11979   Timothy D. Wilson
31 A5003968744 https://orcid.org/0000-0001-6406-8811         149           2828      Andreas Graefe
18 A5004796814 https://orcid.org/0000-0002-8460-0331         240           4465 Costas Panagopoulos
27 A5006386521 https://orcid.org/0000-0002-0943-162X         169           4947     Marco Ottaviani
```

## Preserving the initial order of units in the description list

May 18, 2025

Assume that the description data frame RS is created as in **Sources**. To get a data frame N with units ordered as in SIDs we use the command
```
N <- RS[p<-match(SIDs,RS$id),]
```
Here is a test
```
> head(SIDs)
[1] "S4306525036" "S112952035"  "S202734349"  "S151331055"  "S166002381"  "S37739784"  
> N <- RS[p<-match(SIDs,RS$id),]
> head(N)
            id    issn_l country_code       type is_oa cited_by_count works_count                             display_name
1  S4306525036      <NA>           US repository FALSE     1165544817    33075702                                   PubMed
23  S112952035 0303-8300           NL    journal FALSE         248273        5707               Social Indicators Research
38  S202734349 1389-4978           NL    journal FALSE         119486        1811             Journal of Happiness Studies
18  S151331055 0191-8869           GB    journal FALSE         768640       15619   Personality and Individual Differences
19  S166002381 0021-9010           US    journal FALSE        1311088       13123            Journal of Applied Psychology
46   S37739784 1532-7957           US    journal FALSE         159965         552 Personality and Social Psychology Review
> 
> write.csv2(N,file="sourcesTestOrg.csv")
```

### Parameter order

The above solution is included in the function `unitsInfo` by introducing an additional parameter `order` with a default value `alpha` returning the alphabetically ordered list; and value `input` for returning the list following the original input list order.
```
> AS <- unitsInfo(IDs=SIDs,units="sources",select=selS)
li = 1  ri = 50  nr = 50 
li = 51  ri = 100  nr = 50 
li = 101  ri = 139  nr = 39 
> head(AS)
            id    issn_l country_code        type is_oa cited_by_count works_count                               display_name
128 S100176667 1751-9020           GB     journal FALSE          41744        1740                          Sociology Compass
29   S10288104 0046-2772           GB     journal FALSE         195183        3703      European Journal of Social Psychology
74   S10591207 0011-3921           US     journal FALSE          53482        2499                          Current Sociology
134 S106560479 0065-2601           US book series FALSE         203434         755 Advances in experimental social psychology
16  S106822843 0277-9536           GB     journal FALSE        1335817       20525                  Social Science & Medicine
114 S107737141 0021-9916           US     journal FALSE         252807        5090                   Journal of Communication
> IN <- unitsInfo(IDs=SIDs,units="sources",select=selS,order="input")
li = 1  ri = 50  nr = 50 
li = 51  ri = 100  nr = 50 
li = 101  ri = 139  nr = 39 
> head(IN)
            id    issn_l country_code       type is_oa cited_by_count works_count                             display_name
1  S4306525036      <NA>           US repository FALSE     1165544817    33075702                                   PubMed
23  S112952035 0303-8300           NL    journal FALSE         248273        5707               Social Indicators Research
38  S202734349 1389-4978           NL    journal FALSE         119486        1811             Journal of Happiness Studies
18  S151331055 0191-8869           GB    journal FALSE         768640       15619   Personality and Individual Differences
19  S166002381 0021-9010           US    journal FALSE        1311088       13123            Journal of Applied Psychology
46   S37739784 1532-7957           US    journal FALSE         159965         552 Personality and Social Psychology Review
```

[Index](README.md)
