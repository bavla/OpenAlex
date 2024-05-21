# HKUST - The Hong Kong University of Science and Technology

https://openalex.org/institutions/I200769079

For our task, we would like to restrict hits to the years 2017-2019

https://api.openalex.org/works?filter=institution.id:I200769079,publication_year:2017-2019&select=id,title

We learn that researchers from HKUST published 9702 works in the years 2017-2019.

Now we are ready for the creation of the corresponding Pajek files.
```
> wdir <- "C:/Users/vlado/work/OpenAlex/API"
> setwd(wdir)
>  
> library(httr)
> library(jsonlite)
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2.R")
> # source("OpenAlex2.R")
>
> Q <- list(
+   filter="institution.id:I200769079,publication_year:2017-2019",
+   select=selAll,
+   per_page="200"
+ )
> OpenAlex2PajekAll(Q,name="HKUST")
OpenAlex2Pajek / All - Start Tue May 21 17:34:47 2024 
*** OpenAlex2Pajek / All - Process Tue May 21 17:34:47 2024 
Tue May 21 17:35:04 2024  n = 500 
Tue May 21 17:35:28 2024  n = 1000 
Tue May 21 17:35:57 2024  n = 1500 
Tue May 21 17:36:31 2024  n = 2000 
Tue May 21 17:37:11 2024  n = 2500 
Tue May 21 17:37:52 2024  n = 3000 
Tue May 21 17:38:38 2024  n = 3500 
Tue May 21 17:39:25 2024  n = 4000 
Tue May 21 17:40:20 2024  n = 4500 
Tue May 21 17:41:15 2024  n = 5000 
Tue May 21 17:42:27 2024  n = 5500 
Tue May 21 17:43:37 2024  n = 6000 
Tue May 21 17:44:48 2024  n = 6500 
Tue May 21 17:45:52 2024  n = 7000 
Tue May 21 17:46:44 2024  n = 7500 
Tue May 21 17:47:25 2024  n = 8000 
Tue May 21 17:47:57 2024  n = 8500 
Tue May 21 17:48:27 2024  n = 9000 
Tue May 21 17:49:00 2024  n = 9500 
*** OpenAlex2Pajek / All - Data Collected Tue May 21 17:49:08 2024 
hits: 9702 works: 231248 authors: 21279 anon: 0 sources: 1970 
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
*** OpenAlex2Pajek / All - Stop Tue May 21 17:50:10 2024 
> 
```
