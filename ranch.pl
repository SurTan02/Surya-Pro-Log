:- dynamic(valCow/1).
:- dynamic(valChicken/1).
:- dynamic(valSheep/1).
:- dynamic(capacity/1).
:- dynamic(milkVal/1).
:- dynamic(eggVal/1).
:- dynamic(woolVal/1).

initializeRanchVal :-
    asserta(valCow(0)),
    asserta(valChicken(0)),
    asserta(valSheep(0)),
    asserta(milkVal(0)),
    asserta(eggVal(0)),
    asserta(woolVal(0)).

resetRanchVal :-
    retractall(valCow(_)),
    retractall(valChicken(_)),
    retractall(valSheep(_)),
    retractall(milkVal(_)),
    retractall(eggVal(_)),
    retractall(woolVal(_)).
    
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
    write('Your chicken lays '), write(A), write(' eggs'),nl,write('You got '), write(A),write(' eggs!'),nl
    ).

getSheepProduce :-
    woolVal(A),
    (
    A = 0 -> write('Your sheep has not produce any wool.'),nl,write('Please check again later.');
    write('Your sheep produce '), write(A), write(' wools'),nl,write('You got '), write(A),write(' wools!'),nl
    ).

getCowProduce :-
    milkVal(A),
    (
    A = 0 -> write('Your cow has not produce any milk.'),nl,write('Please check again later.');
    write('Your cow produce '), write(A), write(' milk'),nl,write('You got '), write(A),write(' milk!'),nl
    ).

incEgg(X) :-
    eggVal(A),
    res is A+X,
    retractall(eggVal(_)),
    asserta(eggVal(res)).


incMilk(X) :-
    milkVal(A),
    res is A+X,
    retractall(milkVal(_)),
    asserta(milkVal(res)).

incWool(X) :-
    woolVal(A),
    res is A+X,
    retractall(woolVal(_)),
    asserta(woolVal(res)).

% increase produce every X spend energy
checkIncProduce :- %in progress