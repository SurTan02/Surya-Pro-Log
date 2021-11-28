% boolean apakah player didalam store
:- dynamic(isInMarket/1).

% % FOR DEBUGGING PURPOSES
% myInventory(30, fishingrod, 'level 2 fishing rod', equipment, 2, 0, 0, 100, 1).
% myInventory(10, carrot_seed, 'carrot seed', commodity, 1, 350, 0, 5, 10).
% myInventory(11, potato_seed, 'potato seed', commodity, 1, 375, 0, 7, 2).

% playerCoord(2,2).
% marketCoord(2,2).

% kondisi player diluar berada bukan pada tile market
market :-
    playerCoord(X,Y),
    \+marketCoord(X,Y),
    write('Go to Market (M) to access this command!'),nl,
    !,fail.

market :-
    asserta(isInMarket(1)), repeat,
    write('Welcome to the Market Claire!'), nl,
    write('What do you want to do?'), nl,
    write('1. Buy'), nl,
    write('2. Sell'), nl,
    write('3. Exit'), nl,
    read(X), nl,
    ((X < 1 ; X > 3) -> 
        write('Invalid input! choose 1 or 2'), nl, fail
    ; (X =:= 1) ->
        write('What do you want to buy?'), nl,
        write('1. carrot seed (5 gold)'), nl,
        write('2. potato seed (7 gold)'), nl,
        write('3. corn seed (12 gold) *need lvl 2 shovel to plant'), nl,
        write('4. pumpkin seed (15 gold) *need lvl 3 shovel to plant'), nl,
        write('5. chicken (500 gold)'), nl,
        write('6. cow (2000 gold)'), nl,
        write('7. sheep (1200 gold)'), nl, nl,
        write('**EQUIPMENTS**'), nl,
        writeShovel,
        writeRod,
        writeBoat,
        writeSpecial,
        write('Write the name of the item that you want to buy'), nl,
        write('example: \'carrot seed\', to buy carrot seed. '), nl,
        read(ItemName), nl,
        write('How much did you want to buy?'), nl,
        read(AmountItem), nl, 
        buy(ItemName, AmountItem), nl,!, fail
    ; (X =:= 2) -> 
        inventory, nl,
        write('Write the name of the item that you want to buy'), nl,
        write('example: \'carrot seed\', to sell carrot seed. '), nl,
        read(StringName),
        findall(InvStrName, myInventory(_,_, InvStrName,_,_,_,_,_,_), String_Name_List),
        (
            isInInventory(StringName, String_Name_List) ->
            write('How much of that item you want to sell?'), nl,
            read(N),
            sell(StringName, N), nl, fail
        
        ;   write('You don\'t have that item in your inventory'), nl, fail
        )
    ;  write('Terimakasih sudah mengunjungi Store! :D'),nl,
        retract(isInMarket(_)),!
    ).

writeSpecial :-
    day(Day), 
    (
        (Day =:= 69 ; Day =:= 190) ->
        write('**SPECIAL ITEM**'), nl,
        write('- specialtiesPotion (instant Job levelup when consumed!)'), nl
        ; !
    ).

writeShovel :-
    findall(InvID, myInventory(InvID,_, _,_,_,_,_,_,_), ListID),
    isInInventory(28, ListID),
    write('- Shovel at MAX Level!'), nl.
writeShovel :-
    findall(InvID, myInventory(InvID,_, _,_,_,_,_,_,_), ListID),
    isInInventory(27, ListID),
    write('- Level 3 shovel (150 Golds)'), nl.
writeShovel :-
    findall(InvID, myInventory(InvID,_, _,_,_,_,_,_,_), ListID),
    isInInventory(26, ListID),
    write('- Level 2 shovel (100 Golds)'), nl.
writeShovel :-
    findall(InvID, myInventory(InvID,_, _,_,_,_,_,_,_), ListID),
    \+isInInventory(26, ListID),
    write('- Level 1 shovel (50 Golds)'), nl.


writeRod :-
    findall(InvID, myInventory(InvID,_, _,_,_,_,_,_,_), ListID),
    isInInventory(31, ListID),
    write('- Fishing Rod is at MAX Level'), nl.
writeRod :-
    findall(InvID, myInventory(InvID,_, _,_,_,_,_,_,_), ListID),
    isInInventory(30, ListID),
    write('- Level 3 fishing rod (150 Golds)'), nl.
writeRod :-
    findall(InvID, myInventory(InvID,_, _,_,_,_,_,_,_), ListID),
    isInInventory(29, ListID),
    write('- Level 2 fishing rod (100 Golds)'), nl.
writeRod :-
    findall(InvID, myInventory(InvID,_, _,_,_,_,_,_,_), ListID),
    \+isInInventory(29, ListID),
    write('- Level 1 fishing rod (50 Golds)'), nl.







writeBoat :-
    findall(InvID, myInventory(InvID,_, _,_,_,_,_,_,_), ListID),
    isInInventory(34, ListID),
    write('- Boat is at MAX Level'), nl.
writeBoat :-
    findall(InvID, myInventory(InvID,_, _,_,_,_,_,_,_), ListID),
    isInInventory(33, ListID),
    write('- Level 3 boat (300 Golds)'), nl.
writeBoat :-
    findall(InvID, myInventory(InvID,_, _,_,_,_,_,_,_), ListID),
    isInInventory(32, ListID),
    write('- Level 2 boat (300 Golds)'), nl.
writeBoat :-
    findall(InvID, myInventory(InvID,_, _,_,_,_,_,_,_), ListID),
    \+isInInventory(32, ListID),
    write('- Level 1 boat (200 Golds)'), nl.




buy(_,_) :-
    \+isInMarket(_),
    write('Illegal command!'),nl,
    write('Go to the nearest store to buy items.'),nl,!,fail.

buy(StringName,N) :-
    isInMarket(_),
    money(Money),
    item(_, _, StringName,_,_,_,_, Price),
    TotalPrice is Price * N,
    Money < TotalPrice,
    write('Insufficient fund!'), nl,
    write('Ganbatte!'),nl,nl,nl,!,fail.

buy(_,N) :-
    isInMarket(_),
    cekJumlahInventory(X),
    AddEl is X + N,
    AddEl > 100,
    write('Your inventory is full!'),nl,
    write('sell your item to make more space!'),nl,!,fail.

buy(StringName, N) :-
    isInMarket(_),
    item(ID,_,StringName,_,_,_,_,Price),
    (
        (ID == 1) ->
        incCow(N)
    ;   (ID == 2) ->
        incChicken(N)
    ;   (ID == 3) ->
        incSheep(N)
    ;   addNtimes(N, ID)
    ),
    TotalPrice is Price * N, 
    money(Money),
    NowMoney is Money-TotalPrice,
    write(StringName), write(' succesfully purchased'), nl, write(N), write('x '),
    write(StringName), write(' is succesfully added to your inventory'),nl,
    write('Current Money: '), write(NowMoney), write(' gold.'),
    retract(money(Money)),
    asserta(money(NowMoney)),
    nl,!.

sell(_,_) :-
    \+isInMarket(_),
    write('Invalid Command!'),nl,
    write('Go to the nearest marketplace (M) to sell item!'),nl,!,fail.

sell(StringName,_) :-
    isInMarket(_),
    myInventory(ID,_, StringName,_,_,_,_,_,_),
    findall(InvID, myInventory(InvID,_, StringName,_,_,_,_,_,_), ListID),
    \+isInInventory(ID, ListID),
    write('You dont have that item in your inventory!'), nl,
    !, fail.

sell(StringName, N) :-
    isInMarket(_),
    myInventory(ID,_, StringName,_,_,_,_,Price,_),

    deleteNItems(N,ID),
    % money(Money),
    TotalPrice is N*Price,
    % NowMoney is Money + TotalPrice,
    write('You sold '), write(N), write(' '), write(StringName), nl,
    earnMoney(TotalPrice),
    nl,!.