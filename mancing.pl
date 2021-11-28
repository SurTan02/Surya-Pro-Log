checkEnergy(X,_):-
    energy(Eawal),
    Eakhir is Eawal - X,
    Eakhir >= 0,!.

checkEnergy(X,Y):-
    energy(Eawal),
    Eakhir is Eawal - X,
    Eakhir < 0,
    Y = 1, write('You don\'t have enough energy to do this task!'),nl,
    fail,!. 

spendEnergy(X) :-
    energy(Eawal),
    Eakhir is Eawal - X,
    retractall(energy(_)),
    asserta(energy(Eakhir)),
    checkRanchProduce(X),
    % format('Your energy ~w',[Eakhir]), nl,
    (Eakhir =< 0 -> write('You have run out of energy and magically sleep in your house'), forceSleep;!).

    
% _X adalah Bilangan Random untuk menentukan ikan yang didapatkan
% luck adalah Luck dari pemain, semakin tinggi maka kesempatan mendapat ikan semakin baik.

fish :-
    % trace,
    playerCoord(X,_),
    \+waterTile(X-1,_),
    write('Go to Water Tile (o) to access this command!'),nl,!,
    menuInGame.

% Kasus mendapatkan Ikan Grade Terbaik (Betutu Fish). 
fish :- 
    checkEnergy(8,1),
    random(0,1000,_X),
    luck(Z),
    (
        insideMyInventory('level 3 fishing rod'), LVLROD is 3;
        insideMyInventory('level 2 fishing rod'),LVLROD is 2;
        insideMyInventory('level 1 fishing rod'),LVLROD is 1
    ),
    Y is LVLROD + Z,
    _X < Y*15, !,
    write('You got Betutu Fish!'),nl,
    addToInventory(20),

    spendEnergy(8),
    earnEXPPlayer(20),

    % Level Specialty dibatasi 10
    levelFishing(LVLfish),
    LVLfish <10, !,
    earnEXPFishing(20).

% Kasus mendapatkan Ikan Grade Menengah (Gurame Fish). 
fish :-
    checkEnergy(8,0),
    random(0,1000,_X),
    luck(Z),
    (
        insideMyInventory('level 3 fishing rod'), LVLROD is 3;
        insideMyInventory('level 2 fishing rod'),LVLROD is 2;
        insideMyInventory('level 1 fishing rod'),LVLROD is 1
    ),
    Y is LVLROD + Z,

    _X < Y*30, !,
    write('You got Gurame Fish!'),nl,
    addToInventory(21),

    spendEnergy(8),
    earnEXPPlayer(15),

    % Level Specialty dibatasi 10
    levelFishing(LVLfish),
    LVLfish <10, !,
    earnEXPFishing(15).

% Kasus mendapatkan Ikan Grade Rendah (Teri Fish). 
fish :- 
    checkEnergy(8,0),
    random(0,1000,_X),
    luck(Z),
    (
        insideMyInventory('level 3 fishing rod'), LVLROD is 3;
        insideMyInventory('level 2 fishing rod'),LVLROD is 2;
        insideMyInventory('level 1 fishing rod'),LVLROD is 1
    ),
    
    Y is LVLROD + Z,

    _X < Y*60, !,
    write('You got Teri Fish!'),nl,
    addToInventory(22),

    spendEnergy(8),  
    earnEXPPlayer(10),

    % Level Specialty dibatasi 10
    levelFishing(LVLfish),
    LVLfish <10, !,
    earnEXPFishing(10).

% Kasus Tidak dapat ikan. 
fish :-
    checkEnergy(8,0),
    write('You didn\'t get anything!'),nl,
    spendEnergy(8),
    earnEXPPlayer(5),

    % Level Specialty dibatasi 10
    levelFishing(LVLfish),
    LVLfish <10, !,
    earnEXPFishing(5).

    
        