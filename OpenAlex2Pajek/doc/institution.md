# Bibliographic networks for selected institution

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

