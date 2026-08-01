# Bibliographic networks on selected topic

OpenAlex assigns to each work also some [keywords](https://help.openalex.org/hc/en-us/articles/24736201130391-Keywords) that describe its content.
For example for the field of network analysis we can use keywords [social-network-analysis](https://openalex.org/keywords/social-network-analysis) (Works count: 51.950), [social-network](https://openalex.org/keywords/social-network) (Works count: 96.250), and [complex-network](https://openalex.org/keywords/complex-network) (Works count: 49.090).

We [can](https://developers.openalex.org/guides/searching) combine the into a single search ([call](https://api.openalex.org/works?filter=keywords.id:social-network-analysis|social-network|complex-network&select=id,publication_year,title), Works count: 124999)
```
https://api.openalex.org/works?filter=keywords.id:social-network-analysis|social-network|complex-network&select=id,publication_year,title
```

To get the list of works and the corresponding citation network we use the function 
```
Q <- list(
  filter="keywords.id:social-network-analysis|social-network|complex-network",
  select=selCite,
  per_page="200"
)
OpenAlex2PajekCite(Q,1,name="NA")
```

```
```
```
```
```
```

<hr />

[OpenAlex2Pajek](../README.md)
