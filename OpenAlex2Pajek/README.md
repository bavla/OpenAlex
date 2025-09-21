# OpenAlex2Pajek

**OpenAlex2Pajek** is an R package of functions for constructing bibliographic networks from selected bibliographic data in OpenAlex. Currently, OpenAlex2Pajek contains four main functions `OpenAlex2PajekCite`, `OpenAlex2PajekAll`, `OpenAlexSources`, `OpenAlexAuthors`, and `coAuthorship`.

## Saturation approach to construct bibliographic networks on selected topic

We split the process of creating the collection of bibliographic networks into two parts:

  - determining the set W of relevant works using the [saturation approach](https://link.springer.com/article/10.1007/s11192-017-2522-8) [Batagelj et al., 2017, page 506],
  - creation of the network collection for the works from W.

<img src="https://github.com/user-attachments/assets/4b110be2-c6c5-4d91-9992-44cf9703a4d8" width="600" />


The set W is determined iteratively using the function `OpenAlex2PajekCite` and the collection is finally created using the function `OpenAlex2PajekAll`.

After each run of the function `OpenAlex2PajekCite` we read the last version of the citation network into [Pajek](http://mrvar.fdv.uni-lj.si/pajek/) and apply macro [`expNodes`](https://raw.githubusercontent.com/bavla/OpenAlex/refs/heads/main/code/expNodes.mcr) to it. It produces a vector of expansion nodes. Using the `vector-Info` button in Pajek we get a list of works with the largest input degree. We select an appropriate threshold and extract (select and copy) the upper part of the table into TextPad. In TextPad, we remove other columns and save the list of works as a CSV file. Using the function `joinLists` we combine the old list of works with the new one and save it for the next step of the saturation procedure.

The collection contains the citation network **Cite** and two-mode networks: authorship **WA**, sources **WJ**, keywords **WK**, countries **WC**, and work properties: publication year, type of publication, the language of publication, cited by count, countries distinct count, and referenced works.

The function `OpenAlexSources` creates the list of works related to a selected journal (all papers published by the journal chosen and all works citing/cited by these papers). Similary, the function `OpenAlexAuthors` creates the list of works related to selected authors (all works (co-)authored by the chosen authors).

Since in networks the units (works, authors, sources, keywords, etc.) are identified by their OpenAlex IDs, another function, `unitsInfo`, provides the user with additional information about the units appearing in the results of analyses. A more detailed information about authors is provided by functions `authorsId2name` and `worksId2name`.

### Examples

- [Bibliographic networks on selected topic](./doc/topic.md)
- [Bibliographic networks for selected persons](./doc/persons.md)
- [Bibliographic networks for selected institution](./doc/institution.md)
- [Temporal network of co-authorship between world countries](./doc/worldco.md)
- [Garfield labels and info about works](./doc/wnames.md) 
- [Names and info about authors](./doc/anames.md)
- [Journals](https://github.com/bavla/OpenAlex/tree/main/code/test/jour.md)
- 
OpenAlexSources(sID,step=100,cond="")  [Function `OpenAlexSources`](https://github.com/bavla/OpenAlex/tree/main/code/test/OpenAlexSources.md)

OpenAlexAuthors(IDs,step=100,cond="")

unitsInfo(IDs=NULL,units="works",select="id",trace=TRUE,cond="",order="alpha") [Function `unitsInfo`](https://github.com/bavla/OpenAlex/tree/main/code/test/unitsInfo.md)

authorsId2name(Ids,clu=NULL)


## See also

  - Batagelj, V., Pisanski, J., Pisanski, T.: Higher-order bibliographic services based on bibliographic networks. IS2024-SIKDD_2024, Ljubljana, October 7 2024. [PDF](https://doi.org/10.70314/is.2024.sikdd.12) 
  - Batagelj, V.: OpenAlex2Pajek – an R Package for converting OpenAlex bibliographic data into Pajek networks.  COLLNET 2024, Strasbourg, December 12-14. V: Jain, Praveen Kumar (ur.), et al. Innovations in webometrics, informetrics, and scientometrics: AI-driven approaches and insights. Delhi: Bookwell, cop. 2024. p. 66-77. ISBN 978-93-86578-65-5. [arXiv](https://arxiv.org/abs/2501.06656)
  - De Nooy, W., Mrvar, A., Batagelj, V. Exploratory social network analysis with Pajek: Revised and expanded edition for updated software. Vol. 46. Cambridge university press, 2018. [WWW](https://core-prod.cambridgecore.org/core/books/exploratory-social-network-analysis-with-pajek/6F8EE2512CB7C6D233DB2DAC3886D4F5)
  - OpenAlex: Client Libraries. [WWW](https://docs.openalex.org/how-to-use-the-api/api-overview#client-libraries)




