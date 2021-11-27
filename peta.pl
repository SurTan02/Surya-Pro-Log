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

% writeElem(X,Y) :-
% 	diggedTile(X,Y),
% 	write('='),
% 	writeElem(X+1,Y).

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
    write('LEGENDS'), nl, nl,
    write('M\t: Marketplace'), nl,
    write('R\t: Ranch'), nl,
    write('H\t: House'), nl,
    write('Q\t: Quest'), nl,
    write('o\t: Water (fish here!)'), nl,
    write('=\t: Digged Tile'), nl.

map :-
    writeDimensi,
    writeElem(0,0), nl, nl, nl,
    legenda.

d :-
    playerCoord(X,Y),
    XNOW is X+1,
    \+tembokKanan(XNOW,Y),
    \+ranchPos(XNOW,Y),
    \+questPos(XNOW,Y),
    \+marketPos(XNOW,Y),
    \+diggedTile(XNOW,Y),
    retract(playerCoord(_,_)),
    asserta(playerCoord(XNOW,Y)),
    write('You move one step to the right'), nl.

d :- 
    playerCoord(X,Y),
    XNOW is X+1,
    tembokKanan(XNOW,Y),
    write('You Hit a Wall!'), nl.

w :-
    playerCoord(X,Y),
    YNOW is Y-1,
    \+tembokAtas(X,YNOW),
    \+ranchPos(X,YNOW),
    \+questPos(X,YNOW),
    \+marketPos(X,YNOW),
    \+diggedTile(X,YNOW),
    retract(playerCoord(_,_)),
    asserta(playerCoord(X,YNOW)),
    write('You move one step up'), nl.

w :-
    playerCoord(X,Y),
    YNOW is Y-1,
    tembokAtas(X,YNOW),
    write('You Hit a Wall!'), nl.

s :-
    playerCoord(X,Y),
    YNOW is Y+1,
    \+tembokBawah(X,YNOW),
    \+ranchPos(X,YNOW),
    \+questPos(X,YNOW),
    \+marketPos(X,YNOW),
    \+diggedTile(X,YNOW),
    retract(playerCoord(_,_)),
    asserta(playerCoord(X,YNOW)),
    write('You move one step down'), nl.

s :- 
    playerCoord(X,Y),
    YNOW is Y+1,
    tembokBawah(X,YNOW),
    write('You Hit a Wall!'), nl.

 a :-
    playerCoord(X,Y),
    XNOW is X-1,
    \+waterTile(XNOW,Y),
    \+ranchPos(XNOW,Y),
    \+questPos(XNOW,Y),
    \+marketPos(XNOW,Y),
    \+diggedTile(XNOW,Y),
    retract(playerCoord(_,_)),
    asserta(playerCoord(XNOW,Y)),
    write('You move one step to the left'), nl.   

    
