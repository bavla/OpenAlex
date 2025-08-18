# Temporal network of co-authorship between world countries

We developed a function coAuthorship that creates a temporal network describing the co-authorship between world countries in selected time periods. It turned out that OpenAlex is using the current [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) two-letter country codes to represent countries, dependent territories, and special areas of geographical interest. It doesn’t consider ex-countries such as SU (Soviet Union) or YU (Yugoslavia) – such allocations are transformed into the corresponding current countries. Another problem in creating the co-authorship network between world countries is that the above query returns information about up to 200 most collaborative countries. The problem is resolved by considering the symmetry of the co-authorship data.

Here is a program in R to create temporal co-authorship networks between world countries for selected years.
```
> setwd("C:/OpenAlex/test")
> library(httr); library(jsonlite)
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2Pajek.R")
> 
> iso <- "https://raw.githubusercontent.com/bavla/OpenAlex/refs/heads/main/data/ISO2codes.csv"
> CD <- read.csv2(iso,head=TRUE,na.strings="--")
> CN <- CD$name; CC <- CD$code
> 
> # sequence of networks for selected Years
> Years <- as.character(1990:2024)
> # Years <- c("1991-1995","1996-2000","2001-2005","2006-2010","2011-2015","2016-2020")
> S <- list()
> for(year in Years){
+   R <- coAuthorship(CC,year=year)
+   S[[year]] <- R
+   matrix2net(R$M,Net=paste0("WorldCo",year,".net"))
+   vector2clu(R$G,Clu=paste0("WorldCo",year,"G.clu"))
+   vector2vec(R$T,Vec=paste0("WorldCo",year,"T.vec"))
+ }
> save(S,file=paste0("MatrixList.Rdata"))
> cat("finished",date(),"\n"); flush.console()
```
The program execution produces the following report
```
Year =1990 Sat Jan 18 06:51:21 2025 
collected Sat Jan 18 06:52:25 2025 
k = 0   a = 0   dmax = 0 

Year =1991 Sat Jan 18 06:52:25 2025 
collected Sat Jan 18 06:53:29 2025 
k = 0   a = 0   dmax = 0 

Year =1992 Sat Jan 18 06:53:29 2025 
collected Sat Jan 18 06:54:31 2025 
k = 0   a = 0   dmax = 0 

...... 

Year =2023 Sat Jan 18 07:28:23 2025 
collected Sat Jan 18 07:29:29 2025 
k = 330   a = 0   dmax = 0 

Year =2024 Sat Jan 18 07:29:30 2025 
collected Sat Jan 18 07:30:37 2025 
k = 230   a = 0   dmax = 0 

finished Sat Jan 18 07:30:38 2025 
```

To create a network for all years is simple
```
# complete OpenAlex for all years
R <- coAuthorship(CC)
save(R,file="MatrixComplete.Rdata")
matrix2net(R$M,Net="WorldCoComplete.net")
vector2clu(R$G,Clu="WorldCoComplete.clu")
vector2vec(R$T,Vec="WorldCoComplete.vec")
```


```
```
See also [Countries](https://github.com/bavla/OpenAlex/tree/main/Countries).

