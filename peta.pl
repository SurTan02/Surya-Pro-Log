% HOW TO TEST THIS PROGRAM
% 1. run [map].
% 2. run initMap.
% 3. run map.
% TODO: AIR DAN DIGGED TILE
:- dynamic(tembok/2).
:- dynamic(tile/2).
:- dynamic(dimensi/2).
:- dynamic(houseCoord/2).
:- dynamic(playerCoord/2).
:- dynamic(ranchCoord/2).
:- dynamic(marketCoord/2).
:- dynamic(questCoord/2).
:- dynamic(waterCoord/2).
:- dynamic(diggedTile/2).


% working_directory(CWD,'C:/Users/irfan/OneDrive/Documents/Nando/Informatika/tubesLogkom/IF2121_K02_G01/src').
% working_directory(CWD,'C:/Users/irfan/OneDrive/Documents/Nando/Informatika/tubesLogkom/Surya-Pro-Log').


% pemosisian tembok
tembokAtas(_,Y) :-
    Y =:= 0.

tembokAtas(_,0).
tembokBawah(_,Y) :- 
    dimensi(_,L),
    Y =:= L+1.

tembokKanan(X,_) :-
    dimensi(P,_),
    X =:= P+1.

tembokKiri(X,_) :-
    X =:= 0.

playerPosition(X,Y) :-
    playerCoord(A,B),
    X =:= A,
    Y =:= B.

housePos(X,Y) :-
    houseCoord(A,B),
    X =:= A,
    Y =:= B.

ranchPos(X,Y) :-
    ranchCoord(A,B),
    X =:= A,
    Y =:= B.

marketPos(X,Y) :-
    marketCoord(A,B),
    X =:= A,
    Y =:= B.

 questPos(X,Y) :-
    questCoord(A,B),
    X =:= A,
    Y =:= B.

diggedPos(X,Y) :-
	diggedTile(A, B),
	X =:= A,
	Y =:= B,

% waterTile(0,_).
waterTile(X,_) :-
    X =:= 1.
waterTile(X,_) :-
    X =:= 2.
waterTile(X,_) :-
    X =:= 3.
waterTile(X,_) :-
    X =:= 4.
waterTile(X,_) :-
    X =:= 5.
% waterTile(1,_).
% waterTile(2,_).
% waterTile(3,_).
% waterTile(4,_).
%  diggedTile(X,Y) :-
%     diggedCoord(A,B),
%     X =:= A,
%     Y =:= B.



%basis rekursi	
writeElem(X,Y) :-				
	tembokKanan(X,Y),
	tembokBawah(X,Y),
	write('#').

%Rekurens penampilan peta

writeElem(X,Y) :-
    \+tembokAtas(X,Y),
    \+tembokBawah(X,Y),
	waterTile(X,Y),
	write('o'),
	writeElem(X+1,Y).

writeElem(X,Y) :-
	playerPosition(X,Y),
	write('P'),
	writeElem(X+1,Y).

writeElem(X,Y) :-
	housePos(X,Y),
	write('H'),
	writeElem(X+1,Y).

writeElem(X,Y) :-
	ranchPos(X,Y),
	write('R'),
	writeElem(X+1,Y).

writeElem(X,Y) :-
	marketPos(X,Y),
	write('M'),
	writeElem(X+1,Y).

writeElem(X,Y) :-
	questPos(X,Y),
	write('Q'),
	writeElem(X+1,Y).

% writeElem(X,Y) :-
% 	waterTile(X,Y),
% 	write('o'),
% 	writeElem(X+1,Y).

writeElem(X,Y) :-
	diggedPos(X,Y),
	write('='),
	writeElem(X+1,Y).

writeElem(X,Y) :-
	tembokBawah(X,Y),
	write('#'),
	writeElem(X+1,Y).

writeElem(X,Y) :-
	tembokKanan(X,Y),
	write('#'), 
	nl,
	writeElem(0,Y+1).

writeElem(X,Y) :-
	tembokAtas(X,Y),
	write('#'),
	writeElem(X+1,Y).

writeElem(X,Y) :-
	tembokKiri(X,Y),
	write('#'),
	writeElem(X+1,Y).

% writeElem(X,Y) :-
% 	waterTile(X,Y),
% 	write('o'),
% 	writeElem(X+1,Y).

writeElem(X,Y) :-
    write('-'),
    writeElem(X+1,Y).

%initiator elemen
initQuest :-
	dimensi(A,B),
	random(7,A,X),
	random(2,B,Y),
	asserta(questCoord(X,Y)).

initMarket :-
    dimensi(A,B),
	random(7,A,X),
	random(2,B,Y),
	asserta(marketCoord(X,Y)).

initHouse :-
    dimensi(A,B),
	random(7,A,X),
	random(2,B,Y),
	asserta(houseCoord(X,Y)).

initRanch :-
    dimensi(A,B),
	random(7,A,X),
	random(2,B,Y),
	asserta(ranchCoord(X,Y)).


initDimensi :-
	random(10,20, Length),
	random(10,15, Width),
	asserta(dimensi(Length, Width)).

initPlayerCoord :-
    houseCoord(X,Y),
    asserta(playerCoord(X,Y)).

initMap :- 
    initDimensi,
    initQuest,
    initRanch,
    initMarket,
    initHouse,
    initPlayerCoord.
writeDimensi :-
    dimensi(L,W),
    write(L),
    nl,
    write(W),
    nl.


legenda :-
    marketCoord(A,B),
    questCoord(C,D),
    ranchCoord(E,F),
    houseCoord(G,H),
    playerCoord(I,J),
    write('LEGENDS\t\t(X,Y)'), nl, nl,
    write('M\t: Marketplace\t('), write(A), write(','), write(B), write(')'), nl,
    write('P\t: You\t('), write(I), write(','), write(J), write(')'), nl,
    write('R\t: Ranch\t('), write(E), write(','), write(F), write(')'), nl,
    write('H\t: House\t('), write(G), write(','), write(H), write(')'), nl,
    write('Q\t: Quest\t('), write(C), write(','), write(D), write(')'), nl,
    write('o\t: Water (fish here!)'), nl,
    write('=\t: Digged Tile'), nl,!.

map :-
    writeDimensi,
    writeElem(0,0), nl, nl, nl,
    legenda,!.

teleport(X,Y):-
	\+tembokBawah(X,Y),
	\+tembokAtas(X,Y),
	\+tembokKiri(X,Y),
	\+tembokKanan(X,Y),
    \+waterTile(X,Y),
    retract(playerCoord(_,_)),
    asserta(playerCoord(X,Y)),
    write('Teleportation succesful!'), nl,
    write('You are now at ('), write(X), write(','), write(Y), write(')'), nl, !.

teleport(X,Y) :-
	marketPos(X,Y),
	retract(playerCoord(_,_)),
	asserta(playerCoord(X,Y)),
	write('Teleportation succesful!'), nl,
	write('You are now at the market.'), nl,
	write('Type market to access market'),nl,!.

teleport(X,Y) :-
	ranchPos(X,Y),
	retract(playerCoord(_,_)),
	asserta(playerCoord(X,Y)),
	write('Teleportation succesful!'), nl,
	write('You are now at the ranch.'), nl,
	write('Type ranch to access ranch'),nl,!.

teleport(X,Y) :-
	questPos(X,Y),
	retract(playerCoord(_,_)),
	asserta(playerCoord(X,Y)),
	write('Teleportation succesful!'), nl,
	write('You are now at the Quest spot.'), nl,
	write('Type quest to access quest'),nl,!.