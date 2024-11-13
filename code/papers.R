# number of papers in OpenAlex in each year ymin:ymax
ymin <- 1980; ymax <- 2024 
library(httr)
library(jsonlite)
works <- "https://api.openalex.org/works"
URL <- paste0(works,"?filter=publication_year:",
   ymin,"-",ymax,"&group-by=publication_year")
res <- GET(URL)
cont <- fromJSON(rawToChar(res$content))
year <- as.integer(cont$group_by$key)
nPapers <- cont$group_by$count
plot(year,nPapers,main="OpenAlex",pch=16)
# plot(year,log(nPapers),main="OpenAlex",pch=16)
