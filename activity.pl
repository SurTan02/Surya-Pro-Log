mancing(X,Y):- 
    random(0,Y,Z),
    X is Z,
    (  X < Y/10 -> write('Anda berhasil mendapatkan ikan kualtias Terbaik');
        X < Y/5 -> write('Anda berhasil mendapatkan ikan kualtias Menengah');
        X < Y/2 -> write('Anda berhasil mendapatkan ikan kualtias Rendah');
        write('Anda tidak mendapatkan ikan sama sekali')).