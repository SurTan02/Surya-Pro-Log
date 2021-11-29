d :-
    playerCoord(X,Y),
    XNOW is X+1,
    \+tembokKanan(XNOW,Y),
    % \+ranchPos(XNOW,Y),
    % \+questPos(XNOW,Y),
    % \+marketPos(XNOW,Y),
    % \+diggedTile(XNOW,Y),
    retract(playerCoord(_,_)),
    asserta(playerCoord(XNOW,Y)),
    write('You move one step to the right'), nl,!.

d :- 
    playerCoord(X,Y),
    XNOW is X+1,
    tembokKanan(XNOW,Y),
    write('You Hit a Wall!'), nl,!.

w :-
    playerCoord(X,Y),
    YNOW is Y-1,
    \+tembokAtas(X,YNOW),
    % \+ranchPos(X,YNOW),
    % \+questPos(X,YNOW),
    % \+marketPos(X,YNOW),
    % \+diggedTile(X,YNOW),
    retract(playerCoord(_,_)),
    asserta(playerCoord(X,YNOW)),
    write('You move one step up'), nl,!.

w :-
    playerCoord(X,Y),
    YNOW is Y-1,
    tembokAtas(X,YNOW),
    write('You Hit a Wall!'), nl,!.

s :-
    playerCoord(X,Y),
    YNOW is Y+1,
    \+tembokBawah(X,YNOW),
    % \+ranchPos(X,YNOW),
    % \+questPos(X,YNOW),
    % \+marketPos(X,YNOW),
    % \+diggedTile(X,YNOW),
    retract(playerCoord(_,_)),
    asserta(playerCoord(X,YNOW)),
    write('You move one step down'), nl,!.

s :- 
    playerCoord(X,Y),
    YNOW is Y+1,
    tembokBawah(X,YNOW),
    write('You Hit a Wall!'), nl,!.


a :- 
    playerCoord(X,Y),
    XNOW is X-1,
    tembokKiri(XNOW,Y),
    write('You Hit a Wall!'),  nl,!.

 a :-
    playerCoord(X,Y),
    XNOW is X-1,
    \+tembokKiri(XNOW,Y),
    XNOW < 3,
    (
        insideMyInventory('level 3 boat') ->
        retract(playerCoord(_,_)),
        asserta(playerCoord(XNOW,Y)),
        write('You sail one step to the left'), nl,!
    ;   write('Buy a level 3 boat to sail much further'), nl, !
    ).

 a :-
    playerCoord(X,Y),
    XNOW is X-1,
    \+tembokKiri(XNOW,Y),
    XNOW < 5,
    (
        insideMyInventory('level 2 boat') ->
        retract(playerCoord(_,_)),
        asserta(playerCoord(XNOW,Y)),
        write('You sail one step to the left'), nl,!
    ;   write('Buy a level 2 boat to sail much further'), nl, !
    ).

 a :-
    playerCoord(X,Y),
    XNOW is X-1,
    \+tembokKiri(XNOW,Y),
    XNOW < 6,
    (
        insideMyInventory('level 1 boat') ->
        retract(playerCoord(_,_)),
        asserta(playerCoord(XNOW,Y)),
        write('You sail one step to the left'), nl,!
    ;   write('Buy a level 1 boat to sail much further'), nl, !
    ).

 a :-
    playerCoord(X,Y),
    XNOW is X-1,
    \+waterTile(XNOW,Y),
    % \+ranchPos(XNOW,Y),
    % \+questPos(XNOW,Y),
    % \+marketPos(XNOW,Y),
    % \+diggedTile(XNOW,Y),
    retract(playerCoord(_,_)),
    asserta(playerCoord(XNOW,Y)),
    write('You move one step to the left'), nl,!.
    

a :- 
    playerCoord(X,Y),
    XNOW is X-1,
    waterTile(XNOW,Y),
    write('Buy a boat to explore the waters!'),  nl,!.

harvestInfo  :-
    nl,
    eggVal(Egg),
    milkVal(Milk),
    woolVal(Wool),
    valCar(Carrot),
    valPot(Potato),
    valCor(Corn),
    valTom(Tomat),
    valPump(Pumpkin),
    write('****YOUR HARVEST INFO****'), nl,
    write('--------------------------------------RANCH----------------------------------------'), nl,
    write('Egg:                 '), write(Egg), write(' egg ready to harvest!'), nl,
    write('Wool:                '), write(Wool), write(' wool ready to harvest!'), nl,
    write('Milk:                '), write(Milk), write(' milk ready to harvest!'), nl,
    write('---------------------------------------FARM-----------------------------------------'), nl,
    write('Carrot:              '), write(Carrot), write(' carrot ready to harvest!'), nl,
    write('Corn:                '), write(Corn), write(' corn ready to harvest!'), nl,
    write('Potato:              '), write(Potato), write(' potato ready to harvest!'), nl,       
    write('Tomato:              '), write(Tomat), write(' tomato ready to harvest!'), nl,
    write('Pumpkin:             '), write(Pumpkin), write(' pumpkin ready to harvest!'), nl,!.