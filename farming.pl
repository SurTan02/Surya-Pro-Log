:- include('player.pl').
:- include('inventory.pl').
:- include('peta.pl').

:- dynamic(valCarrotSeed/1). %how many carrot seeds
:- dynamic(valPotatoSeed/1).
:- dynamic(valCornSeed/1).
:- dynamic(valTomatoSeed/1).
:- dynamic(valPumpkinSeed/1).

:- dynamic(valCarrot/1). %how many carrot plants
:- dynamic(valPotato/1).
:- dynamic(valCorn/1).
:- dynamic(valTomato/1).
:- dynamic(valPumpkin/1).

:- dynamic(carrot/2). %nyimpen perlu berapa energi lagi buat produce (energyleft, ID)
:- dynamic(corn/2).
:- dynamic(potato/2).
:- dynamic(tomato/2).
:- dynamic(pumpkin/2).
:- dynamic(carrotID/1). %next id ke berapa ya ???
:- dynamic(cornID/1).
:- dynamic(potatoID/1).
:- dynamic(tomatoID/1).
:- dynamic(pumpkinID/1).

initFarming :-
    asserta(valCarrotSeed(0)),
    asserta(valCornSeed(0)),
    asserta(valPotatoSeed(0)),
    asserta(valTomatoSeed(0)),
    asserta(valPumpkinSeed(0)),

    asserta(valCarrot(0)),
    asserta(valCorn(0)),
    asserta(valPotato(0)),
    asserta(valTomato(0)),
    asserta(valPumpkin(0)),

    asserta(carrotID(1)),
    asserta(cornID(1)),
    asserta(potatoID(1)),
    asserta(tomatoID(1)),
    asserta(pumpkinID(1)).


updateFromInventory :-
    findall(InvID, myInventory(InvID,_,_,_,_,_,_,_,_), ListID),
    (
        isInInventory(10, ListID) -> myInventory(10, _, _, _, _, _, _, _, CarCount), asserta(valCarrotSeed(CarCount));
        retractall(valCarrotSeed(_)), asserta(valCarrotSeed(0))
    ),

    (
        isInInventory(11, ListID) -> myInventory(11, _, _, _, _, _, _, _, PotCount), asserta(valPotatoSeed(PotCount));
        retractall(valPotatoSeed(_)), asserta(valPotatoSeed(0))
    ),

    (
        isInInventory(12, ListID) -> myInventory(12, _, _, _, _, _, _, _, CorCount), asserta(valCornSeed(CorCount));
        retractall(valCornSeed(_)), asserta(valCornSeed(0))
    ),

    (
        isInInventory(13, ListID) -> myInventory(13, _, _, _, _, _, _, _, TomCount), asserta(valTomatoSeed(TomCount));
        retractall(valTomatoSeed(_)), asserta(valTomatoSeed(0))
    ),

    (
        isInInventory(14, ListID) -> myInventory(14, _, _, _, _, _, _, _, PumpkinCount), asserta(valPumpkinSeed(PumpkinCount));
        retractall(valPumpkinSeed(_)), asserta(valPumpkinSeed(0))
    ).

dig :-
    (
        \+diggedTile(X,Y) ->
            playerCoord(X,Y),
            assertz(diggedTile(X,Y)),
            YNOW is Y-1,
            retractall(playerCoord(_,_)),
            asserta(playerCoord(X,YNOW)),
            write('Tile Digged!'),nl,write('+50 Player EXP'),nl, write('+50 Farming EXP'),
            earnEXPFarming(50),
            earnEXPPlayer(50);

        write('Tile Already Digged')
    ).

plant :-
    updateFromInventory,
    (
        diggedTile(X,Y) ->
            write('You have:'),nl,
            valCarrotSeed(CurrCar),
            valCornSeed(CurrCor),
            valPotatoSeed(CurrPot),
            valTomatoSeed(CurrTom),
            valPumpkinSeed(CurrPump),
            write(CurrCar), write(' carrot seed'),
            write(CurrCor), write(' corn seed'),
            write(CurPot), write(' potato seed'),
            write(CurTom), write(' tomato seed'),
            write(CurPump), write(' pumpkin seed'),
            write('What do you want to plant?'),nl,
            read(Choice),
            (
                Choice = carrot -> 
                    (
                        CurrCar = 0 -> write('No carrot seed'),nl;

                        write('Carrot seed planted!'),nl,
                        write('+50 EXP Player'),nl,
                        write('+50 EXP Farming'),nl,
                        earnEXPPlayer(50),
                        earnEXPFarming(50),
                        deleteNItems(1,10),

                        valCarrot(A),
                        RES is A+1,
                        retractall(valCarrot(_)),
                        asserta(valCarrot(RES)),
                        carrotID(ID),
                        assertz(carrot(150,ID)),
                        NewID is ID + 1,
                        retractall(carrotID(_)),
                        asserta(carrotID(NewID))
                    );

                Choice = corn ->
                    (
                        CurrCor = 0 -> write('No corn seed'),nl;
                        
                        write('Corn seed planted!'),nl,
                        write('+50 EXP Player'),nl,
                        write('+50 EXP Farming'),nl,
                        earnEXPPlayer(50),
                        earnEXPFarming(50),
                        deleteNItems(1,12),

                        valCorn(A),
                        RES is A+1,
                        retractall(valCorn(_)),
                        asserta(valCorn(RES)),
                        cornID(ID),
                        assertz(corn(450,ID)),
                        NewID is ID + 1,
                        retractall(cornID(_)),
                        asserta(cornID(NewID))
                    );

                Choice = potato ->
                    (
                        CurrPot = 0 -> write('No potato seed'),nl;
                        
                        write('Potato seed planted!'),nl,
                        write('+50 EXP Player'),nl,
                        write('+50 EXP Farming'),nl,
                        earnEXPPlayer(50),
                        earnEXPFarming(50),
                        deleteNItems(1,11),

                        valPotato(A),
                        RES is A+1,
                        retractall(valPotato(_)),
                        asserta(valPotato(RES)),
                        potatoID(ID),
                        assertz(potato(175,ID)),
                        NewID is ID + 1,
                        retractall(potatoID(_)),
                        asserta(potatoID(NewID))
                    );

                Choice = tomato ->
                    (
                        CurrTom = 0 -> write('No tomato seed'),nl;
                        
                        findall(InvID, myInventory(InvID,_,_,_,_,_,_,_,_), ListID),
                        (
                            isInInventory(27,ListID) -> 
                                write('Tomato seed planted!'),nl,
                                write('+50 EXP Player'),nl,
                                write('+50 EXP Farming'),nl,
                                earnEXPPlayer(50),
                                earnEXPFarming(50),
                                deleteNItems(1,13),

                                valTomato(A),
                                RES is A+1,
                                retractall(valTomato(_)),
                                asserta(valTomato(RES)),
                                tomatoID(ID),
                                assertz(tomato(800,ID)),
                                NewID is ID + 1,
                                retractall(tomatoID(_)),
                                asserta(tomatoID(NewID));
                            
                            write('Shovel Level 2 Needed'),nl
                        )

                    );
                    
                Choice = pumpkin -> 
                    (
                        CurrPump = 0 -> write('No Pumpkin seed'),nl;
                        
                        findall(InvID, myInventory(InvID,_,_,_,_,_,_,_,_), ListID),
                        (
                            isInInventory(28,ListID) -> 
                                write('Pumpkin seed planted!'),nl,
                                write('+50 EXP Player'),nl,
                                write('+50 EXP Farming'),nl,
                                earnEXPPlayer(50),
                                earnEXPFarming(50),
                                deleteNItems(1,14),

                                valPumpkin(A),
                                RES is A+1,
                                retractall(valPumpkin(_)),
                                asserta(valPumpkin(RES)),
                                pumpkinID(ID),
                                assertz(pumpkin(1000,ID)),
                                NewID is ID + 1,
                                retractall(pumpkinID(_)),
                                asserta(pumpkinID(NewID));
                            
                            write('Shovel Level 3 Needed'),nl
                        )

                    )
            );

        write('Tile Not Digged')
    ).

harvest :-
    valCarrot(VCar),
    valCorn(VCor),
    valPotato(VPot),
    valTomato(VTom),
    valPumpkinSeed(VPump),
    write('You have : '),nl,
    write(VCar), ' carrot plant',nl,
    write(VCor), ' corn plant',nl,
    write(VPot), ' potato plant',nl,
    write(VTom), ' tomato plant',nl,
    write(VPump), ' pumpkin plant',nl,

    write('Which plant do you want to harvest?'),!,nl,
    read(Choice),nl,!,
    (
     (Choice = carrot), getCarrotProduce;
     (Choice = potato), getPotatoProduce;
     (Choice = corn), getCornProduce;
     (Choice = tomato), getTomatoProduce;
     (Choice = pumpkin), getPumpkinProduce
    ).

getCarrotProduce :-
    valCarrot(A),
    (
    A = 0 -> write('Your carrot plant has not produce any carrot.'),nl,write('Please check again later.');
    
    write('Your carrot plant produced '), write(A), write(' carrots'),nl,write('You got '), write(A),write(' carrots!'),nl,
    write('You gain 50 Exp Farming'),nl,
    write('You gain 50 Exp Player'),    
    earnEXPFarming(50),
    earnEXPPlayer(50),
    addNtimes(A, 15)
    ),
    retractall(valCarrot(_)),
    asserta(valCarrot(0)).

getPotatoProduce :-
    valPotato(A),
    (
    A = 0 -> write('Your potato plant has not produce any potato.'),nl,write('Please check again later.');
    
    write('Your potato plant produced '), write(A), write(' potatos'),nl,write('You got '), write(A),write(' potatos!'),nl,
    write('You gain 50 Exp Farming'),nl,
    write('You gain 50 Exp Player'),    
    earnEXPFarming(50),
    earnEXPPlayer(50),
    addNtimes(A, 16)
    ),
    retractall(valPotato(_)),
    asserta(valPotato(0)).

getCornProduce :-
    valCorn(A),
    (
    A = 0 -> write('Your corn plant has not produce any corn.'),nl,write('Please check again later.');
    
    write('Your corn plant produced '), write(A), write(' corns'),nl,write('You got '), write(A),write(' corns!'),nl,
    write('You gain 50 Exp Farming'),nl,
    write('You gain 50 Exp Player'),    
    earnEXPFarming(50),
    earnEXPPlayer(50),
    addNtimes(A, 17)
    ),
    retractall(valCorn(_)),
    asserta(valCorn(0)).

getTomatoProduce :-
    valTomato(A),
    (
    A = 0 -> write('Your tomato plant has not produce any tomato.'),nl,write('Please check again later.');
    
    write('Your tomato plant produced '), write(A), write(' tomatos'),nl,write('You got '), write(A),write(' tomatos!'),nl,
    write('You gain 50 Exp Farming'),nl,
    write('You gain 50 Exp Player'),    
    earnEXPFarming(50),
    earnEXPPlayer(50),
    addNtimes(A, 18)
    ),
    retractall(valTomato(_)),
    asserta(valTomato(0)).

getPumpkinProduce :-
    valTomato(A),
    (
    A = 0 -> write('Your pumpkin plant has not produce any pumpkin.'),nl,write('Please check again later.');
    
    write('Your pumpkin plant produced '), write(A), write(' pumpkins'),nl,write('You got '), write(A),write(' pumpkins!'),nl,
    write('You gain 50 Exp Farming'),nl,
    write('You gain 50 Exp Player'),    
    earnEXPFarming(50),
    earnEXPPlayer(50),
    addNtimes(A, 19)
    ),
    retractall(valPumpkin(_)),
    asserta(valPumpkin(0)).


%everytime energies are spent, call this to update
checkFarmProduce(X) :-
    findall(Energy, carrot(Energy,_), ListCarrotEnergy),
    findall(Energy, potato(Energy,_), ListPotatoEnergy),
    findall(Energy, corn(Energy,_), ListCornEnergy),
    findall(Energy, tomato(Energy,_), ListTomatoEnergy),
    findall(Energy, pumpkin(Energy,_), ListPumpkinEnergy),
    valCarrot(Car),
    valCorn(Cor),
    valPotato(Pot),
    valTomato(Tom),
    valPumpkin(Pump),
    (
        Car = 0 -> nl;
        checkCarrotProduction(ListCarrotEnergy,X,1)
    ),
    (
        Cor = 0 -> nl;
        checkCornProduction(ListCornEnergy,X,1)
    ),
    (
        Pot = 0 -> nl;
        checkPotatoProduction(ListPotatoEnergy,X,1)
    ),
    (
        Tom = 0 -> nl;
        checkTomatoProduction(ListTomatoEnergy,X,1)
    ),
    (
        Pump = 0 -> nl;
        checkPotatoProduction(ListPumpkinEnergy,X,1)
    ),
    


% increase produce every X spend energy
checkCarrotProduction([],X,0).
checkCarrotProduction([H],X,ID) :- carrotID(B), B is B-1, B = ID,
    Left is H-X,
    (
        (Left =< 0), valCarrot(Car), NewCar is Car + 1, retractall(valCarrot(_)), asserta(valCarrot(NewCar))
    ),
    retract(cow(_,ID)), EN is mod(Left,150), assertz(cow(EN,ID)).

checkCarrotProduction([H|T],X,ID) :-
    Left is H-X,
    (
        (Left =< 0), valCarrot(Car), NewCar is Car + 1, retractall(valCarrot(_)), asserta(valCarrot(NewCar))
    ),
    retract(carrot(_,ID)), EN is mod(Left,150), assertz(carrot(EN,ID)).
    NextID is ID+1,
    checkCarrotProduction(T,X,NextID).

checkCornProduction([],X,0).
checkCornProduction([H],X,ID) :- cornID(B), B is B-1, B = ID,
    Left is H-X,
    (
        (Left =< 0), valCorn(Corn), NewCorn is Corn + 1, retractall(valCorn(_)), asserta(valCorn(NewCorn))
    ),
    retract(corn(_,ID)), EN is mod(Left,450), assertz(corn(EN,ID)).

checkCornProduction([H|T],X,ID) :-
    Left is H-X,
    (
        (Left =< 0), valCorn(Corn), NewCorn is Corn + 1, retractall(valCorn(_)), asserta(valCorn(NewCorn))
    ),
    retract(corn(_,ID)), EN is mod(Left,450), assertz(corn(EN,ID)).
    NextID is ID+1,
    checkCornProduction(T,X,NextID).

checkPotatoProduction([],X,0).
checkPotatoProduction([H],X,ID) :- potatoID(B), B is B-1, B = ID,
    Left is H-X,
    (
        (Left =< 0), valPotato(Pot), NewPot is Pot + 1, retractall(valPotato(_)), asserta(valPotato(NewPot))
    ),
    retract(potato(_,ID)), EN is mod(Left,175), assertz(potato(EN,ID)).

checkPotatoProduction([H|T],X,ID) :-
    Left is H-X,
    (
        (Left =< 0), valPotato(Potato), NewPotato is Potato + 1, retractall(valPotato(_)), asserta(valPotato(NewPotato))
    ),
    retract(potato(_,ID)), EN is mod(Left,175), assertz(potato(EN,ID)).
    NextID is ID+1,
    checkPotatoProduction(T,X,NextID).

checkTomatoProduction([],X,0).
checkTomatoProduction([H],X,ID) :- tomatoID(B), B is B-1, B = ID,
    Left is H-X,
    (
        (Left =< 0), valTomato(Tomato), NewTomato is Tomato + 1, retractall(valTomato(_)), asserta(valTomato(NewTomato))
    ),
    retract(tomato(_,ID)), EN is mod(Left,800), assertz(tomato(EN,ID)).

checkTomatoProduction([H|T],X,ID) :-
    Left is H-X,
    (
        (Left =< 0), valTomato(Tomato), NewTomato is Tomato + 1, retractall(valTomato(_)), asserta(valTomato(NewTomato))
    ),
    retract(tomato(_,ID)), EN is mod(Left,800), assertz(tomato(EN,ID)).
    NextID is ID+1,
    checkTomatoProduction(T,X,NextID).

checkPumpkinProduction([],X,0).
checkPumpkinProduction([H],X,ID) :- pumpkinID(B), B is B-1, B = ID,
    Left is H-X,
    (
        (Left =< 0), valPumpkin(Pumpkin), NewPumpkin is Pumpkin + 1, retractall(valPumpkin(_)), asserta(valPumpkin(NewPumpkin))
    ),
    retract(pumpkin(_,ID)), EN is mod(Left,1000), assertz(pumpkin(EN,ID)).

checkPumpkinProduction([H|T],X,ID) :-
    Left is H-X,
    (
        (Left =< 0), valPumpkin(Pumpkin), NewPumpkin is Pumpkin + 1, retractall(valPumpkin(_)), asserta(valPumpkin(NewPumpkin))
    ),
    retract(pumpkin(_,ID)), EN is mod(Left,1000), assertz(pumpkin(EN,ID)).
    NextID is ID+1,
    checkPumpkinProduction(T,X,NextID).