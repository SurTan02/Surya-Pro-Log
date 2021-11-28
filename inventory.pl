:- dynamic(myInventory/9).

% :- include('items.pl').
% % myInventory(ID, Name, String_Name, Type, Level, EnergyNeed, EnergySupply, Price, Count).

% FOR DEBUGGING PURPOSES
% myInventory(30, fishingrod, 'level 2 fishing rod', equipment, 2, 0, 0, 100, 1).
% myInventory(10, carrot_seed, 'carrot seed', commodity, 1, 350, 0, 5, 10).
% myInventory(11, potato_seed, 'potato seed', commodity, 1, 375, 0, 7, 2).


maxInventory(100).

addToInventory(_) :-
    cekJumlahInventory(Sum),
    maxInventory(Max),
    Sum >= Max,
    write('Inventory Full'),
    !,fail.

addToInventory(ID) :-
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
    findall(InvID, myInventory(InvID,_,_,_,_,_,_,_,_), ListID),
    (   isInInventory(ID, ListID) -> %jikka ada di inventory
        item(ID, Name,_,_,_,_,_,_),
        myInventory(ID, Name, String_Name, Type, Level, EnergyNeed, EnergySupply, Price, Count),
        NewCount is Count-1,
        (
            NewCount >= 1 ->
            retract(myInventory(ID, Name, String_Name, Type, Level, EnergyNeed, EnergySupply, Price, Count)),
            assertz(myInventory(ID, Name, String_Name, Type, Level, EnergyNeed, EnergySupply, Price, NewCount))
        ;   retract(myInventory(ID, Name, String_Name, Type,    Level, EnergyNeed, EnergySupply, Price, Count))



        )
    ;   write('You dont have that item on your inventory')
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

makeListInventory(String_Name_List, CountList) :-
    findall(String_Name, myInventory(_,_, String_Name,_,_,_,_,_,_), String_Name_List),
    findall(Count, myInventory(_,_,_,_,_,_,_,_,Count), CountList).

writeInventory([], []).
writeInventory([A|V], [B|W]) :-
        write(B), write(' '), write(A), nl,
        writeInventory(V,W).



    
inventory :-
    cekJumlahInventory(X),
    write('Your Inventory ('), write(X), write('/100)'), nl,nl,
    makeListInventory(String_Name_List, CountList),
    writeInventory(String_Name_List, CountList).
