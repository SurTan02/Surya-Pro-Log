:- dynamic(myInventory/9).

% :- include('items.pl').
% :- include('player.pl').
% % myInventory(ID, Name, String_Name, Type, Level, EnergyNeed, EnergySupply, Price, Count).

% % FOR DEBUGGING PURPOSES
% myInventory(30, fishingrod, 'level 2 fishing rod', equipment, 2, 0, 0, 100, 1).
% myInventory(10, carrot_seed, 'carrot seed', commodity, 1, 350, 0, 5, 10).
% myInventory(11, potato_seed, 'potato seed', commodity, 1, 375, 0, 7, 2).
% myInventory(23, energy_drink, 'energyDrink', consumable, 0, 0, 50, 20, 3).

myInventory(26, shovel, 'level 1 shovel', equipment, 1, 0, 0, 50, 1).
myInventory(29, fishingrod, 'level 1 fishing rod', equipment, 1, 0, 0, 50, 1).

updatePrice :-
    job(Job),
    (
        (Job == rancher) ->
        retractall(item(_,_,_,rancherProd,_,_,_,_)),
        asserta(item(4, milk, 'milk', rancherProd, 0, 1000, 0, 60)),
        asserta(item(5, egg, 'egg', rancherProd, 0, 300, 0, 15)),
        asserta(item(6, wool, 'wool', rancherProd, 0, 600, 0, 30))
    ;   (Job == farmer) ->
        retractall(item(_,_,_,farmerProd,_,_,_,_)),
        asserta(item(15, carrot, 'carrot', farmerProd, 0, 150, 0, 15)),
        asserta(item(16, potato, 'potato', farmerProd, 0, 175, 0, 21)),
        asserta(item(17, corn, 'corn', farmerProd, 0, 450, 0, 27)),
        asserta(item(18, tomato, 'tomato', farmerProd, 0, 800, 0, 37)),
        asserta(item(19, pumpkin, 'pumpkin', farmerProd, 0, 1000, 0, 52))
    ;   (Job == fisherman) ->
        asserta(item(20, betutu_fish, 'betutu fish', fisherman, 0, 0, 0, 60)),
        asserta(item(21, gurame_fish, 'gurame fish', fisherman, 0, 0, 0, 30)),
        asserta(item(22, teri_fish, 'teri fish', fisherman, 0, 0, 0, 7))
    ).


maxInventory(100).

addToInventory(_) :-
    cekJumlahInventory(Sum),
    maxInventory(Max),
    Sum >= Max,
    write('Inventory Full'),
    !,fail.

addToInventory(ID) :-
    update_quest(ID),
    findall(InvID, myInventory(InvID,_,_,_,_,_,_,_,_), ListID),
    (   isInInventory(ID, ListID) -> %jikka ada di inventory
        item(ID, Name,_,_,_,_,_,_),
        retract(myInventory(ID, Name, String_Name, Type, Level, EnergyNeed, EnergySupply, Price, Count)),
        NewCount is Count+1,
        assertz(myInventory(ID, Name, String_Name, Type, Level, EnergyNeed, EnergySupply, Price, NewCount))
    ;   item(ID, Name, String_Name, Type, Level, EnergyNeed, EnergySupply, Price),
        Count is 1,
        assertz(myInventory(ID, Name, String_Name, Type, Level, EnergyNeed, EnergySupply, Price, Count))
    ).

addNtimes(0,_).
addNtimes(N, ID) :-
    addToInventory(ID),
    S is N-1, 
    addNtimes(S, ID), !.

deleteFromInventory(ID) :-
    item(ID, Name,_,_,_,_,_,_),
    myInventory(ID, Name, String_Name, Type, Level, EnergyNeed, EnergySupply, Price, Count),
    NewCount is Count-1,
    (
        (NewCount >= 1) ->
        retract(myInventory(ID, Name, String_Name, Type, Level, EnergyNeed, EnergySupply, Price, Count)),
        assertz(myInventory(ID, Name, String_Name, Type, Level, EnergyNeed, EnergySupply, Price, NewCount))
    ;   retract(myInventory(ID, Name, String_Name, Type,    Level, EnergyNeed, EnergySupply, Price, Count))

    ).


 deleteNItems(N, ID) :-
    findall(InvID, myInventory(InvID,_,_,_,_,_,_,_,_), ListID),
    (
        isInInventory(ID, ListID) ->
        myInventory(ID,_,_,_,_,_,_,_,Count),
        NewCount is Count-N,
        (
            (NewCount < 0) ->
            write('You don\'t have that much item in your inventory'), nl, fail
        ;   deleteNtimes(N,ID)
        )
    ;   write('you don\'t have that item in your inventory'), nl, fail
    ).
    

deleteNtimes(0,_).
deleteNtimes(N, ID) :-
    deleteFromInventory(ID),
    S is N-1, 
    deleteNtimes(S, ID), !.

cekJumlahInventory(Sum):-
    findall(Count, myInventory(_,_,_,_,_,_,_,_, Count), List),
    sum_list(List, Sum).

% CEK APAKAH ITEM ADA DI INVENTORY
% Caranya: insideMyInventory('carrot seed').
insideMyInventory(StrName) :-
    findall(String_Name, myInventory(_,_,String_Name,_,_,_,_,_,_), String_Name_List),
    isInInventory(StrName, String_Name_List), !.

isInInventory(ID,[ID|_]).
isInInventory(ID,[_|T]) :- isInInventory(ID,T).

isFull :-
    cekJumlahInventory(Sum),
    Sum == 100.

makeListInventory(String_Name_List, TypeList, CountList) :-
    findall(String_Name, myInventory(_,_, String_Name,_,_,_,_,_,_), String_Name_List),
    findall(Type, myInventory(_,_,_,Type,_,_,_,_,_), TypeList),
    findall(Count, myInventory(_,_,_,_,_,_,_,_,Count), CountList).

writeInventory([], [], []).
writeInventory([A|V], [B|W], [C|X]) :-
    (
        (B == consumable) ->
        write('\t'),
        write(C), write(' '), write(A), write(' ('), write(B), write(')'), nl,
        writeInventory(V,W,X)
    ;   write('\t'), write(C), write(' '), write(A), nl,
        writeInventory(V,W,X)
    ).
    
inventory :-
    cekJumlahInventory(X), nl,
    write('\tYour Inventory ('), write(X), write('/100)'), nl,nl,
    makeListInventory(String_Name_List, TypeList, CountList),
    writeInventory(String_Name_List, TypeList, CountList),nl,
    write('\twrite consumable name to use it'), nl,
    write('\texample: energyDrink to use energyDrink').

energyDrink :-
    \+insideMyInventory('energyDrink'),
    write('You don\'t have any  energy drink in your inventory'), nl,
    !, fail.
energyDrink :-
    useConsumables('energyDrink'),!,fail.

coffeBTS :-
    \+insideMyInventory('coffeBTS'),
    write('You don\'t have any coffeBTS in your inventory'), nl,
    !, fail.
coffeBTS :-
    useConsumables('coffeBTS'),!,fail.

useConsumables(String_Name) :-
    insideMyInventory(String_Name),
    myInventory(ID,_, String_Name,_,_,_, EnergySupply, _,_),
    gainEnergy(EnergySupply),
    deleteFromInventory(ID),!,fail.

specialtiesPotion :-
    \+insideMyInventory('specialtiesPotion'),
    write('You don\'t have any specialtiesPotion in your inventory'), nl,
    !, fail.

specialtiesPotion :-
    insideMyInventory('specialtiesPotion'),
    jobPlayer(Job),
    (
        (Job == fisherman) ->
        levelFishing(LvlFish),
        X is 100 * LvlFish,
        earnEXPFishing(X)

    ;   (Job == rancher) ->
        levelRanching(LvlRanch),
        X is 100* LvlRanch,
        earnEXPRanching(X)

    ;   (Job == farmer) ->
        levelFarming(LvlFarming),
        X is 100*LvlFarming,
        earnEXPFarming(X)
    ).

