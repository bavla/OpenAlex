# Garfield work names and info



## Info about selected works of an author

Let's list the works of the author `A5001676164` (Vladimir Batagelj) cited at least 100 times.
```
> library(httr); library(jsonlite)
> source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2Pajek.R")
> api <- "https://api.openalex.org/works?filter=author.id:A5001676164,cited_by_count:>99&select=id,title,cited_by_count"
> wd <- GET(api)
> cont <- fromJSON(rawToChar(wd$content))
> wIds <- getID(cont$results$id)
> vb <- worksId2name(wIds)
```
We get the list (data.frame)
```
> vb
           wid                    lab  cbc                                                tit
1  W1947595544        Nooy_WD(2018)BK 2163     Exploratory Social Network Analysis with Pajek
2  W2109278577      Batagelj_V(1999): 1405         Pajek - Program for Large Network Analysis
3  W4291733759        Nooy_WD(2005)BK 1242     Exploratory Social Network Analysis with Pajek
4  W2187250072      Batagelj_V(1993):  786                      Centrality in Social Networks
5  W1502432690     Batagelj_V(2002)BC  686 Pajek— Analysis and Visualization of Large Netw...
6  W1424846356        Nooy_WD(2011)BK  645     Exploratory Social Network Analysis with Pajek
7  W1676999057     Batagelj_V(2003)NA  642 An O(m) Algorithm for Cores Decomposition of Ne...
8   W977705565      Doreian_P(2004)BK  476                          Generalized Blockmodeling
9  W2147991930  Batagelj_V(2010)5:129  273 Fast algorithms for determining (generalized) c...
10 W2791243661        Nooy_WD(2018)BK  221 Exploratory Social Network Analysis with Pajek:...
11 W2335008118        Mrvar_A(2016)4:  195 Analysis and visualization of large networks wi...
12 W4229688471     Batagelj_V(2004)BC  318 Pajek — Analysis and Visualization of Large Net...
13 W2008006577    Batagelj_V(2005)71:  264      Efficient generation of large random networks
14 W2126094488     Batagelj_V(2003)NA  204 Efficient Algorithms for Citation Network Analysis
15 W1981385379   Doreian_P(2004)26:29  203 Generalized blockmodeling of two-mode network data
16 W2108584774      Batagelj_V(2007):  184 Pajek Program for Analysis and Visualization of...
17 W1967880836 Batagelj_V(2000)22:173  184         Some analyses of Erdős collaboration graph
18 W2110311637  Batagelj_V(1995)12:73  179                     Comparing resemblance measures
19 W3037530667      Batagelj_V(2002):  147                                  Generalized Cores
20 W2125725243 Batagelj_V(2001)23:237  133 A subquadratic triad census algorithm for large...
21 W2023723604  Batagelj_V(1992)14:63  130 Direct and indirect methods for structural equi...
22 W2001947224 Batagelj_V(1992)14:121  106  An optimizational approach to regular equivalence
23 W3214957292      Batagelj_V(2003):  103 An O(m) Algorithm for Cores Decomposition of Ne...
```
We can save the data to a file
```
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> vector2nam(vb$lab,Nam="vbWorks.nam")
> write.csv2(vb,file="vbWorks100.csv",fileEncoding="UTF-8")
```

## Labels of works in a Pajek file

```

```

```

```

<hr />

[OpenAlex2Pajek](../README.md)
