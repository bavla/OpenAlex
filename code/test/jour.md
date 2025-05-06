# Journals

May 4, 2025

## Collecting works

If you open these examples in a web browser, they will look much better if you have a browser plug-in such as [JSONVue](https://chromewebstore.google.com/detail/jsonvue/chklaanhfefbnpoihckbnefhakgolnmc) installed.

**A.** List of works published by a given source (journal) [call](https://api.openalex.org/works?filter=primary_location.source.id:s4210233660&select=id,title,type,cited_by_count,publication_year) - in a single line
```
https://api.openalex.org/works?filter=primary_location.source.id:s4210233660&
select=id,title,type,cited_by_count,publication_year
```
**B.** List of citing works of a given work [call](https://api.openalex.org/works?filter=cites:W2922895789&select=id,title,type,cited_by_count,publication_year&per_page=200&page=1)

```
https://api.openalex.org/works?filter=cites:W2922895789&
select=id,title,type,cited_by_count,publication_year&per_page=200&page=1
```
**C.** List of works cited by a given work [call](https://api.openalex.org/works?filter=openalex:W2922895789|W4250234346|W3010751055|W3011442895|W3041317610|W4406275124&select=id,title,publication_year,referenced_works))

```
https://api.openalex.org/works?filter=openalex:W2922895789|W4250234346|W3010751055|W3011442895|W3041317610|W4406275124&
select=id,title,publication_year,referenced_works
```

## Creating the set of relevant works W and networks

**D.** Let j be the selected source (journal). Determine (**A**) the set W<sub>j</sub> of works published in the journal j. Now we can determine 
  * the set W<sub>in</sub> of works citing some work from W<sub>j</sub> - for each k ∈ W<sub>j</sub> determine (**B**) the set W<sub>k</sub> of works citing the work k.  The set W<sub>in</sub> is the union of all W<sub>k</sub>s.
  * the set W<sub>out</sub> of works cited from some work from W<sub>j</sub> - for each k ∈ W<sub>j</sub> determine (**C**) the set W<sub>k</sub> of works cited by the work k.  The set W<sub>out</sub> is the union of all W<sub>k</sub>s.
  * the set of relevant works is W = W<sub>in</sub> ∪ W<sub>j</sub> ∪ W<sub>out</sub>. To get networks apply the procedure `OpenAlex2PajekAll` on W.

Note that for sources different from j only the citations from/to j are complete. Other citations consider only cases where at least one end-node is related to a work from the source j.
The obtained networks can be used to determine the set of important sources J.

**E.** For each important source j from J we determine (**D**) the corresponding set of relevant works. The union of these set W<sub>J</sub> is used in the procedure `OpenAlex2PajekAll` to create networks. Now, the citation data are complete for all sources from J (but not for the other sources).

The size of the set W<sub>J</sub> can be very large. To reduce it we can consider some restriction such us interval of considered year of publication, type of publication, etc.

## Programming and applying OpenAlexSources

The programming of the function is traced in [First version](first.md). It resulted into two functions [`OpenAlexSources`](OpenAlexSources.md) and [`unitsInfo`](unitsInfo.md).

To build networks for a selected source sID is now simple. First we create a vector R of all works from sID, works citing them, and works cited by them.   - 
```
> setwd(wdir <- "C:/test/OpenAlex/sources")
> library(httr); library(jsonlite)
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2Pajek.R")
> sID <- "s4210233660"
> R <- OpenAlexSources(sID,step=250)
OpenAlex2Pajek / Sources Tue May  6 19:32:47 2025 
i = 1  nr = 200 
i = 2  nr = 200 
i = 3  nr = 200 
i = 4  nr = 200 
i = 5  nr = 200 
i = 6  nr = 200 
i = 7  nr = 200 
i = 8  nr = 200 
i = 9  nr = 200 
i = 10  nr = 200 
i = 11  nr = 200 
i = 12  nr = 200 
i = 13  nr = 122 
2522 source s4210233660 works collected Tue May  6 19:32:50 2025 
...
 4092 citing works collected Tue May  6 19:38:59 2025 
..........
 14515 cited works collected Tue May  6 19:39:10 2025 
17642 different works Tue May  6 19:39:10 2025 
```
We save the vector R in a file.
```
> csv <- file("worksTest.csv","w",encoding="UTF-8")
> write(R,sep="\n",file=csv)
> close(csv)
```
To get the networks we apply `OpenAlex2PajekAll` to R
```
> OpenAlex2PajekAll(NULL,name="Dasha",listF="worksTest.csv")
```
See [First version](first.md).

