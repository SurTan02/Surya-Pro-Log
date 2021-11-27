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
    checkEnergy(5,1),

    random(0,1000,_X),
    luck(Y),
    %fishingrod_1
    _X < Y*15, !,
    write('Anda berhasil mendapatkan ikan kualtias Terbaik'),nl,
    % AddInventory (Ikan Betutu),
    spendEnergy(5),
    earnEXPFishing(20),
    earnEXPPlayer(20).

% Kasus mendapatkan Ikan Grade Menengah (Gurame Fish). 
mancing :-
    checkEnergy(5,0),

    random(0,1000,_X),
    luck(Y),
    _X < Y*30, !,
    write('Anda berhasil mendapatkan ikan kualtias Menengah'),nl,
    % AddInventory (Ikan Gurame),
    spendEnergy(5),
    earnEXPFishing(15),
    earnEXPPlayer(15).

% Kasus mendapatkan Ikan Grade Rendah (Teri Fish). 
mancing :- 
    checkEnergy(5,0),

    random(0,1000,_X),
    luck(Y),
    _X < Y*60, !,
    write('Anda berhasil mendapatkan ikan kualtias Rendah'),nl,
    % AddInventory (Ikan Gurame),
    spendEnergy(5),  
    earnEXPFishing(10),
    earnEXPPlayer(10).

% Kasus Tidak dapat ikan. 
mancing :-
    checkEnergy(5,0),

    write('Anda tidak mendapatkan ikan sama sekali'),nl,
    spendEnergy(5),
    earnEXPFishing(5),
    earnEXPPlayer(5).

% mancing:- 
%     energy(Eawal),
%     Eakhir is Eawal - 5,
%     (Eakhir >= 0,!, spendEnergy(Eakhir);
%     write('Energi Anda tidak cukup untuk beraktivitas'),nl,fail,!),
%     luck(Y),
%     random(0,Y,_X),
%     (  _X < Y*15 -> write('Anda berhasil mendapatkan ikan kualtias Terbaik');
%         _X < Y*30 -> write('Anda berhasil mendapatkan ikan kualtias Menengah');
%         _X < Y*100 -> write('Anda berhasil mendapatkan ikan kualtias Rendah');
%         write('Anda tidak mendapatkan ikan sama sekali')). 
    
        