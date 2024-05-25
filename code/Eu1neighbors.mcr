NETBEGIN 2
CLUBEGIN 1
PERBEGIN 1
CLSBEGIN 1
HIEBEGIN 1
VECBEGIN 1
NETPARAM 1

% Removing loops
N 2 DLOOPS 1 (59)
% Ln of Line Values
N 3 LNLINVAL 2 1 (59)
% Adding Constant to Line Values
N 4 ADDLINVAL 3 1.0000 1 (59)
% Removing selected Vertices from Network
N 5 REMVERT 4 [59] 1 (58)
% Sorting and removing arcs with lowest values
N 6 REMLINVALVERT 5 1 2 0 (58)
% Weak Components
C 2 COMP 6 [2] [1] (58)
% Converting bidirectional Arcs to Edges
N 6 BATOEMIN 6 (58)
N 6 NETNAME EU 1-neighbors
% Disposing Network...
N 2 DN  (59)
% Disposing Network...
N 3 DN  (59)
E 6 CIRCULAR
E 6 DRAW 2 0 0 0 0
