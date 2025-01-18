# OpenAlex2Pajek

**OpenAlex2Pajek** is an R package of functions for constructing bibliographic networks from selected bibliographic data in OpenAlex. Currently, OpenAlex2Pajek contains three main functions `OpenAlex2PajekCite`, `OpenAlex2PajekAll`, and `coAuthorship`.

## Saturation approach to construct bibliographic networks on selected topic

We split the process of creating the collection of bibliographic networks into two parts:

  - determining the set W of relevant works using the [saturation approach](https://link.springer.com/article/10.1007/s11192-017-2522-8) [Batagelj et al., 2017, page 506],
  - creation of the network collection for the works from W.

<img src="https://github.com/user-attachments/assets/4b110be2-c6c5-4d91-9992-44cf9703a4d8" width="600" />


The set W is determined iteratively using the function `OpenAlex2PajekCite` and the collection is finally created using the function `OpenAlex2PajekAll`.

After each run of the function `OpenAlex2PajekCite` we read the last version of the citation network into [Pajek](https://core-prod.cambridgecore.org/core/books/exploratory-social-network-analysis-with-pajek/6F8EE2512CB7C6D233DB2DAC3886D4F5) and apply macro [`expNodes`](https://raw.githubusercontent.com/bavla/OpenAlex/refs/heads/main/code/expNodes.mcr) to it. It produces a vector of expansion nodes. Using the `vector-Info` button in Pajek we get a list of works with the largest input degree. We select an appropriate threshold and extract (select and copy) the upper part of the table into TextPad. In TextPad, we remove other columns and save the list of works as a CSV file. Using the function `joinLists` we combine the old list of works with the new one and save it for the next step of the saturation procedure.

The collection contains the citation network **Cite** and two-mode networks: authorship **WA**, sources **WJ**, keywords **WK**, countries **WC**, and work properties: publication year, type of publication, the language of publication, cited by count, countries distinct count, and referenced works.

### Examples

#### Bibliographic networks on selected topic

Details **in preparation!!!**

#### Bibliographic networks for selected persons

Sometimes we would like to consider only works that are co-authored by at least one person from the list L (research group, project members, etc.). As an example let L = { Vladimir Batagelj, Anuška Ferligoj, Patrick Doreian }. OpenAlex assigns to each author (at least) one ID. To consider the right persons we first identify their IDs and use them in the process.

To get the ID we enter in the web browser URL line the API [call](https://api.openalex.org/authors?search=Vladimir%20Batagelj&select=id,display_name_alternatives,works_count
)
```
https://api.openalex.org/authors?search=Vladimir%20Batagelj&select=id,display_name_alternatives,works_count
```
We learn that Vladimir Batagelj has the OpenAlex ID A5001676164. In a similar way we get 4 candidates for Anuška Ferligoj and select two IDs A5029499420 and A5080127754. There are 8 candidate IDs for Patrick Doreian - we select A5065490876 and A5110460780. Probably all 4+8 candidates are OK. To check the selected IDs we [call](https://api.openalex.org/works?filter=author.id:A5001676164|A5065490876|A5110460780|A5029499420|A5080127754&select=id,title,publication_year&sort=publication_year:desc&per_page=200&page=1) the API (single line)
```
https://api.openalex.org/works?filter=author.id:A5001676164|A5065490876|A5110460780|A5029499420|A5080127754
&select=id,title,publication_year&sort=publication_year:desc&per_page=200&page=1
```
They co-authored 524 works. Only the first 200 works are listed. To get the remaining works change page=1 to page=2 and page=3.

Now we are ready to create the corresponding networks using R.

```
> setwd("C:/OpenAlex/test")
>  
> library(httr); library(jsonlite)
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2Pajek.R")
> 
> A <- "A5001676164|A5065490876|A5110460780|A5029499420|A5080127754"
> Q <- list(
+   filter=paste0("author.id:",A,",publication_year:1990-2024"),
+   select=selAll,
+   per_page="200"
+ )
> OpenAlex2PajekAll(Q,name="BDF")
```
The program execution produces the following report
```
OpenAlex2Pajek / All - Start Sat Jan 18 05:40:26 2025 
*** OpenAlex2Pajek / All - Process Sat Jan 18 05:40:26 2025 
*** OpenAlex2Pajek / All - Data Collected Sat Jan 18 05:40:32 2025 
hits: 452 works: 4078 authors: 303 anon: 0 sources: 119 
>>> Citation Cite
>>> publication year
>>> type of publication
>>> language of publication
>>> cited by count
>>> countries distinct count
>>> referenced works
>>> Authorship WA
>>> Sources WJ
>>> Countries WC
>>> Keywords WK
*** OpenAlex2Pajek / All - Stop Sat Jan 18 05:40:32 2025 
```
The obtained network files have the name BDF and different extensions.

#### Bibliographic networks for selected institution

We would like to create bibliographic networks of works co-authored by at least one author from University of Primorska (UP), Koper, Slovenia in the years 2011 to 2020. Again we first determine the UP's OpenAlex ID using the API [call](https://api.openalex.org/institutions?search=University%20of%20Primorska&select=id,display_name,display_name_alternatives,country_code,works_count) (single line)
```
https://api.openalex.org/institutions?search=University%20of%20Primorska
&select=id,display_name,display_name_alternatives,country_code,works_count
```
We learn that UP's OpenAlex ID is I118905719.

We create the corresponding networks using R.
```
> setwd("C:/OpenAlex/test")
>  
> library(httr); library(jsonlite)
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2Pajek.R")
> 
> Q <- list(
+   filter="institution.id:I118905719,publication_year:2011-2020",
+   select=selAll,
+   per_page="200"
+ )
> OpenAlex2PajekAll(Q,name="UP")
```
The program execution produces the following report
```
OpenAlex2Pajek / All - Start Sat Jan 18 06:24:39 2025 
*** OpenAlex2Pajek / All - Process Sat Jan 18 06:24:39 2025 
Sat Jan 18 06:24:54 2025  n = 500 
Sat Jan 18 06:25:10 2025  n = 1000 
Sat Jan 18 06:25:26 2025  n = 1500 
Sat Jan 18 06:25:40 2025  n = 2000 
Sat Jan 18 06:25:54 2025  n = 2500 
Sat Jan 18 06:26:03 2025  n = 3000 
*** OpenAlex2Pajek / All - Data Collected Sat Jan 18 06:26:13 2025 
hits: 3495 works: 67883 authors: 5344 anon: 0 sources: 1161 
>>> Citation Cite
>>> publication year
>>> type of publication
>>> language of publication
>>> cited by count
>>> countries distinct count
>>> referenced works
>>> Authorship WA
>>> Sources WJ
>>> Countries WC
>>> Keywords WK
*** OpenAlex2Pajek / All - Stop Sat Jan 18 06:26:27 2025 
```
See also [IMFM](https://github.com/bavla/OpenAlex/blob/main/code/ex/imfm.md).

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

## See also

  - Batagelj, V., Pisanski, J., Pisanski, T.: Higher-order bibliographic services based on bibliographic networks. IS2024-SIKDD_2024, Ljubljana, October 7 2024. [PDF](https://doi.org/10.70314/is.2024.sikdd.12) 
  - Batagelj, V.: OpenAlex2Pajek – an R Package for converting OpenAlex bibliographic data into Pajek networks.  COLLNET 2024, Strasbourg, December 12-14. V: Jain, Praveen Kumar (ur.), et al. Innovations in webometrics, informetrics, and scientometrics: AI-driven approaches and insights. Delhi: Bookwell, cop. 2024. p. 66-77. ISBN 978-93-86578-65-5. [arXiv](https://arxiv.org/abs/2501.06656)



