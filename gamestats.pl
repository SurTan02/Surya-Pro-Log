:- dynamic(day/1).
:- dynamic(season/1).


maxDay(365).
maxMoney(20000).
day(1).
season(spring).

addDay :-
    \+isSleeping(_),
    write('Illegal Command! you must sleep to change day!'), nl, !.

addDay :-
    day(D),
    maxDay(MaxDay),
    NextDay is D + 1,
    (
        (NextDay >= MaxDay) ->
        money(PlayerMoney),
        maxMoney(MaxMoney),
        (
            (PlayerMoney >= MaxMoney) ->
            goalState, !,fail
            ; failState

        )
    ;   retract(day(D)),
        asserta(day(NextDay))
    ).

updateSeason :-
    day(D),
    season(Season),
    (
        (D > 274) ->
        retractall(season(_)),
        asserta(season(winter))
    ;   (D > 183) ->
        retractall(season(_)),
        asserta(season(autumn))
    ;   (D > 92) ->
        retractall(season(_)),
        asserta(season(summer))
        ;!
    ).

goalState :-
    write('selamat kamu menang!'), !.

failState :-
    write('kamu kalah!'), !.