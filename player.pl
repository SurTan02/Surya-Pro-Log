:- dynamic(money/1).
:- dynamic(energy/1).
:- dynamic(maxEnergy/1).
:- dynamic(luck/1).     
:- dynamic(hasilPanen/1).     
:- dynamic(ranchCapacity/1).     
:- dynamic(waktu/1).
:- dynamic(jobPlayer/1).
:- dynamic(levelPlayer/1).
:- dynamic(expPlayer/1).
:- dynamic(levelFishing/1).
:- dynamic(expFishing/1).
:- dynamic(levelRanching/1).
:- dynamic(expRanching/1).
:- dynamic(levelFarming/1).
:- dynamic(expFarming/1).


job(rancher).
job(fisherman).
job(farmer).

% # baseExp = 100.
% # baseEnergy = 100.
% # expForLevelUp = 100.

reset :-
    retractall(money(_)),
    retractall(energy(_)),
    retractall(maxEnergy(_)),
    retractall(luck(_)),
    retractall(hasilPanen(_)),
    retractall(ranchCapacity(_)),
    retractall(waktu(_)),
    retractall(jobPlayer(_)),
    retractall(levelPlayer(_)),
    retractall(expPlayer(_)),
    retractall(levelFishing(_)),
    retractall(expFishing(_)),
    retractall(levelRanching(_)),
    retractall(expRanching(_)),
    retractall(levelFarming(_)),
    retractall(expFarming(_)).
  
pilihJob(_) :- jobPlayer(_), !.
pilihJob(Job) :- setStat(Job), firstLevel.



firstLevel :-
    energy(E),
    maxEnergy(MaxE),
    maxEnergy(MaxE),
    baseExp(BExp),
    asserta(money(100)),
    asserta(energy(E)),
    asserta(hasilPanen(1)),
    asserta(hasilPanen(1)),
    asserta(levelPlayer(1)),
    asserta(expPlayer(0)),
    asserta(levelFishing(1)),
    asserta(expFishing(0)),
    asserta(levelRanching(1)),
    asserta(expRanching(0)),
    asserta(levelFarming(1)),
    asserta(expFarming(0)).

setStat(fisherman) :-
    asserta(jobPlayer(fisherman)),
    asserta(luck(150)).
  

setStat(rancher) :-
    asserta(jobPlayer(archer)),
    asserta(luck(200)).

setStat(farmer) :-
    asserta(jobPlayer(sorcerer)),
    asserta(luck(200)).

earnMoney(X):-
    money(Before),
    retractall(money(_)),
    After is Before + X,
    asserta(gold(After)).

% exp untuk level up 150
earnEXPPlayer(X):-
    expPlayer(XP),
    NewXP is XP + X,
    (NewXP >= 150 -> sisa is NewXP-150, naikLevelPlayer(sisa);
    retractall(expPlayer(_)), asserta(expPlayer(NewXP))).

earnEXPFishing(X):-
    expFishing(XP),
    NewXP is XP + X,
    earnEXPPlayer(NewXP),
    (NewXP >= 150 -> sisa is NewXP-150, naikLevelFishing(sisa);
    retractall(expFishing(_)), asserta(expFishing(NewXP))).

earnEXPRanching(X):-
    expRanching(XP),
    NewXP is XP + X,
    earnEXPPlayer(NewXP),
    (NewXP >= 150 -> sisa is NewXP-150, naikLevelRanching(sisa);
    retractall(expRanching(_)), asserta(expRanching(NewXP))).

earnEXPFarming(X):-
    expFarming(XP),
    NewXP is XP + X,
    earnEXPPlayer(NewXP),
    (NewXP >= 150 -> sisa is NewXP-150, naikLevelFarming(sisa);
    retractall(expFarming(_)), asserta(expFarming(NewXP))).


naikLevelPlayer(X) :-
    level(CurLvl),
    maxEnergy(CurrEnergy),

    retractall(expPlayer(_)),
    retractall(levelPlayer(_)),
    retractall(maxEnergy(_)),

    NewLVL is CurLvl + 1,
    NewMaxEnergy is CurrEnergy*1.1,

    asserta(levelPlayer(NewLVL)),
    asserta(maxEnergy(NewMaxEnergy)),
    write('ANDA NAIK LEVEL'),
    (X > 150 -> X1 is X-150, earnEXPPlayer(X1)).

    
naikLevelFishing(X) :-
    level(CurLvl),
    luck(CurLuck),

    retractall(expFishing(_)),
    retractall(levelFishing(_)),
    retractall(luck(_)),

    NewLVL is CurLvl + 1,
    NewLuck is CurLuck*0.8,

    asserta(levelFishing(NewLVL)),
    asserta(luck(NewLuck)),
    write('ANDA NAIK LEVEL'),
    (X > 150 -> X1 is X-150, earnEXPFishing(X1)).

naikLevelRanching(X) :-
    level(CurLvl),
    ranchCapacity(CurCap),

    retractall(expRanching(_)),
    retractall(levelRanching(_)),
    retractall(ranchCapacity(_)),

    NewLVL is CurLvl + 1,
    NewCap is CurCap + 1,

    asserta(levelRanching(NewLVL)),
    asserta(ranchCapacity(NewCap)),
    write('ANDA NAIK LEVEL'),
    (X > 150 -> X1 is X-150, earnEXPRanching(X1)).

naikLevelFarming(X) :-
    level(CurLvl),
    hasilPanen(CurPanen),

    retractall(expFarming(_)),
    retractall(levelFarming(_)),
    retractall(hasilPanen(_)),

    NewLVL is CurLvl + 1,
    NewPanen is CurPanen + 1,

    asserta(levelFarming(NewLVL)),
    asserta(hasilPanen(NewPanen)),
    write('ANDA NAIK LEVEL'),
    (X > 150 -> X1 is X-150, earnEXPFarming(X1)).