# IMFM - Inštitut za matematiko, fiziko in mehaniko

https://api.openalex.org/institutions?search=imfm

https://openalex.org/institutions/I4210106342

We would like to restrict hits to the years 2001-2020

https://api.openalex.org/works?filter=institution.id:I4210106342,publication_year:2001-2020&select=id,title&per_page=200&page=2

We learn that researchers from HKUST published 9702 works in the years 2017-2019.

Now we are ready for the creation of the corresponding Pajek files.
```
> wdir <- "C:/Users/vlado/work/OpenAlex/API"
> setwd(wdir)
>  
> library(httr)
> library(jsonlite)
> source("https://raw.githubusercontent.com/bavla/Rnet/master/R/Pajek.R")
> source("https://raw.githubusercontent.com/bavla/OpenAlex/main/code/OpenAlex2.R")
> # source("OpenAlex2.R")
>
> Q <- list(
+   # filter="institution.id:I200769079,publication_year:2017-2019",
+   filter="institution.id:I4210106342,publication_year:2001-2020",
+   select=selAll,
+   per_page="200"
+ )
> # OpenAlex2PajekAll(Q,name="HKUST")
> OpenAlex2PajekAll(Q,name="IMFM")
OpenAlex2Pajek / All - Start Tue May 21 18:22:25 2024 
*** OpenAlex2Pajek / All - Process Tue May 21 18:22:25 2024 
Tue May 21 18:22:34 2024  n = 500 
Tue May 21 18:22:40 2024  n = 1000 
Tue May 21 18:22:47 2024  n = 1500 
*** OpenAlex2Pajek / All - Data Collected Tue May 21 18:22:47 2024 
hits: 1596 works: 22321 authors: 2125 anon: 0 sources: 452 
>>> Citation Cite
>>> publication year
>>> type of publication
>>> language of publication
>>> cited by count
>>> countries distinct count
>>> referenced works
>>> Authorship WA
>>> Sources WJ
>>> Countries WC
>>> Keywords WK
*** OpenAlex2Pajek / All - Stop Tue May 21 18:22:52 2024 
> 
```

  * read WA
  * network/2-mode/transpose
  * select WA as the Second network
  * networks/Multiply
  * network/create/transform/arcs to edges/bidirected/min
  * network/create/transform/add/vertex labs/default
  * network/create/transform/add/vertex labs/from file(s) [IMFMWA.nam]
  * network/vector/get loops
  * vector info button [+50]


|  i |  d  |author		  |
|----|-----|----------------------|
|  1 |252  |Zvonko Jagličić	  |
|  2 |116  |Dušan Repovš		  |
|  3 | 92  |Sandi Klavžar	  |
|  4 | 65  |Marko Jagodič	  |
|  5 | 61  |Z. Trontelj		  |
|  6 | 56  |J. Dolinšek		  |
|  7 | 53  |Franc Forstnerič	  |
|  8 | 53  |Boštjan Brešar	  |
|  9 | 43  |Janez Žerovnik	  |
| 10 | 39  |Vicenţiu D. Rădulescu  |
| 11 | 35  |Primož Potočnik	  |
| 12 | 34  |Josip Globevnik	  |
| 13 | 32  |Vladimir Batagelj	  |
| 14 | 31  |Vojko Jazbinšek	  |
| 15 | 31  |Bojan Kuzma		  |
| 16 | 28  |Tomaž Pisanski	  |
| 17 | 27  |Matija Cencelj	  |
| 18 | 26  |Igor Klep		  |
| 19 | 26  |Sergio Cabello	  |
| 20 | 25  |Riste Škrekovski	  |

  * network/create/transform/remove/loops
  * network/info/line values
  * link cut at level 7
    * network/create/transform/remove/lines with value/lower than [7]
    * network/partition/degree/all
    * operations/network+partition/extract/subnetwork [1-*]
    * network/partition/components/weak
  * draw network+partition
  * 

<img src="https://github.com/bavla/OpenAlex/blob/main/code/ex/IMFMcut7.svg?sanitize=true">


<img src="https://raw.githubusercontent.com/bavla/TQ/master/trajectories/Feb24/Feb24Edu.svg?sanitize=true">

https://github.com/bavla/OpenAlex/blob/main/code/ex/IMFMcut7.svg



