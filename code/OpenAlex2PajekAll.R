# OpenAlex2Pajek / All
# 27. Mar 2024 / 5. May 2024
# --------------------------------------------------------------------------------
# source("OpenAlex2Pajek.R")
# https://openalex.org/works/W2148606255
# https://openalex.org/works/W950821216

# library(httr)
# library(jsonlite)
# source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex.R")

# wdir <- "C:/Users/vlado/work/OpenAlex/API"
# setwd(wdir)

source("OpenAlex2.R")

Q <- list(
  # search="handball",
  # filter="publication_year:2015",
  filter="author.id:A5001676164",
  select="id,primary_location,publication_year,publication_date,type,language,biblio,title,authorships,countries_distinct_count,cited_by_count,referenced_works_count,referenced_works",
  per_page="200"
)

OpenAlex2PajekAll(Q,1,netF="batagelj.net",listF="VB3u.csv")
# OpenAlex2PajekAll(Q,1,netF="handball.net",listF="HB4u.csv")


=====================================================================

> Q <- list(
+   # search="handball",
+   # filter="publication_year:2015",
+   filter="author.id:A5001676164",
+   select="id,primary_location,publication_year,publication_date,type,language,biblio,title,authorships,countries_distinct_count,cited_by_count,referenced_works_count,referenced_works",
+   per_page="200"
+ )
> OpenAlex2PajekAll(Q,1,netF="batagelj.net",listF="VB3u.csv")
OpenAlex2Pajek / All - Start Sun May  5 04:01:45 2024 
*** OpenAlex2Pajek / All - Process Sun May  5 04:01:45 2024 
Sun May  5 04:02:58 2024  n = 500 
*** OpenAlex2Pajek / All - Data Collected Sun May  5 04:04:13 2024 
hits: 759 works: 7309 authors: 874 anon: 14 sources: 204 
*** OpenAlex2Pajek / All - Stop Sun May  5 04:04:14 2024 
> 


