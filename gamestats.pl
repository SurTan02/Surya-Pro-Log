:- dynamic(day/1).
:- dynamic(season/1).
% :- dynamic(money/1).
% :- include('player.pl').
% money(10000).
maxDay(365).
maxMoney(20000).
day(364).
season(spring).

addDay :-
    \+isSleeping(_),
    write('Illegal Command! you must sleep to change day!'), nl, !.

addDay :-
    day(D),
    maxDay(MaxDay),
    NextDay is D + 1,
    (
        (NextDay > MaxDay) ->
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

checkGoalMoney :-
    maxMoney(X),
    money(CurrMoney),
    \+CurrMoney >= X.

checkGoalMoney :-
    maxMoney(X),
    money(CurrMoney),
    CurrMoney >= X,
    goalState.

goalState :-
    win_screen,exit.
    % write('Press Anything to end the game\n'),
    % read(_),
    % halt.

failState :-
    lose_screen,exit.
    % write('Press Anything to end the game\n'),
    % read(_),
    % halt.