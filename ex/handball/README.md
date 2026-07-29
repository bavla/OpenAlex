# Handball

  * https://openalex.org/
  * https://openalex.org/works?search.title_and_abstract=handball&page=1&sort=relevance_score:desc
  * https://developers.openalex.org/guides/searching
  * https://api.openalex.org/works?search.exact="handball*"
  * https://github.com/bavla/OpenAlex/blob/main/code/test/jour.md
  * https://api.openalex.org/authors?search=Batagelj&select=id,display_name,orcid,works_count,cited_by_count
  * https://api.openalex.org/works/W2083084326?select=id,title,publication_year,type,biblio,authorships,countries_distinct_count,cited_by_count,referenced_works_count
  * https://api.openalex.org/sources/S4306400653?select=id,ids,type,display_name,country_code,works_count,cited_by_count,summary_stats,homepage_url


  * [Analiza omrežij](http://vladowiki.fmf.uni-lj.si/doku.php?id=notes:edu:anom:viri)
  * [Slovarček](http://vladowiki.fmf.uni-lj.si/doku.php?id=notes:net:dic)
    
```
> setAPIkey("your API key")
> Wall <- read.table("worksPat.csv",encoding="UTF-8")
```

```
> source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2Pajek.R")
> library(jsonlite)
> setAPIkey("your API key")
> S <- c( "S4306400653", "S4210225227", "S4306401293", "S4306549530", 
+         "S4306543465", "S4306402641", "S4306525539", "S2764608969" ) 
> U <- unitsInfo(IDs=S,units="sources",select="id,display_name,country_code",trace=TRUE,cond="",order="org")
> U

> setwd("C:/Users/vlado/docs/papers/2026/eusn/mark/named")
> sourceNames(netF="WJr.net",namF="Sources.nam",step=500)

```
