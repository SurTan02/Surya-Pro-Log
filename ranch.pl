% :- include('player.pl').
% :- include('inventory.pl').

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
:- dynamic(cowEN/1).
:- dynamic(sheepEN/1).
:- dynamic(chickenEN/1).


initRanchVal :-
    asserta(valCow(0)),
    asserta(valChicken(0)),
    asserta(valSheep(0)),
    asserta(milkVal(0)),
    asserta(eggVal(0)),
    asserta(woolVal(0)),
    asserta(chickenID(1)),
    asserta(cowID(1)),
    asserta(sheepID(1)),
    asserta(cowEN(1000)),
    asserta(sheepEN(600)),
    asserta(chickenEN(300)).


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

ranch :-
    playerCoord(X,Y),
    \+ranchCoord(X,Y),
    write('Go to Ranch (R) to access this command!'),nl,
    !,fail.

ranch :-
    write('Welcome to the ranch! You have :'),nl,
    valChicken(CurrCh),
    valSheep(CurrSh),
    valCow(CurrCw),
    (\+(currCh = 0) -> write(CurrCh),write(' chicken'),nl),
    (\+(currSh = 0) -> write(CurrSh),write(' sheep'),nl),
    (\+(currCw = 0) -> write(CurrCw),write(' cow'),nl),nl,
    
    write('What do you want to do?'),!,nl,
    write('Example write \'chicken\' to get Egg!\n'),
    read(Choice),nl,!,
    (
     (Choice = chicken), getChickenProduce;
     (Choice = sheep), getSheepProduce;
     (Choice = cow), getCowProduce
    ).

getChickenProduce :-
    eggVal(A),
    (
    A = 0 -> write('Your chickenhas not produce any egg.'),nl,write('Please check again later.'), fail;
    
    write('Your chicken lays '), write(A), write(' eggs'),nl,write('You got '), write(A),write(' eggs!'),nl,
    write('You gain 50 Exp!\n'),    
    earnEXPPlayer(50),
    addNtimes(A, 5)
    ),
    retractall(eggVal(_)),
    asserta(eggVal(0)),

    levelRanching(LVLranch),
    LVLranch <10, !,
    write('You gained 50 ranching exp'),nl,
    earnEXPRanching(50).


getSheepProduce :-
    woolVal(A),
    (
    A = 0 -> write('Your sheep has not produce any wool.'),nl,write('Please check again later.'), fail;

    write('Your sheep produce '), write(A), write(' wool'),nl,write('You got '), write(A),write(' wool!'),nl,
    write('You gain 50 Exp!\n'),    
    earnEXPPlayer(50),
    addNtimes(A, 5)
    ),
    retractall(woolVal(_)),
    asserta(woolVal(0)),

    levelRanching(LVLranch),
    LVLranch <10, !,
    write('You gained 50 ranching exp'),nl,
    earnEXPRanching(50).

getCowProduce :-
    milkVal(A),
    (
    A = 0 -> write('Your cow has not produce any milk.'),nl,write('Please check again later.'), fail;

    write('Your cow produce '), write(A), write(' milk'),nl,write('You got '), write(A),write(' milk!'),nl,
    write('You gain 50 Exp!\n'),    
    earnEXPPlayer(50),
    addNtimes(A, 5)
    ),
    retractall(milkVal(_)),
    asserta(milkVal(0)),

    levelRanching(LVLranch),
    LVLranch <10, !,
    write('You gained 50 ranching exp'),nl,
    earnEXPRanching(50).

incEgg(X) :-
    eggVal(A),
    valChicken(B),
    RES is A+(X*B),
    retractall(eggVal(_)),
    asserta(eggVal(RES)).


incMilk(X) :-
    milkVal(A),
    valCow(B),
    RES is A+(X*B),
    retractall(milkVal(_)),
    asserta(milkVal(RES)).

incWool(X) :-
    woolVal(A),
    valSheep(B),
    RES is A+(X*B),
    retractall(woolVal(_)),
    asserta(woolVal(RES)).

incCow(X) :-
    valCow(A),
    RES is A+X,
    retractall(valCow(_)),
    asserta(valCow(RES)),
    cowID(ID),
    assertz(cow(1000,ID)),
    NewID is ID + 1,
    retractall(cowID(_)),
    asserta(cowID(NewID)).

incSheep(X) :-
    valSheep(A),
    RES is A+X,
    retractall(valSheep(_)),
    asserta(valSheep(RES)),
    sheepID(ID),
    assertz(sheep(600,ID)),
    NewID is ID + 1,
    retractall(sheepID(_)),
    asserta(sheepID(NewID)).


incChicken(X) :-
    valChicken(A),
    RES is A+X,
    retractall(valChicken(_)),
    asserta(valChicken(RES)),
    chickenID(ID),
    assertz(chicken(300,ID)),
    NewID is ID + 1,
    retractall(chickenID(_)),
    asserta(chickenID(NewID)).

%everytime energies are spent, call this to update
checkRanchProduce(X) :-
    valCow(VCow),
    valChicken(VChick),
    valSheep(VSheep),
    cowEN(CowEN),
    sheepEN(SheepEN),
    chickenEN(ChickenEN),
    (
        VCow > 0 -> checkCowProduction(CowEN,X,1);
        !
    ),
    (
        VChick > 0 -> checkChickenProduction(ChickenEN,X,1);
        !
    ),
    (
        VSheep > 0 -> checkSheepProduction(SheepEN,X,1);
        !
    ).
    


% increase produce every X spend energy
checkCowProduction(H,X,_) :- 
    Left is H-X,
    (
            Left = 0, EN is 1000, incMilk(1);
            Left < 0, EN is mod(Left,1000),incMilk(1);
            Left > 0, EN is mod(Left,1000)
    ),
    retractall(cowEN(_)), asserta(cowEN(EN)).

checkSheepProduction(H,X,_) :- 
    Left is H-X,
    (
            Left = 0, EN is 600, incWool(1);
            Left < 0, EN is mod(Left,600),incWool(1);
            Left > 0, EN is mod(Left,600)
    ),
    retractall(sheepEN(_)), asserta(sheepEN(EN)).

checkChickenProduction(H,X,_) :- 
    Left is H-X,
    (
            Left = 0, EN is 300, incEgg(1);
            Left < 0, EN is mod(Left,300),incEgg(1);
            Left > 0, EN is mod(Left,300)
    ),
    retractall(chickenEN(_)), asserta(chickenEN(EN)).




makeCheese :-
    \+insideMyInventory('milk'),
    write('You don\'t have any milk in your inventory'), nl,
    !, fail.


makeCheese :-
    jobPlayer(X),
    levelRanching(LVLR),
    (
        X = rancher, write('Only Rancher can do this task!\n'), !, fail;
        LVLR < 7, write('You level is too low to do this task!'),!, fail;
        !
    ),
    write('How many cheese do you want to make\n'),
    write(>>>),read(N),nl,
    myInventory(4, _, _, _, _, _, _,_, Count),
    % write(Count),

    (
        Count >= N, addNtimes(N, 7), deleteNItems(N,4), format('You got ~w cheese!', [N]),nl
        ;
        Count < N, format('You don\'t have ~w milk in your inventory', [N]),nl
    ).

makeMayo :-
    \+insideMyInventory('egg'),
    write('You don\'t have any egg in your inventory'), nl,
    !, fail.


makeMayo :-
    jobPlayer(X),
    levelRanching(LVLR),
    (
        X = rancher, write('Only Rancher can do this task!\n'), !,fail;
        LVLR < 3, write('You level is too low to do this task!'),!,fail;
        !
    ),
    write('How many mayonnaise do you want to make\n'),
    write(>>>),read(N),nl,
    myInventory(5,  _, _, _, _, _, _,_, Count),


    (
        Count >= N, addNtimes(N, 8), deleteNItems(N,5), format('You got ~w mayonnaise!', [N]),nl
        ;
        Count < N, format('You don\'t have ~w eggs in your inventory', [N]),nl
    ).

makeSweater :-
    \+insideMyInventory('wool'),
    write('You don\'t have any wool in your inventory'), nl,
    !, fail.

makeSweater :-
    jobPlayer(X),
    levelRanching(LVLR),
    (
        X = rancher, write('Only Rancher can do this task!\n'), !,fail;
        LVLR < 5, write('You level is too low to do this task!'),!,fail;
        !
    ),
    write('How many Sweater do you want to make\n'),
    write(>>>),read(N),nl,
    myInventory(6,  _, _, _, _, _, _,_, Count),

    (
        Count >= N, addNtimes(N, 9), deleteNItems(N,6), format('You got ~w Sweater!', [N]),nl
        ;
        Count < N, format('You don\'t have ~w wool in your inventory', [N]),nl
    ).
