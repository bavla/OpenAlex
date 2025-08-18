# Author names and info


```
> Ids <- removehash(read.table("Cs1.net",skip=1,nrows=3101)$V2)
> Nas <- unitsInfo(IDs=Ids,units="authors",order="list",
+   select="id,display_name,works_count,cited_by_count")
> Nas$display_name <- gsub("‐","-",Nas$display_name)
> vector2nam(Nas$display_name,Nam="./3aug25/Cs1.nam")
```

```

```

```

```

```

```

<hr />

[OpenAlex2Pajek](../README.md)
