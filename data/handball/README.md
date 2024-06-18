# Handball

```
> wdir <- "C:/OpenAlex/handball"
> setwd(wdir)
> library(httr)
> library(jsonlite)
> source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex4.R")
> Q <- list(
+   search="handball",
+   select=selCite,
+   per_page="200"
+ )
> OpenAlex2PajekCite(Q,1,name="HBcite",step=500,prop=TRUE)
```
We get the citation network HBcite1Ci.net with some partitions.

  * HBcite1Year.clu - publication year
  * HBcite1Type.clu - type of publication
  * HBcite1Lang.clu - language of publication
  * HBcite1Cbc.clu - cited by count
  * HBcite1Cdc.clu - countries distinct count
  * HBcite1Out.clu - referenced works

Using Pajek macro selectCandidates create the network HB1.net, using Textpad extract from it the list of candidates, and save the list as HB1.csv.

Create the extended citation network HBcite2Ci.net
```
> OpenAlex2PajekCite(Q,2,name="HBcite",listF="HB1.csv",step=500,prop=TRUE)
```
Using Pajek macro selectCandidates create the network HB2.net, using Textpad extract from it the list of candidates, and save the list as HB2.csv.
Join it with HB1.csv into the new list HB2u.csv and create the extended citation network HBcite3Ci.net
```
> joinLists("HB1.csv","HB2.csv","HB2u.csv")
> OpenAlex2PajekCite(Q,3,name="HBcite",listF="HB2u.csv",step=500,prop=TRUE)
```
Repeat the last commands some times.

```
```



