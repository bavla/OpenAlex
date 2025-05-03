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
## Creating the set of relevant works W

Let j be the selected source (journal). Determine (**A**) the set W<sub>j</sub> of works published in the journal j. Now we can determine the set W<sub>C</sub> of works citing some work from W<sub>j</sub> - for each k ∈ W<sub>j</sub> determine (**B**) the set W<sub>k</sub> of works citing the work k. The set W<sub>C</sub> is the union of all W<sub>k</sub>s. The set of relevant works is W = W<sub>C</sub> ∪ W<sub>j</sub>. Apply the procedure `OpenAlex2PajekAll` on W.

```

```


```

```


```

```


```

```


