:- include('player.pl').

:- dynamic(valCow/1).
:- dynamic(valChicken/1).
:- dynamic(valSheep/1).
:- dynamic(capacity/1).
:- dynamic(milkVal/1).
:- dynamic(eggVal/1).
:- dynamic(woolVal/1).
:- dynamic(chicken/2). %nyimpen perlu berapa energi lagi buat produce (energy left, ID)
:- dynamic(cow/2).
:- dynamic(sheep/2).
:- dynamic(chickenID/1). %next id ke berapa ya ???
:- dynamic(cowID/1).
:- dynamic(sheepID/1).


initializeRanchVal :-
    asserta(valCow(0)),
    asserta(valChicken(0)),
    asserta(valSheep(0)),
    asserta(milkVal(0)),
    asserta(eggVal(0)),
    asserta(woolVal(0)),
    asserta(chickenID(1)),
    asserta(cowID(1)),
    asserta(sheepID(1)).


resetRanchVal :-
    retractall(valCow(_)),
    retractall(valChicken(_)),
    retractall(valSheep(_)),
    retractall(milkVal(_)),
    retractall(eggVal(_)),
    retractall(woolVal(_)),
    retractall(chickenID(_)),
    retractall(cowID(_)),
    retractall(sheepID(_)),
    retractall(chicken(_,_)),
    retractall(cow(_,_)),
    retractall(sheep(_,_)).
    
ranchMenu :-
    write('Welcome to the ranch! You have :'),nl,
    valChicken(CurrCh),
    valSheep(CurrSh),
    valCow(CurrCw),
    (\+(currCh = 0) -> write(CurrCh),write(' chicken'),nl),
    (\+(currSh = 0) -> write(CurrSh),write(' sheep'),nl),
    (\+(currCw = 0) -> write(CurrCw),write(' cow'),nl),nl,
    write('What do you want to do?'),!,nl,
    read(Choice),nl,!,
    (
     (Choice = chicken), getChickenProduce;
     (Choice = sheep), getSheepProduce;
     (Choice = cow), getCowProduce
    ).

getChickenProduce :-
    eggVal(A),
    (
    A = 0 -> write('Your chciken has not produce any egg.'),nl,write('Please check again later.');
    
    write('Your chicken lays '), write(A), write(' eggs'),nl,write('You got '), write(A),write(' eggs!'),nl,
    write('You gain 50 Exp Ranching'),nl,
    write('You gain 50 Exp Player'),    
    earnEXPRanching(50),
    earnEXPPlayer(50)
    ),
    retractall(eggVal(_)),
    asserta(eggVal(0)).

getSheepProduce :-
    woolVal(A),
    (
    A = 0 -> write('Your sheep has not produce any wool.'),nl,write('Please check again later.');

    write('Your sheep produce '), write(A), write(' wool'),nl,write('You got '), write(A),write(' wool!'),nl,
    write('You gain 50 Exp Ranching'),nl,
    write('You gain 50 Exp Player'),    
    earnEXPRanching(50),
    earnEXPPlayer(50)
    ),
    retractall(woolVal(_)),
    asserta(woolVal(0)).

getCowProduce :-
    milkVal(A),
    (
    A = 0 -> write('Your cow has not produce any milk.'),nl,write('Please check again later.');

    write('Your cow produce '), write(A), write(' milk'),nl,write('You got '), write(A),write(' milk!'),nl,
    write('You gain 50 Exp Ranching'),nl,
    write('You gain 50 Exp Player'),    
    earnEXPRanching(50),
    earnEXPPlayer(50)
    ),
    retractall(milkVal(_)),
    asserta(milkVal(0)).

incEgg(X) :-
    eggVal(A),
    RES is A+X,
    retractall(eggVal(_)),
    asserta(eggVal(RES)).


incMilk(X) :-
    milkVal(A),
    RES is A+X,
    retractall(milkVal(_)),
    asserta(milkVal(RES)).

incWool(X) :-
    woolVal(A),
    RES is A+X,
    retractall(woolVal(_)),
    asserta(woolVal(RES)).

incCow(X) :-
    valCow(A),
    RES is A+X,
    retractall(valCow(_)),
    asserta(valCow(RES)),
    retractall(cowID(ID)),
    assertz(cow(1000,ID)),
    NewID is ID + 1,
    asserta(cowID(NewID)).

incSheep(X) :-
    valSheep(A),
    RES is A+X,
    retractall(valSheep(_)),
    asserta(valSheep(RES)),
    retractall(sheepID(ID)),
    assertz(sheep(600,ID)),
    NewID is ID + 1,
    asserta(sheepID(NewID)).


incChicken(X) :-
    valChicken(A),
    RES is A+X,
    retractall(valChicken(_)),
    asserta(valChicken(RES)),
    retractall(chickenID(ID)),
    assertz(chicken(300,ID)),
    NewID is ID + 1,
    asserta(chickenID(NewID)).

%everytime energies are spent, call this to update
checkProduce(X) :-
    findall(Energy, chicken(Energy,_), ListChickenEnergy),
    findall(Energy, cow(Energy,_), ListCowEnergy),
    findall(Energy, sheep(Energy,_), ListSheepEnergy),
    checkCowProduction(ListCowEnergy,X,1),
    checkSheepProduction(ListSheepEnergy,X,1),
    checkChickenProduction(ListChickenEnergy,X,1).
    


% increase produce every X spend energy
checkCowProduction([],X,0).
checkCowProduction([H],X,ID) :- cowID(B), B is B-1, B = ID,
    Left is H-X,
    (
        (Left =< 0), incMilk(1)
    ),
    retract(cow(_,ID)), EN is mod(Left,1000), assertz(cow(EN,ID)).

checkCowProduction([H|T],X,ID) :-
    Left is H-X,
    (
        (Left =< 0), incMilk(1)
    ),
    retract(cow(_,ID)), EN is mod(Left,1000), assertz(cow(EN,ID)).
    NextID is ID+1,
    checkCowProduction(T,X,NextID).

checkSheepProduction([],X,0).
checkSheepProduction([H],X,ID) :- sheepID(B), B is B-1, B = ID,
    Left is H-X,
    (
        (Left =< 0), incWool(1)
    ),
    retract(sheep(_,ID)), EN is mod(Left,1000), assertz(sheep(EN,ID)).

checkSheepProduction([H|T],X,ID) :-
    Left is H-X,
    (
        (Left =< 0), incWool(1)
    ),
    retract(sheep(_,ID)), EN is mod(Left,1000), assertz(sheep(EN,ID)).
    NextID is ID+1,
    checkSheepProduction(T,X,NextID).

checkChickenProduction([],X,0).
checkChickenProduction([H],X,ID) :- chickenID(B), B is B-1, B = ID,
    Left is H-X,
    (
        (Left =< 0), incEgg(1)
    ),
    retract(chicken(_,ID)), EN is mod(Left,1000), assertz(chicken(EN,ID)).

checkChickenProduction([H|T],X,ID) :-
    Left is H-X,
    (
        (Left =< 0), incEgg(1)
    ),
    retract(chicken(_,ID)),  EN is mod(Left,1000), assertz(chicken(EN,ID)).
    NextID is ID+1,
    checkChickenProduction(T,X,NextID).