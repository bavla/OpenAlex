# Bibliographic networks on selected topic

OpenAlex assigns to each work also some [keywords](https://help.openalex.org/hc/en-us/articles/24736201130391-Keywords) that describe its content.
For example for the field of network analysis we can use keywords [social-network-analysis](https://openalex.org/keywords/social-network-analysis) (works count: 51.950), [social-network](https://openalex.org/keywords/social-network) (works count: 96.250), and [complex-network](https://openalex.org/keywords/complex-network) (works count: 49.090).

We [can](https://developers.openalex.org/guides/searching) combine the into a single search ([call](https://api.openalex.org/works?filter=keywords.id:social-network-analysis|social-network|complex-network&select=id,publication_year,title), works count: 124999)
```
https://api.openalex.org/works?filter=keywords.id:social-network-analysis|social-network|complex-network&select=id,title
```

To get the list of works and the corresponding citation network we use the function `OpenAlex2PajekCite`
```
> source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2Pajek.R")
> Q <- list(
+   # search.title_and_abstract.exact="social+network*",
+   filter="keywords.id:social-network-analysis|social-network|complex-network",
+   select=selCite,
+   per_page="200"
+ )
> OpenAlex2PajekCite(Q,1,name="NA")
OpenAlex2Pajek / Cite - Start Sat Aug  1 06:24:53 2026 
*** OpenAlex2Pajek / Cite - Process Sat Aug  1 06:24:53 2026 
Sat Aug  1 06:25:10 2026  n = 500 
Sat Aug  1 06:25:36 2026  n = 1000 
Sat Aug  1 06:26:09 2026  n = 1500 
Sat Aug  1 06:27:00 2026  n = 2000 
Sat Aug  1 06:27:50 2026  n = 2500 
Sat Aug  1 06:28:28 2026  n = 3000 
Sat Aug  1 06:29:15 2026  n = 3500 
Sat Aug  1 06:30:04 2026  n = 4000 
Sat Aug  1 06:31:04 2026  n = 4500 
Sat Aug  1 06:32:07 2026  n = 5000 
Sat Aug  1 06:33:20 2026  n = 5500 
...
Sat Aug  1 17:19:39 2026  n = 123500 
Sat Aug  1 17:23:44 2026  n = 124000 
Sat Aug  1 17:27:00 2026  n = 124500 
*** OpenAlex2Pajek / Cite - Data Collected Sat Aug  1 17:28:46 2026 
hits: 124800 works: 1109800 
>>> Citation Cite
*** OpenAlex2Pajek / Cite - Stop Sat Aug  1 17:30:59 2026 
```
[DC partition](http://localhost:8800/doku.php?id=work:bib:alex:ana:mat:clea) 
```
```
```
```
```
```

<hr />

[OpenAlex2Pajek](../README.md)
