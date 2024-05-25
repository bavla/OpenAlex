NETBEGIN 2
CLUBEGIN 1
PERBEGIN 1
CLSBEGIN 1
HIEBEGIN 1
VECBEGIN 1
NETPARAM 1

% Removing loops
N 2 DLOOPS 1 (59)
% Removing selected Vertices from Network
N 3 REMVERT 2 [59] 1 (58)
% Sorting and removing arcs with lowest values
N 4 REMLINVALVERT 3 1 2 0 (58)
% Ln of Line Values
N 5 LNLINVAL 4 1 (58)
% Adding Constant to Line Values
N 6 ADDLINVAL 5 1.0000 1 (58)
% Weak Components
C 2 COMP 6 [2] [1] (58)
E 6 CIRCULAR
E 6 DRAW 2 0 0 0 0
