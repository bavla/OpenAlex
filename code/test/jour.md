# Journals

## Collecting works

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
**C.** List of works cited by a given work [call](https://api.openalex.org/works?filter=cites:W2922895789&select=id,title,type,cited_by_count,publication_year,referenced_works)

```
https://api.openalex.org/works?filter=cites:W2922895789&
select=id,title,type,cited_by_count,publication_year,referenced_works
```

## Creating the set of relevant works W and networks

**D.** Let j be the selected source (journal). Determine (**A**) the set W<sub>j</sub> of works published in the journal j. Now we can determine 
  * the set W<sub>in</sub> of works citing some work from W<sub>j</sub> - for each k ∈ W<sub>j</sub> determine (**B**) the set W<sub>k</sub> of works citing the work k.  The set W<sub>in</sub> is the union of all W<sub>k</sub>s.
  * the set W<sub>out</sub> of works cited from some work from W<sub>j</sub> - for each k ∈ W<sub>j</sub> determine (**C**) the set W<sub>k</sub> of works cited by the work k.  The set W<sub>out</sub> is the union of all W<sub>k</sub>s.
  * the set of relevant works is W = W<sub>in</sub> ∪ W<sub>j</sub> ∪ W<sub>out</sub>. To get networks apply the procedure `OpenAlex2PajekAll` on W.

Note that for sources different from j only the citations from/to j are complete. Other citations consider only cases where at least one end-node is a work from the source j.
The obtained networks can be used to determine the set of important sources J.

**E.** For each important source j from J we determine (**D**) the corresponding set of relevant works. The union of these set W<sub>J</sub> is used in the procedure `OpenAlex2PajekAll` to create networks. Now, the citation data are complete for all sources from J (but not for the other sources).

The size of the set W<sub>J</sub> can be very large. To reduce it we can consider some restriction such us interval of considered year of publication, type of publication, etc.


```

```


```

```


```

```


