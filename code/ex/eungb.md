# Analyses
## 1-neighbors

  * Read network in Pajek
  * Info
  * Remove loops
  * Weights 1 + ln
  * Remove node 59
  * Remove arcs except max
  * Arcs -> Edges (bidirected, min)
  * Draw

Macro [Eu1neighbors](https://raw.githubusercontent.com/bavla/OpenAlex/main/code/Eu1neighbors.mcr)

## Clustering

  * Select the 1+ln network produced by Eu1neighbors
  * Create Complete Cluster on 59 nodes
  * Operations/network+cluster/Dissimilarity based on network [Corr Euclidean][1]
  * Hierarchical Clustering (automatic) save dendro.eps
  * file/network/export matrix using permutation matrix.eps

Macro [EuCluster](https://raw.githubusercontent.com/bavla/OpenAlex/main/code/EuCluster.mcr)

## 1990

<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/EU1990_1n.svg?sanitize=true" width="600">

<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/EUmat1990.svg?sanitize=true" width="700">

## 1995
<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/EU1995_1n.svg?sanitize=true" width="600">

<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/EUmat1995.svg?sanitize=true" width="700">

## 2020
<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/EU2020_1n.svg?sanitize=true" width="600">

<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/EUdend2020.svg?sanitize=true" width="500">

<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/EUmat2020.svg?sanitize=true" width="700">

## 2023

<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/EU2023_1n.svg?sanitize=true" width="600">

<img src="https://raw.githubusercontent.com/bavla/OpenAlex/main/Countries/pics/EUmat2023.svg?sanitize=true" width="700">

