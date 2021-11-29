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