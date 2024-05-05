# OpenAlex2Pajek / Cite / Handball
# 27. Mar 2024 / 4. May 2024
# --------------------------------------------------------------------------------
# https://openalex.org/works/W2148606255
# https://openalex.org/works/W950821216

# library(httr)
# library(jsonlite)
# source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2.R")

# wdir <- "C:/Users/vlado/work/OpenAlex/API"
# setwd(wdir)

source("OpenAlex2.R")

Q <- list(
  search="handball",
  # filter="author.id:A5001676164",
  select="id,primary_location,publication_year,publication_date,type,language,title,referenced_works_count,referenced_works",
  ## ,biblio,authorships,countries_distinct_count,cited_by_count,
  per_page="200"
)

OpenAlex2PajekCite(Q,1,netF="handball1.net")
# prepare in Pajek the list HB1.csv
OpenAlex2PajekCite(Q,2,netF="handball2.net",listF="HB1.csv")
# prepare in Pajek the list HB2.csv with appended HB1.csv
removeDuplicates("HB2.csv","HB2u.csv")
OpenAlex2PajekCite(Q,3,netF="handball3.net",listF="HB2u.csv")
# prepare in Pajek the list HB3.csv with appended HB2u.csv
removeDuplicates("HB3.csv","HB3u.csv")
OpenAlex2PajekCite(Q,4,netF="handball4.net",listF="HB3u.csv")
