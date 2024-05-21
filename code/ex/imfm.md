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








![IMFMcut7](https://github.com/bavla/OpenAlex/assets/20244435/5f658ddc-eb28-4382-be42-f4f8111f1902)
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- Created with Inkscape (http://www.inkscape.org/) -->

<svg
   width="251.13887mm"
   height="171.06534mm"
   viewBox="0 0 251.13887 171.06534"
   version="1.1"
   id="svg1"
   xml:space="preserve"
   inkscape:version="1.3.2 (091e20e, 2023-11-25, custom)"
   sodipodi:docname="IMFMcut7.svg"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:svg="http://www.w3.org/2000/svg"><sodipodi:namedview
     id="namedview1"
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1.0"
     inkscape:showpageshadow="2"
     inkscape:pageopacity="0.0"
     inkscape:pagecheckerboard="0"
     inkscape:deskcolor="#d1d1d1"
     inkscape:document-units="mm"
     inkscape:zoom="0.7786055"
     inkscape:cx="469.429"
     inkscape:cy="430.2564"
     inkscape:window-width="1920"
     inkscape:window-height="1112"
     inkscape:window-x="-8"
     inkscape:window-y="-8"
     inkscape:window-maximized="1"
     inkscape:current-layer="layer1" /><defs
     id="defs1" /><g
     inkscape:label="Layer 1"
     inkscape:groupmode="layer"
     id="layer1"
     transform="translate(19.37664,-34.59262)"><g
       id="PajekSig"
       inkscape:label="PajekSignature"
       transform="matrix(0.26458333,0,0,0.26458333,-20.327878,-26.839933)">
<g
   transform="translate(3,863)"
   id="g8">
<g
   transform="scale(0.1)"
   id="g7">
<g
   transform="matrix(1,0,0,-1,0,96)"
   id="g6">
<path
   d="m 7.67,49.98 24.09,22.78 15.15,5.87 10.32,1.86 M 72.86,65.23 65.73,83.25 57.06,75.49 56.75,68.65 m 19.52,-0.62 -0.62,16.47 18.27,6.52 13.32,-16.15 m -26.95,-7.15 8.99,17.09 15.49,-3.11 11.46,-8.39 4.95,-13.98 M 56.75,81.08 71.31,64.3"
   style="fill:none;stroke:#8b4513;stroke-width:5"
   id="path1" />
<path
   d="m 86.18,70.21 5.27,2.79 4.33,-3.42 m -4.64,-8.7 4.95,1.87 2.17,-3.42"
   style="fill:none;stroke:#8b4513;stroke-width:1.5"
   id="path2" />
<path
   d="m 81.07,49.08 h 6.74 l 5.49,5.3 v 6.5 6.51 l -5.49,5.3 h -6.74 -6.74 l -5.5,-5.3 v -6.51 -6.5 l 5.5,-5.3 z"
   style="fill:#800000;stroke:#8b4513;stroke-width:1"
   id="path3" />
<path
   d="m 54.63,37.53 13.9,6.03 6.86,12.29 -5.49,9.5 -5.49,7.51 -15.81,1.2 -13.89,-6.02 -13.9,-13.02 -4.86,-14.3 1.49,-7.5 7.48,-4.5 15.81,1.79 z"
   style="fill:#800000;stroke:#8b4513;stroke-width:1"
   id="path4" />
<path
   d="m 77.82,50.63 26.02,8.7 27.26,-15.53 8.36,-15.85 -0.31,-12.12 M 35.99,5.27 47.15,32.92 61.71,50.01 70.07,46.9 82.77,45.04 83.39,27.02 65.42,12.11 m 3.1,38.52 22.62,-1.24 12.39,-6.22 13.63,-20.5 -1.86,-14.29"
   style="fill:none;stroke:#8b4513;stroke-width:5"
   id="path5" />
<path
   d="m 41.57,54.98 18.59,9.63 m -7.75,1.56 5.58,-8.7"
   style="fill:none;stroke:#ffffff;stroke-width:5"
   id="path6" />
</g>
</g>
<animateMotion
   dur="20s"
   path="M3 0 L972 0"
   begin="120s"
   fill="freeze" />
</g>
<g
   transform="translate(3,863)"
   id="g10">
<g
   transform="scale(0.1)"
   id="g9">
<text
   x="5"
   y="140"
   style="font-size:75px;font-family:'Brush Script MT';fill:#008000"
   id="text8">Pajek</text>
</g>
<animateMotion
   dur="0.1s"
   path="M3 0 L972 0"
   begin="120s"
   fill="freeze" />
</g>
</g><g
       id="PajekNet"
       inkscape:label="PajekNetwork"
       transform="matrix(0.26458333,0,0,0.26458333,-23.046413,29.909495)">

<!-- Edge:     1    2 -->
<line
   x1="148.89999"
   y1="162.35001"
   x2="106.53"
   y2="173.21001"
   style="stroke:#999999;stroke-width:2.1"
   id="line10" />
<!-- Edge:     1    3 -->
<line
   x1="148.89999"
   y1="162.35001"
   x2="142.25"
   y2="176.13"
   style="stroke:#999999;stroke-width:1.2"
   id="line11" />
<!-- Edge:     1    5 -->
<line
   x1="148.89999"
   y1="162.35001"
   x2="229.32001"
   y2="209.07001"
   style="stroke:#999999;stroke-width:2.1"
   id="line12" />
<!-- Edge:     1    7 -->
<line
   x1="148.89999"
   y1="162.35001"
   x2="92.709999"
   y2="57.060001"
   style="stroke:#999999;stroke-width:1.95"
   id="line13" />
<!-- Edge:     2    3 -->
<line
   x1="106.53"
   y1="173.21001"
   x2="142.25"
   y2="176.13"
   style="stroke:#999999;stroke-width:1.35"
   id="line14" />
<!-- Edge:     2    5 -->
<line
   x1="106.53"
   y1="173.21001"
   x2="229.32001"
   y2="209.07001"
   style="stroke:#999999;stroke-width:3.75"
   id="line15" />
<!-- Edge:     2    6 -->
<line
   x1="106.53"
   y1="173.21001"
   x2="132.86"
   y2="144.39"
   style="stroke:#999999;stroke-width:1.35"
   id="line16" />
<!-- Edge:     2    7 -->
<line
   x1="106.53"
   y1="173.21001"
   x2="92.709999"
   y2="57.060001"
   style="stroke:#999999;stroke-width:3.3"
   id="line17" />
<!-- Edge:     2   47 -->
<line
   x1="106.53"
   y1="173.21001"
   x2="95.029999"
   y2="183.23"
   style="stroke:#999999;stroke-width:1.05"
   id="line18" />
<!-- Edge:     3    5 -->
<line
   x1="142.25"
   y1="176.13"
   x2="229.32001"
   y2="209.07001"
   style="stroke:#999999;stroke-width:1.8"
   id="line19" />
<!-- Edge:     3    7 -->
<line
   x1="142.25"
   y1="176.13"
   x2="92.709999"
   y2="57.060001"
   style="stroke:#999999;stroke-width:1.95"
   id="line20" />
<!-- Edge:     4    5 -->
<line
   x1="318.39999"
   y1="272.60999"
   x2="229.32001"
   y2="209.07001"
   style="stroke:#999999;stroke-width:1.35"
   id="line21" />
<!-- Edge:     5    6 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="132.86"
   y2="144.39"
   style="stroke:#999999;stroke-width:2.55"
   id="line22" />
<!-- Edge:     5    7 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="92.709999"
   y2="57.060001"
   style="stroke:#999999;stroke-width:8.1"
   id="line23" />
<!-- Edge:     5   12 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="345.47"
   y2="81.540001"
   style="stroke:#999999;stroke-width:6.45"
   id="line24" />
<!-- Edge:     5   13 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="280.20999"
   y2="314.06"
   style="stroke:#999999;stroke-width:1.05"
   id="line25" />
<!-- Edge:     5   14 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="263.31"
   y2="87.169998"
   style="stroke:#999999;stroke-width:2.55"
   id="line26" />
<!-- Edge:     5   17 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="346.57999"
   y2="197.48"
   style="stroke:#999999;stroke-width:2.4"
   id="line27" />
<!-- Edge:     5   18 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="118.64"
   y2="233.35001"
   style="stroke:#999999;stroke-width:3.3"
   id="line28" />
<!-- Edge:     5   19 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="323.22"
   y2="216.5"
   style="stroke:#999999;stroke-width:1.05"
   id="line29" />
<!-- Edge:     5   21 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="108.75"
   y2="252.23"
   style="stroke:#999999;stroke-width:3.45"
   id="line30" />
<!-- Edge:     5   22 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="343.26001"
   y2="160.12"
   style="stroke:#999999;stroke-width:2.7"
   id="line31" />
<!-- Edge:     5   24 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="142.55"
   y2="123.51"
   style="stroke:#999999;stroke-width:1.05"
   id="line32" />
<!-- Edge:     5   27 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="329.98999"
   y2="140.78999"
   style="stroke:#999999;stroke-width:1.35"
   id="line33" />
<!-- Edge:     5   30 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="111.68"
   y2="201.61"
   style="stroke:#999999;stroke-width:1.35"
   id="line34" />
<!-- Edge:     5   32 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="311.44"
   y2="97.190002"
   style="stroke:#999999;stroke-width:2.55"
   id="line35" />
<!-- Edge:     5   37 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="138.61"
   y2="216.64"
   style="stroke:#999999;stroke-width:2.25"
   id="line36" />
<!-- Edge:     5   44 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="197.63"
   y2="101.37"
   style="stroke:#999999;stroke-width:1.05"
   id="line37" />
<!-- Edge:     5   45 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="200.36"
   y2="86.75"
   style="stroke:#999999;stroke-width:3"
   id="line38" />
<!-- Edge:     5   46 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="164.34"
   y2="95.110001"
   style="stroke:#999999;stroke-width:1.5"
   id="line39" />
<!-- Edge:     5   47 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="95.029999"
   y2="183.23"
   style="stroke:#999999;stroke-width:2.1"
   id="line40" />
<!-- Edge:     5   48 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="196.12"
   y2="125.59"
   style="stroke:#999999;stroke-width:1.95"
   id="line41" />
<!-- Edge:     5   49 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="169.17999"
   y2="116.41"
   style="stroke:#999999;stroke-width:1.2"
   id="line42" />
<!-- Edge:     5   50 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="148.60001"
   y2="107.22"
   style="stroke:#999999;stroke-width:1.35"
   id="line43" />
<!-- Edge:     5   51 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="182.31"
   y2="281.20999"
   style="stroke:#999999;stroke-width:1.2"
   id="line44" />
<!-- Edge:     5   52 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="170.75999"
   y2="320.45999"
   style="stroke:#999999;stroke-width:1.65"
   id="line45" />
<!-- Edge:     5   53 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="130.32001"
   y2="265.75"
   style="stroke:#999999;stroke-width:2.55"
   id="line46" />
<!-- Edge:     5   54 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="174.57001"
   y2="258.67001"
   style="stroke:#999999;stroke-width:2.25"
   id="line47" />
<!-- Edge:     5   56 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="253.11"
   y2="330.16"
   style="stroke:#999999;stroke-width:2.4"
   id="line48" />
<!-- Edge:     5   67 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="291.82001"
   y2="305.04001"
   style="stroke:#999999;stroke-width:1.5"
   id="line49" />
<!-- Edge:     5   68 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="211.56"
   y2="77.980003"
   style="stroke:#999999;stroke-width:1.2"
   id="line50" />
<!-- Edge:     5   70 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="329.42999"
   y2="241.92"
   style="stroke:#999999;stroke-width:1.8"
   id="line51" />
<!-- Edge:     5   71 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="323.35001"
   y2="256.09"
   style="stroke:#999999;stroke-width:1.65"
   id="line52" />
<!-- Edge:     5   77 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="223.97"
   y2="110.98"
   style="stroke:#999999;stroke-width:1.8"
   id="line53" />
<!-- Edge:     5   78 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="248.17999"
   y2="123.09"
   style="stroke:#999999;stroke-width:1.65"
   id="line54" />
<!-- Edge:     5   79 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="232.14"
   y2="140.63"
   style="stroke:#999999;stroke-width:1.5"
   id="line55" />
<!-- Edge:     5   80 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="142.85001"
   y2="134.78"
   style="stroke:#999999;stroke-width:1.2"
   id="line56" />
<!-- Edge:     5   82 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="282.57001"
   y2="166.13"
   style="stroke:#999999;stroke-width:1.2"
   id="line57" />
<!-- Edge:     5   83 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="236.50999"
   y2="337.25"
   style="stroke:#999999;stroke-width:1.65"
   id="line58" />
<!-- Edge:     5   86 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="300.67001"
   y2="295.38"
   style="stroke:#999999;stroke-width:1.2"
   id="line59" />
<!-- Edge:     5   87 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="268.59"
   y2="322.42999"
   style="stroke:#999999;stroke-width:1.05"
   id="line60" />
<!-- Edge:     5   96 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="274.20999"
   y2="135.62"
   style="stroke:#999999;stroke-width:1.8"
   id="line61" />
<!-- Edge:     5   97 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="272.09"
   y2="106.8"
   style="stroke:#999999;stroke-width:1.35"
   id="line62" />
<!-- Edge:     5  101 -->
<line
   x1="229.32001"
   y1="209.07001"
   x2="311.73001"
   y2="282.5"
   style="stroke:#999999;stroke-width:1.2"
   id="line63" />
<!-- Edge:     6    7 -->
<line
   x1="132.86"
   y1="144.39"
   x2="92.709999"
   y2="57.060001"
   style="stroke:#999999;stroke-width:2.4"
   id="line64" />
<!-- Edge:     6   80 -->
<line
   x1="132.86"
   y1="144.39"
   x2="142.85001"
   y2="134.78"
   style="stroke:#999999;stroke-width:1.2"
   id="line65" />
<!-- Edge:     7   12 -->
<line
   x1="92.709999"
   y1="57.060001"
   x2="345.47"
   y2="81.540001"
   style="stroke:#999999;stroke-width:1.95"
   id="line66" />
<!-- Edge:     7   24 -->
<line
   x1="92.709999"
   y1="57.060001"
   x2="142.55"
   y2="123.51"
   style="stroke:#999999;stroke-width:1.05"
   id="line67" />
<!-- Edge:     7   44 -->
<line
   x1="92.709999"
   y1="57.060001"
   x2="197.63"
   y2="101.37"
   style="stroke:#999999;stroke-width:1.05"
   id="line68" />
<!-- Edge:     7   45 -->
<line
   x1="92.709999"
   y1="57.060001"
   x2="200.36"
   y2="86.75"
   style="stroke:#999999;stroke-width:2.85"
   id="line69" />
<!-- Edge:     7   46 -->
<line
   x1="92.709999"
   y1="57.060001"
   x2="164.34"
   y2="95.110001"
   style="stroke:#999999;stroke-width:1.5"
   id="line70" />
<!-- Edge:     7   47 -->
<line
   x1="92.709999"
   y1="57.060001"
   x2="95.029999"
   y2="183.23"
   style="stroke:#999999;stroke-width:2.25"
   id="line71" />
<!-- Edge:     7   48 -->
<line
   x1="92.709999"
   y1="57.060001"
   x2="196.12"
   y2="125.59"
   style="stroke:#999999;stroke-width:1.05"
   id="line72" />
<!-- Edge:     7   49 -->
<line
   x1="92.709999"
   y1="57.060001"
   x2="169.17999"
   y2="116.41"
   style="stroke:#999999;stroke-width:1.2"
   id="line73" />
<!-- Edge:     7   50 -->
<line
   x1="92.709999"
   y1="57.060001"
   x2="148.60001"
   y2="107.22"
   style="stroke:#999999;stroke-width:1.05"
   id="line74" />
<!-- Edge:     7   68 -->
<line
   x1="92.709999"
   y1="57.060001"
   x2="211.56"
   y2="77.980003"
   style="stroke:#999999;stroke-width:1.2"
   id="line75" />
<!-- Edge:     7   80 -->
<line
   x1="92.709999"
   y1="57.060001"
   x2="142.85001"
   y2="134.78"
   style="stroke:#999999;stroke-width:1.2"
   id="line76" />
<!-- Edge:     8    9 -->
<line
   x1="833.46997"
   y1="85.739998"
   x2="781.63"
   y2="34.299999"
   style="stroke:#999999;stroke-width:2.25"
   id="line77" />
<!-- Edge:     8   10 -->
<line
   x1="833.46997"
   y1="85.739998"
   x2="756.21997"
   y2="110.39"
   style="stroke:#999999;stroke-width:2.4"
   id="line78" />
<!-- Edge:     9   10 -->
<line
   x1="781.63"
   y1="34.299999"
   x2="756.21997"
   y2="110.39"
   style="stroke:#999999;stroke-width:4.8"
   id="line79" />
<!-- Edge:     9   28 -->
<line
   x1="781.63"
   y1="34.299999"
   x2="702.34998"
   y2="60.02"
   style="stroke:#999999;stroke-width:1.8"
   id="line80" />
<!-- Edge:    10   28 -->
<line
   x1="756.21997"
   y1="110.39"
   x2="702.34998"
   y2="60.02"
   style="stroke:#999999;stroke-width:1.8"
   id="line81" />
<!-- Edge:    10   66 -->
<line
   x1="756.21997"
   y1="110.39"
   x2="762.32001"
   y2="171.48"
   style="stroke:#999999;stroke-width:2.4"
   id="line82" />
<!-- Edge:    10   91 -->
<line
   x1="756.21997"
   y1="110.39"
   x2="704.38"
   y2="135.03999"
   style="stroke:#999999;stroke-width:1.2"
   id="line83" />
<!-- Edge:    10  105 -->
<line
   x1="756.21997"
   y1="110.39"
   x2="835.5"
   y2="150.05"
   style="stroke:#999999;stroke-width:1.65"
   id="line84" />
<!-- Edge:    11   42 -->
<line
   x1="513.29999"
   y1="322.60001"
   x2="591.56"
   y2="361.19"
   style="stroke:#999999;stroke-width:1.5"
   id="line85" />
<!-- Edge:    11  107 -->
<line
   x1="513.29999"
   y1="322.60001"
   x2="442.14999"
   y2="380.48001"
   style="stroke:#999999;stroke-width:1.35"
   id="line86" />
<!-- Edge:    11  108 -->
<line
   x1="513.29999"
   y1="322.60001"
   x2="532.60999"
   y2="421.20999"
   style="stroke:#999999;stroke-width:1.5"
   id="line87" />
<!-- Edge:    12   14 -->
<line
   x1="345.47"
   y1="81.540001"
   x2="263.31"
   y2="87.169998"
   style="stroke:#999999;stroke-width:1.2"
   id="line88" />
<!-- Edge:    12   22 -->
<line
   x1="345.47"
   y1="81.540001"
   x2="343.26001"
   y2="160.12"
   style="stroke:#999999;stroke-width:1.65"
   id="line89" />
<!-- Edge:    12   27 -->
<line
   x1="345.47"
   y1="81.540001"
   x2="329.98999"
   y2="140.78999"
   style="stroke:#999999;stroke-width:1.35"
   id="line90" />
<!-- Edge:    12   31 -->
<line
   x1="345.47"
   y1="81.540001"
   x2="346.60001"
   y2="22.51"
   style="stroke:#999999;stroke-width:1.8"
   id="line91" />
<!-- Edge:    12   32 -->
<line
   x1="345.47"
   y1="81.540001"
   x2="311.44"
   y2="97.190002"
   style="stroke:#999999;stroke-width:1.35"
   id="line92" />
<!-- Edge:    12   82 -->
<line
   x1="345.47"
   y1="81.540001"
   x2="282.57001"
   y2="166.13"
   style="stroke:#999999;stroke-width:1.35"
   id="line93" />
<!-- Edge:    12   98 -->
<line
   x1="345.47"
   y1="81.540001"
   x2="303.91"
   y2="35.369999"
   style="stroke:#999999;stroke-width:1.05"
   id="line94" />
<!-- Edge:    14   32 -->
<line
   x1="263.31"
   y1="87.169998"
   x2="311.44"
   y2="97.190002"
   style="stroke:#999999;stroke-width:1.5"
   id="line95" />
<!-- Edge:    14   77 -->
<line
   x1="263.31"
   y1="87.169998"
   x2="223.97"
   y2="110.98"
   style="stroke:#999999;stroke-width:1.35"
   id="line96" />
<!-- Edge:    14   78 -->
<line
   x1="263.31"
   y1="87.169998"
   x2="248.17999"
   y2="123.09"
   style="stroke:#999999;stroke-width:1.35"
   id="line97" />
<!-- Edge:    14   79 -->
<line
   x1="263.31"
   y1="87.169998"
   x2="232.14"
   y2="140.63"
   style="stroke:#999999;stroke-width:1.2"
   id="line98" />
<!-- Edge:    15   59 -->
<line
   x1="545.79999"
   y1="123.18"
   x2="551.08002"
   y2="189.11"
   style="stroke:#999999;stroke-width:3"
   id="line99" />
<!-- Edge:    15   61 -->
<line
   x1="545.79999"
   y1="123.18"
   x2="490.26999"
   y2="90.879997"
   style="stroke:#999999;stroke-width:2.1"
   id="line100" />
<!-- Edge:    15   62 -->
<line
   x1="545.79999"
   y1="123.18"
   x2="538.71002"
   y2="46.09"
   style="stroke:#999999;stroke-width:1.05"
   id="line101" />
<!-- Edge:    15   65 -->
<line
   x1="545.79999"
   y1="123.18"
   x2="495"
   y2="154.34"
   style="stroke:#999999;stroke-width:1.65"
   id="line102" />
<!-- Edge:    15   99 -->
<line
   x1="545.79999"
   y1="123.18"
   x2="592.58002"
   y2="78.239998"
   style="stroke:#999999;stroke-width:1.5"
   id="line103" />
<!-- Edge:    16   20 -->
<line
   x1="21.360001"
   y1="348.20001"
   x2="53.439999"
   y2="317.28"
   style="stroke:#999999;stroke-width:1.05"
   id="line104" />
<!-- Edge:    17   19 -->
<line
   x1="346.57999"
   y1="197.48"
   x2="323.22"
   y2="216.5"
   style="stroke:#999999;stroke-width:1.05"
   id="line105" />
<!-- Edge:    18   30 -->
<line
   x1="118.64"
   y1="233.35001"
   x2="111.68"
   y2="201.61"
   style="stroke:#999999;stroke-width:1.2"
   id="line106" />
<!-- Edge:    18   37 -->
<line
   x1="118.64"
   y1="233.35001"
   x2="138.61"
   y2="216.64"
   style="stroke:#999999;stroke-width:1.8"
   id="line107" />
<!-- Edge:    20   21 -->
<line
   x1="53.439999"
   y1="317.28"
   x2="108.75"
   y2="252.23"
   style="stroke:#999999;stroke-width:3.15"
   id="line108" />
<!-- Edge:    20   23 -->
<line
   x1="53.439999"
   y1="317.28"
   x2="58.419998"
   y2="280.57001"
   style="stroke:#999999;stroke-width:1.8"
   id="line109" />
<!-- Edge:    20   29 -->
<line
   x1="53.439999"
   y1="317.28"
   x2="25.24"
   y2="228.39"
   style="stroke:#999999;stroke-width:1.65"
   id="line110" />
<!-- Edge:    21   23 -->
<line
   x1="108.75"
   y1="252.23"
   x2="58.419998"
   y2="280.57001"
   style="stroke:#999999;stroke-width:3"
   id="line111" />
<!-- Edge:    21   29 -->
<line
   x1="108.75"
   y1="252.23"
   x2="25.24"
   y2="228.39"
   style="stroke:#999999;stroke-width:3.6"
   id="line112" />
<!-- Edge:    21   36 -->
<line
   x1="108.75"
   y1="252.23"
   x2="110.41"
   y2="301.82001"
   style="stroke:#999999;stroke-width:1.8"
   id="line113" />
<!-- Edge:    21   38 -->
<line
   x1="108.75"
   y1="252.23"
   x2="73.910004"
   y2="215.50999"
   style="stroke:#999999;stroke-width:1.05"
   id="line114" />
<!-- Edge:    21   85 -->
<line
   x1="108.75"
   y1="252.23"
   x2="63.400002"
   y2="256.09"
   style="stroke:#999999;stroke-width:1.2"
   id="line115" />
<!-- Edge:    22   25 -->
<line
   x1="343.26001"
   y1="160.12"
   x2="361.85001"
   y2="118.97"
   style="stroke:#999999;stroke-width:1.05"
   id="line116" />
<!-- Edge:    22   26 -->
<line
   x1="343.26001"
   y1="160.12"
   x2="352.70001"
   y2="181.13"
   style="stroke:#999999;stroke-width:1.05"
   id="line117" />
<!-- Edge:    22   27 -->
<line
   x1="343.26001"
   y1="160.12"
   x2="329.98999"
   y2="140.78999"
   style="stroke:#999999;stroke-width:1.8"
   id="line118" />
<!-- Edge:    23   29 -->
<line
   x1="58.419998"
   y1="280.57001"
   x2="25.24"
   y2="228.39"
   style="stroke:#999999;stroke-width:2.55"
   id="line119" />
<!-- Edge:    23   85 -->
<line
   x1="58.419998"
   y1="280.57001"
   x2="63.400002"
   y2="256.09"
   style="stroke:#999999;stroke-width:1.2"
   id="line120" />
<!-- Edge:    29   85 -->
<line
   x1="25.24"
   y1="228.39"
   x2="63.400002"
   y2="256.09"
   style="stroke:#999999;stroke-width:1.2"
   id="line121" />
<!-- Edge:    30   37 -->
<line
   x1="111.68"
   y1="201.61"
   x2="138.61"
   y2="216.64"
   style="stroke:#999999;stroke-width:1.2"
   id="line122" />
<!-- Edge:    32   96 -->
<line
   x1="311.44"
   y1="97.190002"
   x2="274.20999"
   y2="135.62"
   style="stroke:#999999;stroke-width:1.5"
   id="line123" />
<!-- Edge:    32   97 -->
<line
   x1="311.44"
   y1="97.190002"
   x2="272.09"
   y2="106.8"
   style="stroke:#999999;stroke-width:1.05"
   id="line124" />
<!-- Edge:    33   34 -->
<line
   x1="198.31"
   y1="553.25"
   x2="198.31"
   y2="623.63"
   style="stroke:#999999;stroke-width:1.5"
   id="line125" />
<!-- Edge:    35   81 -->
<line
   x1="503.95001"
   y1="560.75"
   x2="503.95001"
   y2="631.13"
   style="stroke:#999999;stroke-width:1.05"
   id="line126" />
<!-- Edge:    39   40 -->
<line
   x1="652.65002"
   y1="564"
   x2="652.65002"
   y2="634.38"
   style="stroke:#999999;stroke-width:1.05"
   id="line127" />
<!-- Edge:    41   70 -->
<line
   x1="368.95999"
   y1="235.78999"
   x2="329.42999"
   y2="241.92"
   style="stroke:#999999;stroke-width:1.05"
   id="line128" />
<!-- Edge:    43   60 -->
<line
   x1="187.02"
   y1="407.26999"
   x2="292.73001"
   y2="378.34"
   style="stroke:#999999;stroke-width:1.05"
   id="line129" />
<!-- Edge:    43   76 -->
<line
   x1="187.02"
   y1="407.26999"
   x2="86.400002"
   y2="429.78"
   style="stroke:#999999;stroke-width:1.5"
   id="line130" />
<!-- Edge:    44   45 -->
<line
   x1="197.63"
   y1="101.37"
   x2="200.36"
   y2="86.75"
   style="stroke:#999999;stroke-width:1.05"
   id="line131" />
<!-- Edge:    44   46 -->
<line
   x1="197.63"
   y1="101.37"
   x2="164.34"
   y2="95.110001"
   style="stroke:#999999;stroke-width:1.05"
   id="line132" />
<!-- Edge:    45   46 -->
<line
   x1="200.36"
   y1="86.75"
   x2="164.34"
   y2="95.110001"
   style="stroke:#999999;stroke-width:1.35"
   id="line133" />
<!-- Edge:    45   48 -->
<line
   x1="200.36"
   y1="86.75"
   x2="196.12"
   y2="125.59"
   style="stroke:#999999;stroke-width:1.2"
   id="line134" />
<!-- Edge:    45   49 -->
<line
   x1="200.36"
   y1="86.75"
   x2="169.17999"
   y2="116.41"
   style="stroke:#999999;stroke-width:1.05"
   id="line135" />
<!-- Edge:    45   68 -->
<line
   x1="200.36"
   y1="86.75"
   x2="211.56"
   y2="77.980003"
   style="stroke:#999999;stroke-width:1.2"
   id="line136" />
<!-- Edge:    51   52 -->
<line
   x1="182.31"
   y1="281.20999"
   x2="170.75999"
   y2="320.45999"
   style="stroke:#999999;stroke-width:1.05"
   id="line137" />
<!-- Edge:    51   53 -->
<line
   x1="182.31"
   y1="281.20999"
   x2="130.32001"
   y2="265.75"
   style="stroke:#999999;stroke-width:1.2"
   id="line138" />
<!-- Edge:    51   54 -->
<line
   x1="182.31"
   y1="281.20999"
   x2="174.57001"
   y2="258.67001"
   style="stroke:#999999;stroke-width:1.2"
   id="line139" />
<!-- Edge:    52   53 -->
<line
   x1="170.75999"
   y1="320.45999"
   x2="130.32001"
   y2="265.75"
   style="stroke:#999999;stroke-width:1.5"
   id="line140" />
<!-- Edge:    52   54 -->
<line
   x1="170.75999"
   y1="320.45999"
   x2="174.57001"
   y2="258.67001"
   style="stroke:#999999;stroke-width:1.65"
   id="line141" />
<!-- Edge:    53   54 -->
<line
   x1="130.32001"
   y1="265.75"
   x2="174.57001"
   y2="258.67001"
   style="stroke:#999999;stroke-width:2.1"
   id="line142" />
<!-- Edge:    55   74 -->
<line
   x1="443.16"
   y1="474.79999"
   x2="362.85999"
   y2="420.14001"
   style="stroke:#999999;stroke-width:1.35"
   id="line143" />
<!-- Edge:    55   75 -->
<line
   x1="443.16"
   y1="474.79999"
   x2="272.39999"
   y2="502.66"
   style="stroke:#999999;stroke-width:1.35"
   id="line144" />
<!-- Edge:    57   58 -->
<line
   x1="833.46997"
   y1="445.85999"
   x2="751.14001"
   y2="481.23001"
   style="stroke:#999999;stroke-width:1.35"
   id="line145" />
<!-- Edge:    58   88 -->
<line
   x1="751.14001"
   y1="481.23001"
   x2="669.65002"
   y2="514.32001"
   style="stroke:#999999;stroke-width:1.05"
   id="line146" />
<!-- Edge:    59   63 -->
<line
   x1="551.08002"
   y1="189.11"
   x2="604.77002"
   y2="228.28999"
   style="stroke:#999999;stroke-width:1.05"
   id="line147" />
<!-- Edge:    59   65 -->
<line
   x1="551.08002"
   y1="189.11"
   x2="495"
   y2="154.34"
   style="stroke:#999999;stroke-width:1.95"
   id="line148" />
<!-- Edge:    59   72 -->
<line
   x1="551.08002"
   y1="189.11"
   x2="613.91998"
   y2="163.98"
   style="stroke:#999999;stroke-width:1.35"
   id="line149" />
<!-- Edge:    59   73 -->
<line
   x1="551.08002"
   y1="189.11"
   x2="559.03003"
   y2="260.44"
   style="stroke:#999999;stroke-width:1.05"
   id="line150" />
<!-- Edge:    59   90 -->
<line
   x1="551.08002"
   y1="189.11"
   x2="494.85001"
   y2="222.25"
   style="stroke:#999999;stroke-width:1.65"
   id="line151" />
<!-- Edge:    64   95 -->
<line
   x1="49.040001"
   y1="553.25"
   x2="49.040001"
   y2="623.63"
   style="stroke:#999999;stroke-width:1.2"
   id="line152" />
<!-- Edge:    66  104 -->
<line
   x1="762.32001"
   y1="171.48"
   x2="821.27002"
   y2="207.92"
   style="stroke:#999999;stroke-width:1.65"
   id="line153" />
<!-- Edge:    66  106 -->
<line
   x1="762.32001"
   y1="171.48"
   x2="748.09003"
   y2="243.28999"
   style="stroke:#999999;stroke-width:1.65"
   id="line154" />
<!-- Edge:    69   89 -->
<line
   x1="350.62"
   y1="560.75"
   x2="350.62"
   y2="631.13"
   style="stroke:#999999;stroke-width:1.95"
   id="line155" />
<!-- Edge:    70   71 -->
<line
   x1="329.42999"
   y1="241.92"
   x2="323.35001"
   y2="256.09"
   style="stroke:#999999;stroke-width:2.4"
   id="line156" />
<!-- Edge:    74   75 -->
<line
   x1="362.85999"
   y1="420.14001"
   x2="272.39999"
   y2="502.66"
   style="stroke:#999999;stroke-width:1.35"
   id="line157" />
<!-- Edge:    77   78 -->
<line
   x1="223.97"
   y1="110.98"
   x2="248.17999"
   y2="123.09"
   style="stroke:#999999;stroke-width:1.65"
   id="line158" />
<!-- Edge:    77   79 -->
<line
   x1="223.97"
   y1="110.98"
   x2="232.14"
   y2="140.63"
   style="stroke:#999999;stroke-width:1.5"
   id="line159" />
<!-- Edge:    78   79 -->
<line
   x1="248.17999"
   y1="123.09"
   x2="232.14"
   y2="140.63"
   style="stroke:#999999;stroke-width:1.35"
   id="line160" />
<!-- Edge:    84  102 -->
<line
   x1="718.60999"
   y1="299.03"
   x2="765.37"
   y2="372.98001"
   style="stroke:#999999;stroke-width:1.2"
   id="line161" />
<!-- Edge:    84  103 -->
<line
   x1="718.60999"
   y1="299.03"
   x2="830.41998"
   y2="323.67999"
   style="stroke:#999999;stroke-width:1.05"
   id="line162" />
<!-- Edge:    90   93 -->
<line
   x1="494.85001"
   y1="222.25"
   x2="449.26001"
   y2="269.01999"
   style="stroke:#999999;stroke-width:1.2"
   id="line163" />
<!-- Edge:    92  102 -->
<line
   x1="708.45001"
   y1="424.42001"
   x2="765.37"
   y2="372.98001"
   style="stroke:#999999;stroke-width:1.05"
   id="line164" />
<!-- Edge:    94  100 -->
<line
   x1="798.15002"
   y1="565.07001"
   x2="798.15002"
   y2="635.46002"
   style="stroke:#999999;stroke-width:1.5"
   id="line165" />
<!-- Edge:    96   97 -->
<line
   x1="274.20999"
   y1="135.62"
   x2="272.09"
   y2="106.8"
   style="stroke:#999999;stroke-width:1.35"
   id="line166" />
<!-- Edge:   102  103 -->
<line
   x1="765.37"
   y1="372.98001"
   x2="830.41998"
   y2="323.67999"
   style="stroke:#999999;stroke-width:1.05"
   id="line167" />
<!-- Edge:   104  106 -->
<line
   x1="821.27002"
   y1="207.92"
   x2="748.09003"
   y2="243.28999"
   style="stroke:#999999;stroke-width:1.65"
   id="line168" />
<!-- Edge:   107  108 -->
<line
   x1="442.14999"
   y1="380.48001"
   x2="532.60999"
   y2="421.20999"
   style="stroke:#999999;stroke-width:1.05"
   id="line169" />
<!-- Edge:    42  108 -->
<line
   x1="591.56"
   y1="361.19"
   x2="532.60999"
   y2="421.20999"
   style="stroke:#999999;stroke-width:1.35"
   id="line170" />

<!-- Vertex:     1 -->
<circle
   cx="148.89999"
   cy="162.35001"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse170"
   r="4.5599999" />
<text
   x="155.83"
   y="166.35001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text170">Primož Koželj</text>
<!-- Vertex:     2 -->
<circle
   cx="106.53"
   cy="173.21001"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse171"
   r="4.5599999" />
<text
   x="113.46"
   y="177.21001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text171">S. Vrtnik</text>
<!-- Vertex:     3 -->
<circle
   cx="142.25"
   cy="176.13"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse172"
   r="4.5599999" />
<text
   x="149.17"
   y="180.13"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text172">Andreja Jelen</text>
<!-- Vertex:     4 -->
<circle
   cx="318.39999"
   cy="272.60999"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse173"
   r="4.5599999" />
<text
   x="325.32001"
   y="276.60999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text173">Saša Jazbec</text>
<!-- Vertex:     5 -->
<circle
   cx="229.32001"
   cy="209.07001"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse174"
   r="4.5599999" />
<text
   x="236.25"
   y="213.07001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text174">Zvonko Jagličić</text>
<!-- Vertex:     6 -->
<circle
   cx="132.86"
   cy="144.39"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse175"
   r="4.5599999" />
<text
   x="139.78999"
   y="148.39"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text175">M. Feuerbacher</text>
<!-- Vertex:     7 -->
<circle
   cx="92.709999"
   cy="57.060001"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse176"
   r="4.5599999" />
<text
   x="99.639999"
   y="61.060001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text176">J. Dolinšek</text>
<!-- Vertex:     8 -->
<circle
   cx="833.46997"
   cy="85.739998"
   style="fill:#7fff00;stroke:#660000;stroke-width:0.5"
   id="ellipse177"
   r="4.5599999" />
<text
   x="840.40002"
   y="89.739998"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text177">Nikolaos S. Papageorgiou</text>
<!-- Vertex:     9 -->
<circle
   cx="781.63"
   cy="34.299999"
   style="fill:#7fff00;stroke:#660000;stroke-width:0.5"
   id="ellipse178"
   r="4.5599999" />
<text
   x="788.56"
   y="38.299999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text178">Vicenţiu D. Rădulescu</text>
<!-- Vertex:    10 -->
<circle
   cx="756.21997"
   cy="110.39"
   style="fill:#7fff00;stroke:#660000;stroke-width:0.5"
   id="ellipse179"
   r="4.5599999" />
<text
   x="763.15002"
   y="114.39"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text179">Dušan Repovš</text>
<!-- Vertex:    11 -->
<circle
   cx="513.29999"
   cy="322.60001"
   style="fill:#ff0000;stroke:#660000;stroke-width:0.5"
   id="ellipse180"
   r="4.5599999" />
<text
   x="520.21997"
   y="326.60001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text180">Vladimir Batagelj</text>
<!-- Vertex:    12 -->
<circle
   cx="345.47"
   cy="81.540001"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse181"
   r="4.5599999" />
<text
   x="352.39999"
   y="85.540001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text181">Marko Jagodič</text>
<!-- Vertex:    13 -->
<circle
   cx="280.20999"
   cy="314.06"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse182"
   r="4.5599999" />
<text
   x="287.14001"
   y="318.06"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text182">D. Hanžel</text>
<!-- Vertex:    14 -->
<circle
   cx="263.31"
   cy="87.169998"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse183"
   r="4.5599999" />
<text
   x="270.23999"
   y="91.169998"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text183">Darko Makovec</text>
<!-- Vertex:    15 -->
<circle
   cx="545.79999"
   cy="123.18"
   style="fill:#0000ff;stroke:#660000;stroke-width:0.5"
   id="ellipse184"
   r="4.5599999" />
<text
   x="552.72998"
   y="127.18"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text184">Boštjan Brešar</text>
<!-- Vertex:    16 -->
<circle
   cx="21.360001"
   cy="348.20001"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse185"
   r="4.5599999" />
<text
   x="28.290001"
   y="352.20001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text185">Rok Hren</text>
<!-- Vertex:    17 -->
<circle
   cx="346.57999"
   cy="197.48"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse186"
   r="4.5599999" />
<text
   x="353.51001"
   y="201.48"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text186">Igor Djerdj</text>
<!-- Vertex:    18 -->
<circle
   cx="118.64"
   cy="233.35001"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse187"
   r="4.5599999" />
<text
   x="125.57"
   y="237.35001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text187">Denis Arčon</text>
<!-- Vertex:    19 -->
<circle
   cx="323.22"
   cy="216.5"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse188"
   r="4.5599999" />
<text
   x="330.14999"
   y="220.5"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text188">Markus Niederberger</text>
<!-- Vertex:    20 -->
<circle
   cx="53.439999"
   cy="317.28"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse189"
   r="4.5599999" />
<text
   x="60.369999"
   y="321.28"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text189">Vojko Jazbinšek</text>
<!-- Vertex:    21 -->
<circle
   cx="108.75"
   cy="252.23"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse190"
   r="4.5599999" />
<text
   x="115.68"
   y="256.23001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text190">Z. Trontelj</text>
<!-- Vertex:    22 -->
<circle
   cx="343.26001"
   cy="160.12"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse191"
   r="4.5599999" />
<text
   x="350.19"
   y="164.12"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text191">Di Sun</text>
<!-- Vertex:    23 -->
<circle
   cx="58.419998"
   cy="280.57001"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse192"
   r="4.5599999" />
<text
   x="65.349998"
   y="284.57001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text192">J. Lužnik</text>
<!-- Vertex:    24 -->
<circle
   cx="142.55"
   cy="123.51"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse193"
   r="4.5599999" />
<text
   x="149.48"
   y="127.51"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text193">Anton Meden</text>
<!-- Vertex:    25 -->
<circle
   cx="361.85001"
   cy="118.97"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse194"
   r="4.5599999" />
<text
   x="368.78"
   y="122.97"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text194">Hai‐Feng Su</text>
<!-- Vertex:    26 -->
<circle
   cx="352.70001"
   cy="181.13"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse195"
   r="4.5599999" />
<text
   x="359.63"
   y="185.13"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text195">Suyuan Zeng</text>
<!-- Vertex:    27 -->
<circle
   cx="329.98999"
   cy="140.78999"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse196"
   r="4.5599999" />
<text
   x="336.91"
   y="144.78999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text196">Chen‐Ho Tung</text>
<!-- Vertex:    28 -->
<circle
   cx="702.34998"
   cy="60.02"
   style="fill:#7fff00;stroke:#660000;stroke-width:0.5"
   id="ellipse197"
   r="4.5599999" />
<text
   x="709.28003"
   y="64.019997"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text197">Nikolaos S. Papageorgiou</text>
<!-- Vertex:    29 -->
<circle
   cx="25.24"
   cy="228.39"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse198"
   r="4.5599999" />
<text
   x="32.16"
   y="232.39"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text198">Janez Pirnat</text>
<!-- Vertex:    30 -->
<circle
   cx="111.68"
   cy="201.61"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse199"
   r="4.5599999" />
<text
   x="118.6"
   y="205.61"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text199">M. Pregelj</text>
<!-- Vertex:    31 -->
<circle
   cx="346.60001"
   cy="22.51"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse200"
   r="4.5599999" />
<text
   x="353.53"
   y="26.51"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text200">Sašo Gyergyek</text>
<!-- Vertex:    32 -->
<circle
   cx="311.44"
   cy="97.190002"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse201"
   r="4.5599999" />
<text
   x="318.35999"
   y="101.19"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text201">Miha Drofenik</text>
<!-- Vertex:    33 -->
<circle
   cx="198.31"
   cy="553.25"
   style="fill:#ffd8f2;stroke:#660000;stroke-width:0.5"
   id="ellipse202"
   r="4.5599999" />
<text
   x="205.23"
   y="557.25"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text202">Aleksander Malnič</text>
<!-- Vertex:    34 -->
<circle
   cx="198.31"
   cy="623.63"
   style="fill:#ffd8f2;stroke:#660000;stroke-width:0.5"
   id="ellipse203"
   r="4.5599999" />
<text
   x="205.23"
   y="627.63"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text203">Dragan Marušič</text>
<!-- Vertex:    35 -->
<circle
   cx="503.95001"
   cy="560.75"
   style="fill:#ffffff;stroke:#660000;stroke-width:0.5"
   id="ellipse204"
   r="4.5599999" />
<text
   x="510.88"
   y="564.75"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text204">Primož Potočnik</text>
<!-- Vertex:    36 -->
<circle
   cx="110.41"
   cy="301.82001"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse205"
   r="4.5599999" />
<text
   x="117.34"
   y="305.82001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text205">R. Blinc</text>
<!-- Vertex:    37 -->
<circle
   cx="138.61"
   cy="216.64"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse206"
   r="4.5599999" />
<text
   x="145.53999"
   y="220.64"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text206">A. Zorko</text>
<!-- Vertex:    38 -->
<circle
   cx="73.910004"
   cy="215.50999"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse207"
   r="4.5599999" />
<text
   x="80.830002"
   y="219.50999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text207">Janez Holc</text>
<!-- Vertex:    39 -->
<circle
   cx="652.65002"
   cy="564"
   style="fill:#ff6321;stroke:#660000;stroke-width:0.5"
   id="ellipse208"
   r="4.5599999" />
<text
   x="659.58002"
   y="568"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text208">J. William Helton</text>
<!-- Vertex:    40 -->
<circle
   cx="652.65002"
   cy="634.38"
   style="fill:#ff6321;stroke:#660000;stroke-width:0.5"
   id="ellipse209"
   r="4.5599999" />
<text
   x="659.58002"
   y="638.38"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text209">Igor Klep</text>
<!-- Vertex:    41 -->
<circle
   cx="368.95999"
   cy="235.78999"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse210"
   r="4.5599999" />
<text
   x="375.89001"
   y="239.78999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text210">Patricia Cotič</text>
<!-- Vertex:    42 -->
<circle
   cx="591.56"
   cy="361.19"
   style="fill:#ff0000;stroke:#660000;stroke-width:0.5"
   id="ellipse211"
   r="4.5599999" />
<text
   x="598.48999"
   y="365.19"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text211">Anuška Ferligoj</text>
<!-- Vertex:    43 -->
<circle
   cx="187.02"
   cy="407.26999"
   style="fill:#8c23ff;stroke:#660000;stroke-width:0.5"
   id="ellipse212"
   r="4.5599999" />
<text
   x="193.95"
   y="411.26999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text212">Franc Forstnerič</text>
<!-- Vertex:    44 -->
<circle
   cx="197.63"
   cy="101.37"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse213"
   r="4.5599999" />
<text
   x="204.56"
   y="105.37"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text213">Petar Popčević</text>
<!-- Vertex:    45 -->
<circle
   cx="200.36"
   cy="86.75"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse214"
   r="4.5599999" />
<text
   x="207.28999"
   y="90.75"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text214">Ana Smontara</text>
<!-- Vertex:    46 -->
<circle
   cx="164.34"
   cy="95.110001"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse215"
   r="4.5599999" />
<text
   x="171.27"
   y="99.110001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text215">Jovica Ivkov</text>
<!-- Vertex:    47 -->
<circle
   cx="95.029999"
   cy="183.23"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse216"
   r="4.5599999" />
<text
   x="101.96"
   y="187.23"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text216">Magdalena Wencka</text>
<!-- Vertex:    48 -->
<circle
   cx="196.12"
   cy="125.59"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse217"
   r="4.5599999" />
<text
   x="203.05"
   y="129.59"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text217">P. Jeglič</text>
<!-- Vertex:    49 -->
<circle
   cx="169.17999"
   cy="116.41"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse218"
   r="4.5599999" />
<text
   x="176.11"
   y="120.41"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text218">P. Gille</text>
<!-- Vertex:    50 -->
<circle
   cx="148.60001"
   cy="107.22"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse219"
   r="4.5599999" />
<text
   x="155.53"
   y="111.22"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text219">M. Klanjšek</text>
<!-- Vertex:    51 -->
<circle
   cx="182.31"
   cy="281.20999"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse220"
   r="4.5599999" />
<text
   x="189.24001"
   y="285.20999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text220">Przemysław J. Malinowski</text>
<!-- Vertex:    52 -->
<circle
   cx="170.75999"
   cy="320.45999"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse221"
   r="4.5599999" />
<text
   x="177.69"
   y="324.45999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text221">Mariana Derzsi</text>
<!-- Vertex:    53 -->
<circle
   cx="130.32001"
   cy="265.75"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse222"
   r="4.5599999" />
<text
   x="137.25"
   y="269.75"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text222">Zoran Mazej</text>
<!-- Vertex:    54 -->
<circle
   cx="174.57001"
   cy="258.67001"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse223"
   r="4.5599999" />
<text
   x="181.5"
   y="262.67001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text223">Wojciech Grochala</text>
<!-- Vertex:    55 -->
<circle
   cx="443.16"
   cy="474.79999"
   style="fill:#606dc4;stroke:#660000;stroke-width:0.5"
   id="ellipse224"
   r="4.5599999" />
<text
   x="450.09"
   y="478.79999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text224">Marjeta Kramar Fijavž</text>
<!-- Vertex:    56 -->
<circle
   cx="253.11"
   cy="330.16"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse225"
   r="4.5599999" />
<text
   x="260.03"
   y="334.16"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text225">Bojan Kozlevčar</text>
<!-- Vertex:    57 -->
<circle
   cx="833.46997"
   cy="445.85999"
   style="fill:#1ef9a3;stroke:#660000;stroke-width:0.5"
   id="ellipse226"
   r="4.5599999" />
<text
   x="840.40002"
   y="449.85999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text226">Borut Lužar</text>
<!-- Vertex:    58 -->
<circle
   cx="751.14001"
   cy="481.23001"
   style="fill:#1ef9a3;stroke:#660000;stroke-width:0.5"
   id="ellipse227"
   r="4.5599999" />
<text
   x="758.07001"
   y="485.23001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text227">Riste Škrekovski</text>
<!-- Vertex:    59 -->
<circle
   cx="551.08002"
   cy="189.11"
   style="fill:#0000ff;stroke:#660000;stroke-width:0.5"
   id="ellipse228"
   r="4.5599999" />
<text
   x="558.01001"
   y="193.11"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text228">Sandi Klavžar</text>
<!-- Vertex:    60 -->
<circle
   cx="292.73001"
   cy="378.34"
   style="fill:#8c23ff;stroke:#660000;stroke-width:0.5"
   id="ellipse229"
   r="4.5599999" />
<text
   x="299.66"
   y="382.34"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text229">Erlend Fornæss Wold</text>
<!-- Vertex:    61 -->
<circle
   cx="490.26999"
   cy="90.879997"
   style="fill:#0000ff;stroke:#660000;stroke-width:0.5"
   id="ellipse230"
   r="4.5599999" />
<text
   x="497.20001"
   y="94.879997"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text230">Tanja Gologranc</text>
<!-- Vertex:    62 -->
<circle
   cx="538.71002"
   cy="46.09"
   style="fill:#0000ff;stroke:#660000;stroke-width:0.5"
   id="ellipse231"
   r="4.5599999" />
<text
   x="545.63"
   y="50.09"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text231">Martin Milanič</text>
<!-- Vertex:    63 -->
<circle
   cx="604.77002"
   cy="228.28999"
   style="fill:#0000ff;stroke:#660000;stroke-width:0.5"
   id="ellipse232"
   r="4.5599999" />
<text
   x="611.70001"
   y="232.28999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text232">Douglas F. Rall</text>
<!-- Vertex:    64 -->
<circle
   cx="49.040001"
   cy="553.25"
   style="fill:#009900;stroke:#660000;stroke-width:0.5"
   id="ellipse233"
   r="4.5599999" />
<text
   x="55.970001"
   y="557.25"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text233">Janez Žerovnik</text>
<!-- Vertex:    65 -->
<circle
   cx="495"
   cy="154.34"
   style="fill:#0000ff;stroke:#660000;stroke-width:0.5"
   id="ellipse234"
   r="4.5599999" />
<text
   x="501.92999"
   y="158.34"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text234">Gašper Košmrlj</text>
<!-- Vertex:    66 -->
<circle
   cx="762.32001"
   cy="171.48"
   style="fill:#7fff00;stroke:#660000;stroke-width:0.5"
   id="ellipse235"
   r="4.5599999" />
<text
   x="769.25"
   y="175.48"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text235">Matija Cencelj</text>
<!-- Vertex:    67 -->
<circle
   cx="291.82001"
   cy="305.04001"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse236"
   r="4.5599999" />
<text
   x="298.75"
   y="309.04001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text236">Damir Pajić</text>
<!-- Vertex:    68 -->
<circle
   cx="211.56"
   cy="77.980003"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse237"
   r="4.5599999" />
<text
   x="218.48"
   y="81.980003"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text237">Ante Bilušić</text>
<!-- Vertex:    69 -->
<circle
   cx="350.62"
   cy="560.75"
   style="fill:#7f7f7f;stroke:#660000;stroke-width:0.5"
   id="ellipse238"
   r="4.5599999" />
<text
   x="357.54999"
   y="564.75"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text238">Špela Špenko</text>
<!-- Vertex:    70 -->
<circle
   cx="329.42999"
   cy="241.92"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse239"
   r="4.5599999" />
<text
   x="336.35999"
   y="245.92"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text239">Elham Safaei</text>
<!-- Vertex:    71 -->
<circle
   cx="323.35001"
   cy="256.09"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse240"
   r="4.5599999" />
<text
   x="330.28"
   y="260.09"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text240">Andrzej Wojtczak</text>
<!-- Vertex:    72 -->
<circle
   cx="613.91998"
   cy="163.98"
   style="fill:#0000ff;stroke:#660000;stroke-width:0.5"
   id="ellipse241"
   r="4.5599999" />
<text
   x="620.84998"
   y="167.98"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text241">Csilla Bujtás</text>
<!-- Vertex:    73 -->
<circle
   cx="559.03003"
   cy="260.44"
   style="fill:#0000ff;stroke:#660000;stroke-width:0.5"
   id="ellipse242"
   r="4.5599999" />
<text
   x="565.96002"
   y="264.44"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text242">Michael A. Henning</text>
<!-- Vertex:    74 -->
<circle
   cx="362.85999"
   cy="420.14001"
   style="fill:#606dc4;stroke:#660000;stroke-width:0.5"
   id="ellipse243"
   r="4.5599999" />
<text
   x="369.79001"
   y="424.14001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text243">András Bátkai</text>
<!-- Vertex:    75 -->
<circle
   cx="272.39999"
   cy="502.66"
   style="fill:#606dc4;stroke:#660000;stroke-width:0.5"
   id="ellipse244"
   r="4.5599999" />
<text
   x="279.32999"
   y="506.66"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text244">Abdelaziz Rhandi</text>
<!-- Vertex:    76 -->
<circle
   cx="86.400002"
   cy="429.78"
   style="fill:#8c23ff;stroke:#660000;stroke-width:0.5"
   id="ellipse245"
   r="4.5599999" />
<text
   x="93.32"
   y="433.78"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text245">Antonio Alarcón</text>
<!-- Vertex:    77 -->
<circle
   cx="223.97"
   cy="110.98"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse246"
   r="4.5599999" />
<text
   x="230.89"
   y="114.98"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text246">B. Babić-Stojić</text>
<!-- Vertex:    78 -->
<circle
   cx="248.17999"
   cy="123.09"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse247"
   r="4.5599999" />
<text
   x="255.11"
   y="127.09"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text247">Vukoman Jokanović</text>
<!-- Vertex:    79 -->
<circle
   cx="232.14"
   cy="140.63"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse248"
   r="4.5599999" />
<text
   x="239.07001"
   y="144.63"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text248">D. Milivojević</text>
<!-- Vertex:    80 -->
<circle
   cx="142.85001"
   cy="134.78"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse249"
   r="4.5599999" />
<text
   x="149.78"
   y="138.78"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text249">Marc Heggen</text>
<!-- Vertex:    81 -->
<circle
   cx="503.95001"
   cy="631.13"
   style="fill:#ffffff;stroke:#660000;stroke-width:0.5"
   id="ellipse250"
   r="4.5599999" />
<text
   x="510.88"
   y="635.13"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text250">Štefko Miklavič</text>
<!-- Vertex:    82 -->
<circle
   cx="282.57001"
   cy="166.13"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse251"
   r="4.5599999" />
<text
   x="289.48999"
   y="170.13"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text251">Zdravko Kutnjak</text>
<!-- Vertex:    83 -->
<circle
   cx="236.50999"
   cy="337.25"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse252"
   r="4.5599999" />
<text
   x="243.44"
   y="341.25"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text252">Andrej Pevec</text>
<!-- Vertex:    84 -->
<circle
   cx="718.60999"
   cy="299.03"
   style="fill:#000000;stroke:#660000;stroke-width:0.5"
   id="ellipse253"
   r="4.5599999" />
<text
   x="725.53998"
   y="303.03"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text253">Matjaž Omladič</text>
<!-- Vertex:    85 -->
<circle
   cx="63.400002"
   cy="256.09"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse254"
   r="4.5599999" />
<text
   x="70.330002"
   y="260.09"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text254">J. Seliger</text>
<!-- Vertex:    86 -->
<circle
   cx="300.67001"
   cy="295.38"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse255"
   r="4.5599999" />
<text
   x="307.60001"
   y="299.38"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text255">H. Berger</text>
<!-- Vertex:    87 -->
<circle
   cx="268.59"
   cy="322.42999"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse256"
   r="4.5599999" />
<text
   x="275.51999"
   y="326.42999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text256">Nives Kitanovski</text>
<!-- Vertex:    88 -->
<circle
   cx="669.65002"
   cy="514.32001"
   style="fill:#1ef9a3;stroke:#660000;stroke-width:0.5"
   id="ellipse257"
   r="4.5599999" />
<text
   x="676.58002"
   y="518.32001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text257">Martin Knor</text>
<!-- Vertex:    89 -->
<circle
   cx="350.62"
   cy="631.13"
   style="fill:#7f7f7f;stroke:#660000;stroke-width:0.5"
   id="ellipse258"
   r="4.5599999" />
<text
   x="357.54999"
   y="635.13"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text258">Matej Brešar</text>
<!-- Vertex:    90 -->
<circle
   cx="494.85001"
   cy="222.25"
   style="fill:#0000ff;stroke:#660000;stroke-width:0.5"
   id="ellipse259"
   r="4.5599999" />
<text
   x="501.78"
   y="226.25"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text259">Vesna Iršič</text>
<!-- Vertex:    91 -->
<circle
   cx="704.38"
   cy="135.03999"
   style="fill:#7fff00;stroke:#660000;stroke-width:0.5"
   id="ellipse260"
   r="4.5599999" />
<text
   x="711.31"
   y="139.03999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text260">Fulvia Spaggiari</text>
<!-- Vertex:    92 -->
<circle
   cx="708.45001"
   cy="424.42001"
   style="fill:#000000;stroke:#660000;stroke-width:0.5"
   id="ellipse261"
   r="4.5599999" />
<text
   x="715.38"
   y="428.42001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text261">Blaž Mojškerc</text>
<!-- Vertex:    93 -->
<circle
   cx="449.26001"
   cy="269.01999"
   style="fill:#0000ff;stroke:#660000;stroke-width:0.5"
   id="ellipse262"
   r="4.5599999" />
<text
   x="456.19"
   y="273.01999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text262">Valentin Gledel</text>
<!-- Vertex:    94 -->
<circle
   cx="798.15002"
   cy="565.07001"
   style="fill:#ad0000;stroke:#660000;stroke-width:0.5"
   id="ellipse263"
   r="4.5599999" />
<text
   x="805.08002"
   y="569.07001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text263">Bojan Kuzma</text>
<!-- Vertex:    95 -->
<circle
   cx="49.040001"
   cy="623.63"
   style="fill:#009900;stroke:#660000;stroke-width:0.5"
   id="ellipse264"
   r="4.5599999" />
<text
   x="55.970001"
   y="627.63"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text264">Iztok Banič</text>
<!-- Vertex:    96 -->
<circle
   cx="274.20999"
   cy="135.62"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse265"
   r="4.5599999" />
<text
   x="281.14001"
   y="139.62"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text265">Matjaž Kristl</text>
<!-- Vertex:    97 -->
<circle
   cx="272.09"
   cy="106.8"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse266"
   r="4.5599999" />
<text
   x="279.01999"
   y="110.8"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text266">Brina Dojer</text>
<!-- Vertex:    98 -->
<circle
   cx="303.91"
   cy="35.369999"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse267"
   r="4.5599999" />
<text
   x="310.84"
   y="39.369999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text267">Brigita Rožič</text>
<!-- Vertex:    99 -->
<circle
   cx="592.58002"
   cy="78.239998"
   style="fill:#0000ff;stroke:#660000;stroke-width:0.5"
   id="ellipse268"
   r="4.5599999" />
<text
   x="599.51001"
   y="82.239998"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text268">Tim Kos</text>
<!-- Vertex:   100 -->
<circle
   cx="798.15002"
   cy="635.46002"
   style="fill:#ad0000;stroke:#660000;stroke-width:0.5"
   id="ellipse269"
   r="4.5599999" />
<text
   x="805.08002"
   y="639.46002"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text269">Грегор Долинар</text>
<!-- Vertex:   101 -->
<circle
   cx="311.73001"
   cy="282.5"
   style="fill:#ffff00;stroke:#660000;stroke-width:0.5"
   id="ellipse270"
   r="4.5599999" />
<text
   x="318.66"
   y="286.5"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text270">Amalija Golobič</text>
<!-- Vertex:   102 -->
<circle
   cx="765.37"
   cy="372.98001"
   style="fill:#000000;stroke:#660000;stroke-width:0.5"
   id="ellipse271"
   r="4.5599999" />
<text
   x="772.29999"
   y="376.98001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text271">Damjana Kokol Bukovšek</text>
<!-- Vertex:   103 -->
<circle
   cx="830.41998"
   cy="323.67999"
   style="fill:#000000;stroke:#660000;stroke-width:0.5"
   id="ellipse272"
   r="4.5599999" />
<text
   x="837.34998"
   y="327.67999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text272">Tomaž Košir</text>
<!-- Vertex:   104 -->
<circle
   cx="821.27002"
   cy="207.92"
   style="fill:#7fff00;stroke:#660000;stroke-width:0.5"
   id="ellipse273"
   r="4.5599999" />
<text
   x="828.20001"
   y="211.92"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text273">Aleš Vavpetič</text>
<!-- Vertex:   105 -->
<circle
   cx="835.5"
   cy="150.05"
   style="fill:#7fff00;stroke:#660000;stroke-width:0.5"
   id="ellipse274"
   r="4.5599999" />
<text
   x="842.42999"
   y="154.05"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text274">Umed H. Karimov</text>
<!-- Vertex:   106 -->
<circle
   cx="748.09003"
   cy="243.28999"
   style="fill:#7fff00;stroke:#660000;stroke-width:0.5"
   id="ellipse275"
   r="4.5599999" />
<text
   x="755.02002"
   y="247.28999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text275">Jerzy Dydak</text>
<!-- Vertex:   107 -->
<circle
   cx="442.14999"
   cy="380.48001"
   style="fill:#ff0000;stroke:#660000;stroke-width:0.5"
   id="ellipse276"
   r="4.5599999" />
<text
   x="449.07001"
   y="384.48001"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text276">Nataša Kejžar</text>
<!-- Vertex:   108 -->
<circle
   cx="532.60999"
   cy="421.20999"
   style="fill:#ff0000;stroke:#660000;stroke-width:0.5"
   id="ellipse277"
   r="4.5599999" />
<text
   x="539.53998"
   y="425.20999"
   style="font-weight:bold;font-size:10px;font-family:Arial;fill:#ad0000"
   id="text277">Patrick Doreian</text>
</g></g></svg>
