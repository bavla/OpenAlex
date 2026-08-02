# Author's total and topic activity by years

For an example, we will present the [total activity](https://api.openalex.org/works?filter=author.id:a5065490876|A5110460780&group_by=publication_year&per_page=200&page=1) (blue) of Patrick Doreian by years and
his [works on signed networks](https://api.openalex.org/works?search.title_and_abstract.exact=sign*&filter=author.id:a5065490876|A5110460780&group_by=publication_year&per_page=200&page=1) (red).

```
> library(httr); library(jsonlite)
> aIDs <- "a5065490876|A5110460780"
> keyw <- "sign*" 
> start <- "https://api.openalex.org/works?"
> end <- "&group_by=publication_year&per_page=200&page=1"
> sta <- "search.title_and_abstract.exact="
> aID <- "filter=author.id:"
> wd <- GET(paste0(start,aID,aIDs,end))
> wc <- fromJSON(rawToChar(wd$content))
> ws <- GET(paste0(start,sta,keyw,"&",aID,aIDs,end))
> wp <- fromJSON(rawToChar(ws$content))
> sum(wc$group_by$count)
> sum(wp$group_by$count)
> nin <- min(as.integer(c(wc$group_by$key,wp$group_by$key)))
> nax <- max(as.integer(c(wc$group_by$key,wp$group_by$key)))
> NN <- nin:nax; N <- as.character(NN)
> topic <- all <- rep(0,length(N)); names(topic) <- names(all) <- N
> all[wc$group_by$key] <- wc$group_by$count
> topic[wp$group_by$key] <- wp$group_by$count
> barplot(all,col="blue",main="Patrick Doreian / signed")
> barplot(topic,col="red",add=T)
```
<img width="800" alt="PatSig" src="https://github.com/user-attachments/assets/72cb0377-1ed3-40d3-b1e1-fba6e25daa7a" />

We transform the code into a function (included in OpenAlex2Pajek)
```
activity <- function(aIDs,keyw,col=c("blue","red"),main="Activity"){
  start <- "https://api.openalex.org/works?"
  end <- "&group_by=publication_year&per_page=200&page=1"
  sta <- "search.title_and_abstract.exact="
  aID <- "filter=author.id:"
  wd <- GET(paste0(start,aID,aIDs,end))
  wc <- fromJSON(rawToChar(wd$content))
  ws <- GET(paste0(start,sta,keyw,"&",aID,aIDs,end))
  wp <- fromJSON(rawToChar(ws$content))
  cat("IDs =",aIDs," keyw =",keyw,
    "total =",sum(wc$group_by$count)," topic =",sum(wp$group_by$count),"\n")
  nin <- min(as.integer(c(wc$group_by$key,wp$group_by$key)))
  nax <- max(as.integer(c(wc$group_by$key,wp$group_by$key)))
  NN <- nin:nax; N <- as.character(NN)
  topic <- all <- rep(0,length(N)); names(topic) <- names(all) <- N
  all[wc$group_by$key] <- wc$group_by$count
  topic[wp$group_by$key] <- wp$group_by$count
  barplot(all,col=col[1],main=main)
  barplot(topic,col=col[2],add=T)
}
```
Now, we get the picture with a single call
```
> activity("a5065490876|A5110460780","blockmodel*",
+   col=c("darkolivegreen","darkgoldenrod1"), main="Patrick Doreian / blockmodeling")
IDs = a5065490876|A5110460780  keyw = blockmodel* total = 218  topic = 53 
```
<img width="800" alt="PatBM" src="https://github.com/user-attachments/assets/fe8579f2-03fe-4b20-b7e7-f9ea9b0e24e6" />

Check the OpenAlex author's IDs [a5065490876](https://openalex.org/authors/a5065490876) and [A5110460780](https://openalex.org/authors/A5110460780)

<hr />

[OpenAlex2Pajek](../README.md)
