# OpenAlex2Pajek / Cite
# 27. Mar 2024 / 4. May 2024
# source("OpenAlex2PajekCite.R")
# https://openalex.org/works/W2148606255
# https://openalex.org/works/W950821216

# library(httr)
# library(jsonlite)
# source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2.R")

# wdir <- "C:/Users/vlado/work/OpenAlex/API"
# setwd(wdir)

source("OpenAlex2.R")
saveF <- "second.ndjson"; listF <- "batagelj1.csv"

Q <- list(
  # search="handball",
  filter="author.id:A5001676164",
  select="id,primary_location,publication_year,publication_date,type,language,title,referenced_works_count,referenced_works",
  ## ,biblio,authorships,countries_distinct_count,cited_by_count,
  per_page="200"
)

OpenAlex2PajekCite(Q,1,netF="VBCite1.net")
OpenAlex2PajekCite(Q,2,netF="VBCite2.net",listF="VB1.csv")
OpenAlex2PajekCite(Q,3,netF="VBCite3.net",listF="VB2.csv")
OpenAlex2PajekCite(Q,4,netF="VBCite4.net",listF="VB3.csv")
