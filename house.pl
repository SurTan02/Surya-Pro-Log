:- dynamic(isInHouse/1).
:- dynamic(isSleeping/1).

house :-
    playerCoord(X,Y),
    \+houseCoord(X,Y),
    write('Go to House (H) to access this command!'),nl,
    !,fail.

house :-
    asserta(isInHouse(1)), 
    write('Welcome Home Claire!'), nl,
    write('What do you want to do?'), nl,
    write('\t- sleep'), nl,
    write('\t- writeDiary'), nl,
    write('\t- readDiary'), nl,
    write('\t- exit (use exitHouse command)'), nl, !, fail.

sleep :-
    \+isInHouse(_),
    write('Illegal command!'),nl,
    write('Go to your house (H) to sleep.'),nl,!,fail.

sleep :-
    isInHouse(_),
    asserta(isSleeping(1)), 
    maxEnergy(Energy),
    gainEnergy(Energy),
    addDay,
    day(D),
    updateSeason,
    season(Season),
    (
        initPeriTidur ->
        write('You\'ve been visited by a mysterious sleep fairy! \nAs a reward, she grants you one wish to teleport to  any place in this world.'), nl, nl,
        legenda,
        write('Where did you want to go?'), nl,
        write('X >>>'),
        read(X), nl,
        write('Y >>>'),
        read(Y),
        teleport(X,Y);
        !
    ),
    write('Day '), write(D),nl,
    write('Season: '), write(Season), nl,
    retract(isSleeping(_)),
    retract(isInHouse(_)), !.

initPeriTidur :-
    random(0,1000,X),
    luck(Y),
    X < Y*10, !,
    asserta(isKetemuPeriTidur(1)), !.

forceSleep :-
     houseCoord(X,Y),
     retractall(playerCoord(_,_)),
     asserta(playerCoord(X,Y)),
     sleep.