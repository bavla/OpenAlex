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

```
```


<hr />

[OpenAlex2Pajek](../README.md)
