:- dynamic(koordinatP/2).
:- dynamic(koordinatMarketplace/2).
:- dynamic(koordinatQuest/2).
:- dynamic(koordinatHouse/2).
:- dynamic(koordinatAir/2).
:- dynamic(koordinatDiggedT/2).
:- dynamic(dimensi/2).
:- dynamic(tembok/2).

posisiP(X,Y) :-
	koordinatP(A,B),
	X =:= A,
	Y =:= B.

posisiMarketplace(X,Y) :-				/* Posisi S statik */
	koordinatMarketplace(A,B),
	X =:= A,
	Y =:= B.

posisiQuest(X,Y) :-
	koordinatQuest(A,B),
	X =:= A,
	Y =:= B.
	
posisiRanch(X,Y) :-				/* Posisi D statik */
	koordinatRanch(A,B),
	X =:= A,				
	Y =:= B.

posisiAir(X,Y) :-
	koordinatAir(A,B),
	X =:= A,
	Y =:= B.

posisiHouse(X,Y) :-
	koordinatHouse(A,B),
	X =:= A,
	Y =:= B.

posisiDiggedT(X,Y) :-
	koordinatDiggedT(A,B),
	X =:= A,
	Y =:= B.

tembokAtas(_,Y) :-
	Y =:= 0.
	
tembokBawah(_,Y) :-
	dimensi(_,L),
	Y =:= L+1.
	
tembokKiri(X,_) :-
	X =:= 0.
	
tembokKanan(X,_) :-
	dimensi(W,_),
	X =:= W+1.
	

% Write tembok
writeC(X,Y) :-				
	tembokKanan(X,Y),
	tembokBawah(X,Y),
    tembokAtas(X,Y),
    tembokKiri(X,Y),
	write('#').

% Write Posisi Player	
writeC(X,Y) :-
	posisiP(X,Y),
	write('P'),
	writeC(X+1,Y).

% Write Marketplace
writeC(X,Y) :-
	posisiMarketplace(X,Y),
	write('M'),
	writeC(X+1,Y).
	
% Write Ranch
writeC(X,Y) :-
	posisiRanch(X,Y),
	write('R'),
	writeC(X+1,Y).
% Write House
writeC(X,Y) :-
	posisiHouse(X,Y),
	write('H'),
	writeC(X+1,Y).

% Write tempat Quest
writeC(X,Y) :-
	posisiQuest(X,Y),
	write('Q'),
	writeC(X+1,Y).

% Write air
writeC(X,Y) :-
	posisiAir(X,Y),
	write('o'),
	writeC(X+1,Y).

% Write digged tile
writeC(X,Y) :-
	posisiDiggedT(X,Y),
	write('='),
	writeC(X+1,Y).

  
generateTembok :-
	dimensi(A,B),
	A1 is A-1,
	B1 is B-1,
	random(2,A1,X),
	random(2,B1,Y),
	asserta(tembok(X,Y)).
  
initTembok :-
	generateTembok,
	generateTembok,
	generateTembok,
	generateTembok,

initDimensi :-
	random(10,20, Length),
	random(10,15, Width),
	asserta(dimensi(Length, Width)).

initStore :-
	dimensi(A,B),
	random(2,A,X),
	random(2,B,Y),
	asserta(koordinatS(X,Y)).

initQuest :-
	dimensi(A,B),
	random(2,A,X),
	random(2,B,Y),
	asserta(koordinatQ(X,Y)).

initDungeon :-
	dimensi(A,B),
	random(2,A,X),
	random(2,B,Y),
	asserta(koordinatD(X,Y)).


initMap :-
	initDimensi,
	initRanch,
	initAir,
	initHouse,
	initMarketplace,
	initDiggedT,
	initQuest,
	initTembok.


