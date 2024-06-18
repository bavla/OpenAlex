NETBEGIN 1
CLUBEGIN 1
PERBEGIN 1
CLSBEGIN 1
HIEBEGIN 1
VECBEGIN 1

% Reading Network   ---    HBciteCi.net
N 1 RDN "?" (315626)
% Reading Partition   ---    HBciteCbc.clu
C 1 RDC "?" (315626)
% Binarizing Partition
C 2 BIN 1 [100-*] (315626)
C 2 CLUNAME gideg >= tg
% Output degree centrality of 1. HBciteCi.net (315626)
C 3 DEGC 1 [1] (315626)
% Binarizing Partition
C 4 BIN 3 [0] (315626)
C 4 CLUNAME lodeg = 0
% Input degree centrality of 1. HBciteCi.net (315626)
C 5 DEGC 1 [0] (315626)
% Binarizing Partition
C 6 BIN 5 [10-*] (315626)
C 6 CLUNAME lideg >= tl
% Maximum of Partitions
C 7 MAXP 6 2 (315626)
% Minimum of Partitions
C 8 MINP 7 4 (315626)
C 8 CLUNAME new candidates
% Extracting Subnetwork according to Partition
N 2 EXT 1 8 [1] 1 (3784)
% Saving network to file   ---    HB.net
N 2 WN "HB.net" 0 (3784)
