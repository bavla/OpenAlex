# OpenAlex2Pajek

**OpenAlex2Pajek** is an R a package of functions for constructing bibliographic networks from selected bibliographic data in OpenAlex. Currently, OpenAlex2Pajek contains three main functions `OpenAlex2PajekCite`, `OpenAlex2PajekAll`, and `coAuthorship`.

## Saturation approach to construct bibliographic networks on selected topic

We split the process of creating the collection of bibliographic networks into two parts:

  - determining the set W of relevant works using the [saturation approach](https://link.springer.com/article/10.1007/s11192-017-2522-8) [Batagelj et al., 2017, page 506],
  - creation of the network collection for the works from W.

<img src="https://github.com/user-attachments/assets/4b110be2-c6c5-4d91-9992-44cf9703a4d8" width="600" />


The set W is determined iteratively using the function `OpenAlex2PajekCite` and the collection is finally created using the function `OpenAlex2PajekAll`.

After each run of the function `OpenAlex2PajekCite` we read the last version of the citation network into [Pajek](https://core-prod.cambridgecore.org/core/books/exploratory-social-network-analysis-with-pajek/6F8EE2512CB7C6D233DB2DAC3886D4F5) and apply macro `expNodes` to it. It produces a vector of expansion nodes. Using the `vector-Info` button in Pajek we get a list of works with the largest input degree. We select an appropriate threshold and extract (select and copy) the upper part of the table into TextPad. In TextPad, we remove other columns and save the list of works as a CSV file. Using the function `joinLists` we combine the old list of works with the new one and save it for the next step of the saturation procedure.

The collection contains the citation network **Cite** and two-mode networks: authorship **WA**, sources **WJ**, keywords **WK**, countries **WC**, and work properties: publication year, type of publication, the language of publication, cited by count, countries distinct count, and referenced works.

```
```

```
```


## Temporal network of co-authorship between world countries

We developed a function coAuthorship that creates a temporal network describing the co-authorship between world countries in selected time periods. It turned out that OpenAlex is using the current [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) two-letter country codes to represent countries, dependent territories, and special areas of geographical interest. It doesn’t consider ex-countries such as SU (Soviet Union) or YU (Yugoslavia) – such allocations are transformed into the corresponding current countries. Another problem in creating the co-authorship network between world countries is that the above query returns information about up to 200 most collaborative countries. The problem is resolved by considering the symmetry of the co-authorship data.

```
```

## See also

  - Batagelj, V., Pisanski, J., Pisanski, T.: Higher-order bibliographic services based on bibliographic networks. IS2024-SIKDD_2024, Ljubljana, October 7 2024. [PDF](https://doi.org/10.70314/is.2024.sikdd.12) 
  - Batagelj, V.: OpenAlex2Pajek – an R Package for converting OpenAlex bibliographic data into Pajek networks.  COLLNET 2024, Strasbourg, December 12-14. V: Jain, Praveen Kumar (ur.), et al. Innovations in webometrics, informetrics, and scientometrics: AI-driven approaches and insights. Delhi: Bookwell, cop. 2024. p. 66-77. ISBN 978-93-86578-65-5.[arXiv](https://arxiv.org/abs/2501.06656)



