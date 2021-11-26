
spendEnergy(_X,Eakhir) :-
    energy(Eawal),
    Eakhir is Eawal - _X,
    Eakhir >= 0,!, 
    retractall(energy(_)),
    asserta(energy(Eakhir)),
    format('Energi Anda Berkurang ~w',[_X]), nl.


spendEnergy(_X,Eakhir):-
    energy(Eawal),
    Eakhir is Eawal - _X,
    _Y = (Eakhir < 0),
    Eakhir < 0,
    write('Energi Anda tidak cukup untuk beraktivitas'),nl,
    fail,!. 
    






% _X adalah Bilangan Random untuk menentukan ikan yang didapatkan
% luck adalah Luck dari pemain, semakin tinggi maka kesempatan mendapat ikan semakin baik.
% Kasus mendapatkan Ikan Grade Terbaik (Betutu Fish). 
mancing :- 
    random(0,1000,_X),
    luck(Y),
    _X < Y*15, !,
    write('Anda berhasil mendapatkan ikan kualtias Terbaik'),nl,
    % AddInventory (Ikan Betutu),
    spendEnergy(5,_Y),
    earnEXPFishing(20),
    earnEXPPlayer(20).

% Kasus mendapatkan Ikan Grade Menengah (Gurame Fish). 
mancing :- 
    
    random(0,1000,_X),
    luck(Y),
    _X < Y*30, !,
    write('Anda berhasil mendapatkan ikan kualtias Menengah'),nl,
    % AddInventory (Ikan Gurame),
    spendEnergy(5,_Y),
    earnEXPFishing(15),
    earnEXPPlayer(15).

% Kasus mendapatkan Ikan Grade Rendah (Teri Fish). 
mancing :- 
   
    random(0,1000,_X),
    luck(Y),
    _X < Y*100, !,
    write('Anda berhasil mendapatkan ikan kualtias Rendah'),nl,
    % AddInventory (Ikan Gurame),
    spendEnergy(5,_Y),
    earnEXPFishing(10),
    earnEXPPlayer(10).

% Kasus Tidak dapat ikan. 
mancing :-
    spendEnergy(5,_Y), !,
    write('Anda tidak mendapatkan ikan sama sekali'),nl,
    earnEXPFishing(5),
    earnEXPPlayer(5).
    
        