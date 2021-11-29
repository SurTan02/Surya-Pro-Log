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

:- dynamic(valCar/1). %how many carrot
:- dynamic(valPot/1).
:- dynamic(valCor/1).
:- dynamic(valTom/1).
:- dynamic(valPump/1).


:- dynamic(carrotEN/1).
:- dynamic(cornEN/1).
:- dynamic(potatoEN/1).
:- dynamic(tomatoEN/1).
:- dynamic(pumpkinEN/1).

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
    
    asserta(carrotEN(150)),
    asserta(cornEN(450)),
    asserta(potatoEN(175)),
    asserta(tomatoEN(800)),
    asserta(pumpkinEN(1000)),

    asserta(valCar(0)),
    asserta(valCor(0)),
    asserta(valPot(0)),
    asserta(valTom(0)),
    asserta(valPump(0)).


updateFromInventory :-
    findall(InvID, myInventory(InvID,_,_,_,_,_,_,_,_), ListID),
    (
        isInInventory(10, ListID) -> myInventory(10,carrot_seed,_,_,_,_,_,_, CarCount),retractall(valCarrotSeed(_)), asserta(valCarrotSeed(CarCount));
        retractall(valCarrotSeed(_)), asserta(valCarrotSeed(0))
    ),

    (
        isInInventory(11, ListID) -> myInventory(11,potato_seed,_,_,_,_,_,_, PotCount),retractall(valPotatoSeed(_)), asserta(valPotatoSeed(PotCount));
        retractall(valPotatoSeed(_)), asserta(valPotatoSeed(0))
    ),

    (
        isInInventory(12, ListID) -> myInventory(12,corn_seed,_,_,_,_,_,_, CorCount),retractall(valCornSeed(_)),asserta(valCornSeed(CorCount));
        retractall(valCornSeed(_)), asserta(valCornSeed(0))
    ),

    (
        isInInventory(13, ListID) -> myInventory(13,tomato_seed,_,_,_,_,_,_, TomCount), retractall(valTomatoSeed(_)), asserta(valTomatoSeed(TomCount));
        retractall(valTomatoSeed(_)), asserta(valTomatoSeed(0))
    ),

    (
        isInInventory(14, ListID) -> myInventory(14,pumpkin_seed,_,_,_,_,_,_, PumpkinCount), asserta(valPumpkinSeed(PumpkinCount));
        retractall(valPumpkinSeed(_)), asserta(valPumpkinSeed(0))
    ).

dig :-
    checkEnergy(10,1),
    playerCoord(X,Y),
    (
        \+diggedTile(X,Y) ->
            playerCoord(X,Y),
            assertz(diggedTile(X,Y)),
            YNOW is Y-1,
            retractall(playerCoord(_,_)),
            asserta(playerCoord(X,YNOW)),
            write('Tile Digged!'),nl,write('+50 Player EXP'),nl,
            
            earnEXPPlayer(50),
            spendEnergy(10),

            levelFarming(LVLfarm),
            LVLfarm <10, !,
            write('You gained 50 Farming exp'),nl,
            earnEXPFarming(50);


        write('Tile Already Digged')
    ).

plant :-
    checkEnergy(10,1),
    updateFromInventory,
    playerCoord(X,Y),
    (
        diggedTile(X,Y) ->
            write('You have:'),nl,
            valCarrotSeed(CurrCar),
            valCornSeed(CurrCor),
            valPotatoSeed(CurrPot),
            valTomatoSeed(CurrTom),
            valPumpkinSeed(CurrPump),
            write(CurrCar), write(' carrot seed'),nl,
            write(CurrPot), write(' potato seed'),nl,
            write(CurrCor), write(' corn seed'),nl,
            write(CurrTom), write(' tomato seed'),nl,
            write(CurrPump), write(' pumpkin seed'),nl,
            write('What do you want to plant?'),nl,
            read(Choice),
            (
                Choice = carrot -> 
                    (
                        CurrCar = 0 -> write('No carrot seed'),nl;

                        write('Carrot seed planted!'),nl,
                        write('+50 EXP Player'),nl,
                        earnEXPPlayer(50),
                        deleteNItems(1,10),
                        spendEnergy(10),

                        valCarrot(A),
                        RES is A+1,
                        retractall(valCarrot(_)),
                        asserta(valCarrot(RES)),


                        levelFarming(LVLfarm),
                        LVLfarm <10, !,
                        write('You gained 50 Farming exp'),nl,
                        earnEXPFarming(50)
                    );

                Choice = corn ->
                    (
                        CurrCor = 0 -> write('No corn seed'),nl;
                        
                        write('Corn seed planted!'),nl,
                        write('+50 EXP Player'),nl,
                        earnEXPPlayer(50),
                        deleteNItems(1,12),
                        spendEnergy(10),

                        valCorn(A),
                        RES is A+1,
                        retractall(valCorn(_)),
                        asserta(valCorn(RES)),
                        
                        levelFarming(LVLfarm),
                        LVLfarm <10, !,
                        write('You gained 50 Farming exp'),nl,
                        earnEXPFarming(50)
                    );

                Choice = potato ->
                    (
                        CurrPot = 0 -> write('No potato seed'),nl;
                        
                        write('Potato seed planted!'),nl,
                        write('+50 EXP Player'),nl,
                        earnEXPPlayer(50),
                        deleteNItems(1,11),
                        spendEnergy(10),

                        valPotato(A),
                        RES is A+1,
                        retractall(valPotato(_)),
                        asserta(valPotato(RES)),

                        levelFarming(LVLfarm),
                        LVLfarm <10, !,
                        write('You gained 50 Farming exp'),nl,
                        earnEXPFarming(50)
                    );

                Choice = tomato ->
                    (
                        CurrTom = 0 -> write('No tomato seed'),nl;
                        
                        findall(InvID, myInventory(InvID,_,_,_,_,_,_,_,_), ListID),
                        (
                            isInInventory(27,ListID) -> 
                                write('Tomato seed planted!'),nl,
                                write('+50 EXP Player'),nl,
                                earnEXPPlayer(50),
                                deleteNItems(1,13),
                                spendEnergy(10),

                                valTomato(A),
                                RES is A+1,
                                retractall(valTomato(_)),
                                asserta(valTomato(RES)),
                                
                                levelFarming(LVLfarm),
                                LVLfarm <10, !,
                                write('You gained 50 Farming exp'),nl,
                                earnEXPFarming(50);
                                
                            
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
                                earnEXPPlayer(50),
                                deleteNItems(1,14),
                                spendEnergy(10),

                                valPumpkin(A),
                                RES is A+1,
                                retractall(valPumpkin(_)),
                                asserta(valPumpkin(RES)),
                                
                                levelFarming(LVLfarm),
                                LVLfarm <10, !,
                                write('You gained 50 Farming exp'),nl,
                                earnEXPFarming(50);
                                
                            
                            write('Shovel Level 3 Needed'),nl
                        )

                    )
            );

        write('Tile Not Digged')
    ).

harvest :-
    playerCoord(X,Y),
    (   diggedTile(X,Y) ->
            valCarrot(VCar),
            valCorn(VCor),
            valPotato(VPot),
            valTomato(VTom),
            valPumpkin(VPump),
            write('You have : '),nl,
            write(VCar), write(' carrot plant'),nl,
            write(VPot),write(' potato plant'),nl,
            write(VCor),write(' corn plant'),nl,
            write(VTom), write(' tomato plant'),nl,
            write(VPump), write(' pumpkin plant'),nl,
        
            write('Which plant do you want to harvest?'),!,nl,
            read(Choice),nl,!,
            (
            (Choice = carrot), getCarrotProduce;
            (Choice = potato), getPotatoProduce;
            (Choice = corn), getCornProduce;
            (Choice = tomato), getTomatoProduce;
            (Choice = pumpkin), getPumpkinProduce
            );
        
        write('Player must be in digged tile!')
    ).


getCarrotProduce :-
    valCar(A),
    (
    A = 0 -> write('Your carrot plant has not produce any carrot.'),nl,write('Please check again later.');
    
    write('Your carrot plant produced '), write(A), write(' carrots'),nl,write('You got '), write(A),write(' carrots!'),nl,
    write('You gain 50 Exp Player'),    
    earnEXPPlayer(50),
    addNtimes(A, 15)
    ),
    retractall(valCar(_)),
    asserta(valCar(0)),


    levelFarming(LVLfarm),
    LVLfarm <10, !,
    write('You gained 50 Farming exp'),nl,
    earnEXPFarming(50).

getPotatoProduce :-
    valPot(A),
    (
    A = 0 -> write('Your potato plant has not produce any potato.'),nl,write('Please check again later.');
    
    write('Your potato plant produced '), write(A), write(' potatos'),nl,write('You got '), write(A),write(' potatos!'),nl,
    write('You gain 50 Exp Player'),    
    earnEXPPlayer(50),
    addNtimes(A, 16)
    ),
    retractall(valPot(_)),
    asserta(valPot(0)),

    levelFarming(LVLfarm),
    LVLfarm <10, !,
    write('You gained 50 Farming exp'),nl,
    earnEXPFarming(50).

getCornProduce :-
    valCor(A),
    (
    A = 0 -> write('Your corn plant has not produce any corn.'),nl,write('Please check again later.');
    
    write('Your corn plant produced '), write(A), write(' corns'),nl,write('You got '), write(A),write(' corns!'),nl,
    write('You gain 50 Exp Player'),    
    earnEXPPlayer(50),
    addNtimes(A, 17)
    ),
    retractall(valCor(_)),
    asserta(valCor(0)),

    levelFarming(LVLfarm),
    LVLfarm <10, !,
    write('You gained 50 Farming exp'),nl,
    earnEXPFarming(50).

getTomatoProduce :-
    valTom(A),
    (
    A = 0 -> write('Your tomato plant has not produce any tomato.'),nl,write('Please check again later.');
    
    write('Your tomato plant produced '), write(A), write(' tomatos'),nl,write('You got '), write(A),write(' tomatos!'),nl,
    write('You gain 50 Exp Player'),    
    earnEXPPlayer(50),
    addNtimes(A, 18)
    ),
    retractall(valTom(_)),
    asserta(valTom(0)),

    levelFarming(LVLfarm),
    LVLfarm <10, !,
    write('You gained 50 Farming exp'),nl,
    earnEXPFarming(50).

getPumpkinProduce :-
    valPump(A),
    (
    A = 0 -> write('Your pumpkin plant has not produce any pumpkin.'),nl,write('Please check again later.');
    
    write('Your pumpkin plant produced '), write(A), write(' pumpkins'),nl,write('You got '), write(A),write(' pumpkins!'),nl,
    write('You gain 50 Exp Player'),    
    earnEXPPlayer(50),
    addNtimes(A, 19)
    ),
    retractall(valPump(_)),
    asserta(valPump(0)),

    levelFarming(LVLfarm),
    LVLfarm <10, !,
    write('You gained 50 Farming exp'),nl,
    earnEXPFarming(50).


%everytime energies are spent, call this to update
checkFarmProduce(X) :-
    valCarrot(Car),
    valCorn(Cor),
    valPotato(Pot),
    valTomato(Tom),
    valPumpkin(Pump),

    carrotEN(CarEN),
    cornEN(CorEN),
    potatoEN(PotEN),
    tomatoEN(TomEN),
    pumpkinEN(PumEN),
    (
        Car > 0 -> checkCarrotProduction(CarEN,X,1);
        !
    ),
    (
        Cor > 0 -> checkCornProduction(CorEN,X,1);
        !
    ),
    (
        Pot > 0 -> checkPotatoProduction(PotEN,X,1);
        !
    ),
    (
        Tom > 0 -> checkTomatoProduction(TomEN,X,1);
        !
    ),
    (
        Pump > 0 -> checkPotatoProduction(PumEN,X,1);
        !
    ).
    

incCarrot(X) :-
    valCar(A),
    valCarrot(B),
    RES is A+(X*B),
    retractall(valCar(_)),
    asserta(valCar(RES)).

incCorn(X) :-
    valCor(A),
    valCorn(B),
    RES is A+(X*B),
    retractall(valCor(_)),
    asserta(valCor(RES)).

incPotato(X) :-
    valPot(A),
    valPotato(B),
    RES is A+(X*B),
    retractall(valPot(_)),
    asserta(valPot(RES)).

incTomato(X) :-
    valTom(A),
    valTomato(B),
    RES is A+(X*B),
    retractall(valTom(_)),
    asserta(valTom(RES)).

incPumpkin(X) :-
    valPump(A),
    valPumpkin(B),
    RES is A+(X*B),
    retractall(valPump(_)),
    asserta(valPump(RES)).


% increase produce every X spend energy
checkCarrotProduction(H,X,_) :-
    Left is H-X,
    (
        Left = 0, EN is 150, incCarrot(1);
        Left < 0, EN is mod(Left,150),incCarrot(1);
        Left > 0, EN is mod(Left,150)
    ),
    retractall(carrotEN(_)), asserta(carrotEN(EN)).

checkCornProduction(H,X,_) :- 
    Left is H-X,
    (
        Left = 0, EN is 450, incCorn(1);
        Left < 0, EN is mod(Left,450),incCorn(1);
        Left > 0, EN is mod(Left,450)
    ),
    retractall(cornEN(_)), asserta(cornEN(EN)).

checkPotatoProduction(H,X,_) :- 
    Left is H-X,
    (
        Left = 0, EN is 175, incPotato(1);
        Left < 0, EN is mod(Left,175),incPotato(1);
        Left > 0, EN is mod(Left,175)
    ),
    retractall(potatoEN(_)), asserta(potatoEN(EN)).

checkTomatoProduction(H,X,_) :-
    Left is H-X,
    (
        Left = 0, EN is 800, incTomato(1);
        Left < 0, EN is mod(Left,800),incTomato(1);
        Left > 0, EN is mod(Left,800)
    ),
    retractall(tomatoEN(_)), asserta(tomatoEN(EN)).

checkPumpkinProduction(H,X,_) :-
    Left is H-X,
    (
        Left = 0, EN is 1000, incPumpkin(1);
        Left < 0, EN is mod(Left,1000),incPumpkin(1);
        Left > 0, EN is mod(Left,1000)
    ),
    retractall(pumpkinEN(_)), asserta(pumpkinEN(EN)).

