:- dynamic(money/1).
:- dynamic(energy/1).
:- dynamic(luck/1).     
:- dynamic(money/1).
:- dynamic(waktu/1).
:- dynamic(playerLevel/1).
:- dynamic(fishermanLevel/1).
:- dynamic(rancherLevel/1).
:- dynamic(farmerLevel/1).



job(rancher).
job(fisherman).
job(farmer).

% mancing(X,Y):- 
%     random(0,Y,Z),
%     X is Z,
%     X < Y/10,
%     write(hoki), !.

% mancing(X,Y):- 
%     random(0,Y,Z),
%     
%     X >= Y/10,
%     write(gahoki).
mancing(X,Y):- 
    random(0,Y,Z),
    X is Z,
    (  X < Y/5 -> write(hoki-maksimal);
        X < Y/2 -> write(hoki-setengah);
        write(ga-hoki)).
