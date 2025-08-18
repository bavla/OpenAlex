# Bibliographic networks for selected persons

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

