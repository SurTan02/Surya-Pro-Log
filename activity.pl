checkEnergy(X,_):-
    energy(Eawal),
    Eakhir is Eawal - X,
    Eakhir >= 0,!.

checkEnergy(X,Y):-
    energy(Eawal),
    Eakhir is Eawal - X,
    Eakhir < 0,
    Y = 1, write('Energi Anda tidak cukup untuk beraktivitas'),nl,
    fail,!. 

spendEnergy(X) :-
    energy(Eawal),
    Eakhir is Eawal - X,
    retractall(energy(_)),
    asserta(energy(Eakhir)),
    format('Energi Anda Menjadi ~w',[Eakhir]), nl.

    
% _X adalah Bilangan Random untuk menentukan ikan yang didapatkan
% luck adalah Luck dari pemain, semakin tinggi maka kesempatan mendapat ikan semakin baik.
% Kasus mendapatkan Ikan Grade Terbaik (Betutu Fish). 
mancing :- 
    checkEnergy(8,1),
    random(0,1000,_X),
    luck(Y),
    %fishingrod_1
    % Z is Y + fishingrod_1
    _X < Y*15, !,
    write('Anda berhasil mendapatkan ikan kualtias Terbaik'),nl,
    % AddInventory (Ikan Betutu),
    spendEnergy(8),
    earnEXPPlayer(20),
    
    % Level Specialty dibatasi 10
    levelFishing(LVLfish),
    LVLfish <10, !,
    earnEXPFishing(20).

% Kasus mendapatkan Ikan Grade Menengah (Gurame Fish). 
mancing :-
    checkEnergy(8,0),

    random(0,1000,_X),
    luck(Y),

    _X < Y*30, !,
    write('Anda berhasil mendapatkan ikan kualtias Menengah'),nl,
    % AddInventory (Ikan Gurame),
    spendEnergy(8),
    earnEXPPlayer(15),

    % Level Specialty dibatasi 10
    levelFishing(LVLfish),
    LVLfish <10, !,
    earnEXPFishing(15).

% Kasus mendapatkan Ikan Grade Rendah (Teri Fish). 
mancing :- 
    checkEnergy(8,0),

    random(0,1000,_X),
    luck(Y),
    _X < Y*60, !,
    write('Anda berhasil mendapatkan ikan kualtias Rendah'),nl,
    % AddInventory (Ikan Gurame),
    spendEnergy(8),  
    earnEXPPlayer(10),

    % Level Specialty dibatasi 10
    levelFishing(LVLfish),
    LVLfish <10, !,
    earnEXPFishing(10).

% Kasus Tidak dapat ikan. 
mancing :-
    checkEnergy(8,0),
    write('Anda tidak mendapatkan ikan sama sekali'),nl,
    spendEnergy(8),
    earnEXPPlayer(5),

    % Level Specialty dibatasi 10
    levelFishing(LVLfish),
    LVLfish <10, !,
    earnEXPFishing(10).


dig :-
    % playerCoord(CurrPos)
    % CurrPos = '=',!

    checkEnergy(8,1),
    spendEnergy(5),
    earnEXPPlayer(5),

    % Level Specialty dibatasi 10
    levelFarming(LVLfarm),
    LVLfarm <10, !,
    earnEXPFarming(5).


plant(X):-
    
        