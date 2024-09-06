# World co-authorship / August 27, 2024

The creation of the files is desribed in [countries.pdf](countries.pdf).

The ZIP file [WrldCo_years.zip](WrldCo_years.zip) contains
  - a network WrldCoYEAR.net - co-authorship network for the year YEAR,
  - a vector WrldCoYEART.vec - number of co-authored works for country cy in the year YEAR,
  - and a partition WrldCoYEARG.clu - number of countries that co-authored works with the country cy in the year YEAR
for each YEAR in 1990:2023.

The ZIP file [WrldCoRdata.zip](WrldCoRdata.zip) contains the co-authorship data as 3D array describing temporal co-authorship network in RDATA format.

The file [ISO2codes.csv](ISO2codes.csv) contains ISO 2 alpha codes of world countries.

The file [continents.clu](continents.clu) contains a partition of countries to continents.

## Europe

  - [EuropeList.Rdata](EuropeList.Rdata) - co-authorship between European countries for each year 1990:2023
  - [EuropeXList.zip](EuropeXList.zip) - co-authorship between European countries for each years 1994:2003, 2004:2013, 2014:2023
  - [EuropeXbList.Rdata](EuropeXbList.Rdata) - co-authorship between European countries for each years 1994:2003, 2004:2013, 2014:2023 Balassa normalization; nolinks have value NA - for computations replace it with 0; h - density hierarchy, t - Balassa hierarchy, M - normalized network
  - [Europe](Eu.md) notes

## Docs

  - https://github.com/bavla/wNets/blob/main/Docs/compstat23.pdf
  - https://github.com/bavla/biblio/tree/master/Eu
  - https://github.com/bavla/OpenAlex/blob/main/code/ex/eu.md
  - [Collnet](https://github.com/bavla/OpenAlex/blob/main/docs/WorldCoAu.pdf); C:\Users\vlado\docs\papers\2024\Collnet\paper\Collnet_VB.docx
  - [Sreda1351+2](https://github.com/bavla/OpenAlex/blob/main/docs/sreda1351%2B2.pdf); C:\Users\vlado\docs\papers\2024\OpenAlex\slides\sreda1351+2.pdf
  - [World clustering, Balassa](https://github.com/bavla/OpenAlex/blob/main/Countries/World%20clustering.pdf);  http://localhost:8800/doku.php?id=work:bib:alex:mat
  - Europe http://localhost:8800/doku.php?id=work:bib:alex:eu

