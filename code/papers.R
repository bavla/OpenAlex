
> wdir <- "C:/Users/vlado/docs/papers/2024/Sreda/1353"
> setwd(wdir)
> library(httr)
> library(jsonlite)

> URL <- "https://api.openalex.org/works?filter=publication_year:1990-2024&group-by=publication_year"
> res <- GET(URL)
> # str(res)
> # res$date
> cont <- fromJSON(rawToChar(res$content))
> # names(cont)
> # str(cont)
> year <- as.integer(cont$group_by$key)
> nPapers <- cont$group_by$count
> plot(year,nPapers,main="OpenAlex",pch=16)
> plot(year,log(nPapers),main="OpenAlex",pch=16)