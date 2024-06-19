NETBEGIN 1
CLUBEGIN 1
PERBEGIN 1
CLSBEGIN 1
HIEBEGIN 1
VECBEGIN 1

Msg --- OpenAlex 2 Pajek / select new works ------------------------------------
Msg Reading Network  Ci.net
% Reading Network   ---    HBCi.net
N 1 RDN "?" 
Msg Reading Partition  Cbc.clu
% Reading Partition   ---    HBCbc.clu
C 1 RDC "?" 
Msg Binarize tg-* / tg is the global threshold (100-*)
% Binarizing Partition
C 2 BIN 1 [?] 
C 2 CLUNAME gideg >= tg
% Output degree centrality of 1. HBCi.net 
C 3 DEGC 1 [1] 
% Binarizing Partition
C 4 BIN 3 [0] 
C 4 CLUNAME lodeg = 0
% Input degree centrality of 1. HBCi.net 
C 5 DEGC 1 [0] (315626)
Msg Binarize tl-* / tl is the local threshold (10-*)
% Binarizing Partition
C 6 BIN 5 [?] 
C 6 CLUNAME lideg >= tl
% Maximum of Partitions
C 7 MAXP 6 2 
% Minimum of Partitions
C 8 MINP 7 4 
C 8 CLUNAME new candidates
% Extracting Subnetwork according to Partition
N 2 EXT 1 8 [1] 1 
Msg Saving Network  NewCand.net
% Saving network to file   ---    NewCand.net
N 2 WN "NewCand.net" 0 
Msg ---------------------------------------------------------------------
