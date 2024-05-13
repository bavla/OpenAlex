NETBEGIN 2
CLUBEGIN 1
PERBEGIN 1
CLSBEGIN 1
HIEBEGIN 1
VECBEGIN 1
NETPARAM 1

% Removing loops
N 2 DLOOPS 1 (251)
% Ln of Line Values
N 3 LNLINVAL 2 1 (251)
% Sorting and removing arcs with lowest values
N 4 REMLINVALVERT 3 1 2 0 (251)
% Converting bidirectional Arcs to Edges
N 4 BATOEMIN 4 (251)
N 4 NETNAME 1-neighbors
% Reading Partition   ---    C:\Users\vlado\work\OpenAlex\API\years\continents.clu
C 1 RDC "?" (251)
% Loading INI File
LOADINI "C:\Users\vlado\work\OpenAlex\API\1-WorldCo.ini"
% Reading Vector   ---    C:\Users\vlado\work\OpenAlex\API\years\x.vec
V 1 RDV "?" (251)
% Reading Vector   ---    C:\Users\vlado\work\OpenAlex\API\years\y.vec
V 2 RDV "?" (251)
% Putting Coordinate(s)
N 5 PUTCOORD 1 4 [1,1] (251)
% Putting Coordinate(s)
N 6 PUTCOORD 2 5 [2,1] (251)
E 6 DRAW 1 0 0 0 0
