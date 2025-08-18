# OpenAlex2Pajek

**OpenAlex2Pajek** is an R package of functions for constructing bibliographic networks from selected bibliographic data in OpenAlex. Currently, OpenAlex2Pajek contains four main functions `OpenAlex2PajekCite`, `OpenAlex2PajekAll`, `OpenAlexSources`, `OpenAlexAuthors`, and `coAuthorship`.

## Saturation approach to construct bibliographic networks on selected topic

We split the process of creating the collection of bibliographic networks into two parts:

  - determining the set W of relevant works using the [saturation approach](https://link.springer.com/article/10.1007/s11192-017-2522-8) [Batagelj et al., 2017, page 506],
  - creation of the network collection for the works from W.

<img src="https://github.com/user-attachments/assets/4b110be2-c6c5-4d91-9992-44cf9703a4d8" width="600" />


The set W is determined iteratively using the function `OpenAlex2PajekCite` and the collection is finally created using the function `OpenAlex2PajekAll`.

After each run of the function `OpenAlex2PajekCite` we read the last version of the citation network into [Pajek](http://mrvar.fdv.uni-lj.si/pajek/) and apply macro [`expNodes`](https://raw.githubusercontent.com/bavla/OpenAlex/refs/heads/main/code/expNodes.mcr) to it. It produces a vector of expansion nodes. Using the `vector-Info` button in Pajek we get a list of works with the largest input degree. We select an appropriate threshold and extract (select and copy) the upper part of the table into TextPad. In TextPad, we remove other columns and save the list of works as a CSV file. Using the function `joinLists` we combine the old list of works with the new one and save it for the next step of the saturation procedure.

The collection contains the citation network **Cite** and two-mode networks: authorship **WA**, sources **WJ**, keywords **WK**, countries **WC**, and work properties: publication year, type of publication, the language of publication, cited by count, countries distinct count, and referenced works.

The function `OpenAlexSources` creates the list of works related to a selected journal (all papers published by the journal chosen and all works citing/cited by these papers). Similary, the function `OpenAlexAuthors` creates the list of works related to selected authors (all works (co-)authored by the chosen authors).

Since in networks the units (works, authors, sources, keywords, etc.) are identified by their OpenAlex IDs, another function, `unitsInfo`, provides the user with additional information about the units appearing in the results of analyses. A more detailed information about authors is provided by the function 

### Examples

- [Bibliographic networks on selected topic](./doc/topic.md)
- [Bibliographic networks for selected persons](./doc/persons.md)
- [Bibliographic networks for selected institution](./doc/institution.md)
## Temporal network of co-authorship between world countries

We developed a function coAuthorship that creates a temporal network describing the co-authorship between world countries in selected time periods. It turned out that OpenAlex is using the current [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) two-letter country codes to represent countries, dependent territories, and special areas of geographical interest. It doesn’t consider ex-countries such as SU (Soviet Union) or YU (Yugoslavia) – such allocations are transformed into the corresponding current countries. Another problem in creating the co-authorship network between world countries is that the above query returns information about up to 200 most collaborative countries. The problem is resolved by considering the symmetry of the co-authorship data.

Here is a program in R to create temporal co-authorship networks between world countries for selected years.
```
> setwd("C:/OpenAlex/test")
> library(httr); library(jsonlite)
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2Pajek.R")
> 
> iso <- "https://raw.githubusercontent.com/bavla/OpenAlex/refs/heads/main/data/ISO2codes.csv"
> CD <- read.csv2(iso,head=TRUE,na.strings="--")
> CN <- CD$name; CC <- CD$code
> 
> # sequence of networks for selected Years
> Years <- as.character(1990:2024)
> # Years <- c("1991-1995","1996-2000","2001-2005","2006-2010","2011-2015","2016-2020")
> S <- list()
> for(year in Years){
+   R <- coAuthorship(CC,year=year)
+   S[[year]] <- R
+   matrix2net(R$M,Net=paste0("WorldCo",year,".net"))
+   vector2clu(R$G,Clu=paste0("WorldCo",year,"G.clu"))
+   vector2vec(R$T,Vec=paste0("WorldCo",year,"T.vec"))
+ }
> save(S,file=paste0("MatrixList.Rdata"))
> cat("finished",date(),"\n"); flush.console()
```
The program execution produces the following report
```
Year =1990 Sat Jan 18 06:51:21 2025 
collected Sat Jan 18 06:52:25 2025 
k = 0   a = 0   dmax = 0 

Year =1991 Sat Jan 18 06:52:25 2025 
collected Sat Jan 18 06:53:29 2025 
k = 0   a = 0   dmax = 0 

Year =1992 Sat Jan 18 06:53:29 2025 
collected Sat Jan 18 06:54:31 2025 
k = 0   a = 0   dmax = 0 

...... 

Year =2023 Sat Jan 18 07:28:23 2025 
collected Sat Jan 18 07:29:29 2025 
k = 330   a = 0   dmax = 0 

Year =2024 Sat Jan 18 07:29:30 2025 
collected Sat Jan 18 07:30:37 2025 
k = 230   a = 0   dmax = 0 

finished Sat Jan 18 07:30:38 2025 
```

To create a network for all years is simple
```
# complete OpenAlex for all years
R <- coAuthorship(CC)
save(R,file="MatrixComplete.Rdata")
matrix2net(R$M,Net="WorldCoComplete.net")
vector2clu(R$G,Clu="WorldCoComplete.clu")
vector2vec(R$T,Vec="WorldCoComplete.vec")
```


```
```
See also [Countries](https://github.com/bavla/OpenAlex/tree/main/Countries).


OpenAlexSources <- function(sID,step=100,cond="")

OpenAlexAuthors <- function(IDs,step=100,cond="")

unitsInfo <- function(IDs=NULL,units="works",select="id",trace=TRUE,cond="",order="alpha"){

authorsId2name <- function(Ids,clu=NULL,Fname="aDF")


## See also

  - Batagelj, V., Pisanski, J., Pisanski, T.: Higher-order bibliographic services based on bibliographic networks. IS2024-SIKDD_2024, Ljubljana, October 7 2024. [PDF](https://doi.org/10.70314/is.2024.sikdd.12) 
  - Batagelj, V.: OpenAlex2Pajek – an R Package for converting OpenAlex bibliographic data into Pajek networks.  COLLNET 2024, Strasbourg, December 12-14. V: Jain, Praveen Kumar (ur.), et al. Innovations in webometrics, informetrics, and scientometrics: AI-driven approaches and insights. Delhi: Bookwell, cop. 2024. p. 66-77. ISBN 978-93-86578-65-5. [arXiv](https://arxiv.org/abs/2501.06656)
  - De Nooy, W., Mrvar, A., Batagelj, V. Exploratory social network analysis with Pajek: Revised and expanded edition for updated software. Vol. 46. Cambridge university press, 2018. [WWW](https://core-prod.cambridgecore.org/core/books/exploratory-social-network-analysis-with-pajek/6F8EE2512CB7C6D233DB2DAC3886D4F5)
  - OpenAlex: Client Libraries. [WWW](https://docs.openalex.org/how-to-use-the-api/api-overview#client-libraries)




