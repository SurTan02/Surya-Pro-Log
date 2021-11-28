% :- include('activity.pl').
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

baseExp(100).
baseEnergy(100).
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
pilihJob(Job) :-
                setStat(Job),
                asserta(maxEnergy(16)),
                firstLevel,
                format('Anda memilih job sebagai ~w', [Job]),nl.



firstLevel :-
    maxEnergy(MaxE),
    % baseExp(BExp),
    asserta(money(100)),
    asserta(energy(MaxE)),
    asserta(hasilPanen(1)),
    asserta(ranchCapacity(1)),
    asserta(levelPlayer(1)),
    asserta(expPlayer(0)),
    asserta(levelFishing(1)),
    asserta(expFishing(0)),
    asserta(levelRanching(1)),
    asserta(expRanching(0)),
    asserta(levelFarming(1)),
    asserta(expFarming(0)),!.

setStat(fisherman) :-
    asserta(jobPlayer(fisherman)),
    asserta(luck(3)),!.
  

setStat(rancher) :-
    asserta(jobPlayer(archer)),
    asserta(luck(1)),!.

setStat(farmer) :-
    asserta(jobPlayer(sorcerer)),
    asserta(luck(1)),!.

earnMoney(X):-
    money(Before),
    retractall(money(_)),
    After is Before + X,
    asserta(money(After)),
    format('Anda mendapatkan uang sebanyak Rp.~w, Uang anda sekarang Rp.~w',[X,After]), nl.
    
spendMoney(X):-
    money(Before),
    retractall(money(_)),
    After is Before - X,
    asserta(money(After)),
    format('Anda menghabiskan uang sebanyak Rp.~w, Uang anda sekarang Rp.~w',[X,After]), nl.

gainEnergy(_) :-
    energy(Eawal),
    maxEnergy(MaxE),
    Eawal = MaxE,
    write('Energi Anda Masih Penuh!'),nl, !.

gainEnergy(X) :-
    energy(Eawal),
    maxEnergy(MaxE),
    (Eawal + X>= MaxE -> Eakhir is MaxE;
    Eakhir is Eawal + X),
    retractall(energy(_)),
    asserta(energy(Eakhir)),
    format('Energi Anda Menjadi ~w',[Eakhir]), nl.


% exp untuk level up adalah 100,200,300,400....
earnEXPPlayer(X):-
    expPlayer(XP),
    levelPlayer(CurrLvl),
    NewXP is XP + X,
    NewXP >= (100 * (CurrLvl)) ,!,
    Sisa is NewXP-(100 * (CurrLvl)),
    % write([CurrLvl,XP,X,NewXP,Sisa]),
    naikLevelPlayer(Sisa).
    
earnEXPPlayer(X):-
    expPlayer(XP),
    NewXP is XP + X,
    retractall(expPlayer(_)), 
    asserta(expPlayer(NewXP)).


earnEXPFishing(X):-
    expFishing(XP),
    levelFishing(CurrLvlF),
    NewXP is XP + X,
    NewXP >= (100 * (CurrLvlF)), !,
    Sisa is NewXP-(100 * (CurrLvlF)),
    naikLevelFishing(Sisa).
    

earnEXPFishing(X):-
    expFishing(XP),
    NewXP is XP + X,
    retractall(expFishing(_)), asserta(expFishing(NewXP)).

earnEXPRanching(X):-
    expRanching(XP),
    levelRanching(CurrLvlR),
    
    NewXP is XP + X,
    NewXP >= (100 * (CurrLvlR)), !,
    Sisa is NewXP-(100 * (CurrLvlR)),
    naikLevelRanching(Sisa).

earnEXPRanching(X):-
    expRanching(XP),
    NewXP is XP + X,
    retractall(expRanching(_)), asserta(expRanching(NewXP)).

earnEXPFarming(X):-
    expFarming(XP),
    levelFarming(CurrLvlFa),
    NewXP is XP + X,
    NewXP >= (100 * (CurrLvlFa)), !,
    Sisa is NewXP-(100 * (CurrLvlFa)),
    naikLevelFarming(Sisa).

earnEXPFarming(X):-
    expFarming(XP),
    NewXP is XP + X,
    retractall(expFarming(_)), asserta(expFarming(NewXP)).


naikLevelPlayer(X) :-
    % write(X),nl,
    levelPlayer(CurLvl),
    maxEnergy(CurrEnergy),
    % format('LVL awal ~w', [CurLvl]),nl,
    retractall(expPlayer(_)),
    retractall(levelPlayer(_)),
    retractall(maxEnergy(_)),

    NewLVL is CurLvl + 1,
    NewMaxEnergy is CurrEnergy+100,

    asserta(expPlayer(0)),
    asserta(levelPlayer(NewLVL)),
    asserta(maxEnergy(NewMaxEnergy)),
    format('Level Anda naik menjadi ~w!', [NewLVL]),nl,
    (earnEXPPlayer(X)).

    
naikLevelFishing(X) :-
    levelFishing(CurLvl),
    luck(CurLuck),

    retractall(expFishing(_)),
    retractall(levelFishing(_)),
    retractall(luck(_)),

    NewLVL is CurLvl + 1,
    NewLuck is CurLuck + 1,

    asserta(expFishing(0)),
    asserta(levelFishing(NewLVL)),
    asserta(luck(NewLuck)),
    format('Level Fishing Anda naik menjadi ~w!', [NewLVL]),nl,
    earnEXPFishing(X).

naikLevelRanching(X) :-
    
    levelRanching(CurLvl),
    ranchCapacity(CurCap),
    
    retractall(expRanching(_)),
    retractall(levelRanching(_)),
    retractall(ranchCapacity(_)),
    
    NewLVL is CurLvl + 1,
    NewCap is CurCap + 1,

    asserta(expRanching(0)),
    asserta(levelRanching(NewLVL)),
    asserta(ranchCapacity(NewCap)),
    format('Level Ranching Anda naik menjadi ~w!', [NewLVL]),nl,
    earnEXPRanching(X).

naikLevelFarming(X) :-
    
    levelFarming(CurLvl),
    hasilPanen(CurPanen),
    
    retractall(expFarming(_)),
    retractall(levelFarming(_)),
    retractall(hasilPanen(_)),
    
    NewLVL is CurLvl + 1,
    NewPanen is CurPanen + 1,
    
    asserta(expFarming(0)),
    asserta(levelFarming(NewLVL)),
    asserta(hasilPanen(NewPanen)),
    
    format('Level Farming Anda naik menjadi ~w!', [NewLVL]),nl,
    earnEXPFarming(X).

showStat :-
    maxEnergy(MaxE),
    (money(Money)),
    (energy(E)),
    (hasilPanen(Panen)),
    (ranchCapacity(Ranch)),
    luck(Kehokian),
    (levelPlayer(LVLP)),
    (expPlayer(XPplayer)),
    (levelFishing(LVLfish)),
    (expFishing(XPfish)),
    (levelRanching(LVLranch)),
    (expRanching(XPranch)),
    (levelFarming(LVLfarm)),
    (expFarming(XPfarm)),
    (day(CurrDay)),

    XPplayerNeeded is LVLP*100,
    XPfishNeeded is LVLfish*100,
    XPranchNeeded is LVLranch*100,
    XPfarmNeeded is LVLfarm*100,

    format('Day             : ~w    ', [CurrDay]),nl,
    format('Energi          : ~w/~w', [E,MaxE]),nl,
    format('Uang            : ~w', [Money]),nl,
    format('Level Player    : ~w', [LVLP]),nl,
    format('EXP Player      : ~w/~w', [XPplayer,XPplayerNeeded]),nl,
    format('EXP Fishing     : ~w/~w', [XPfish,XPfishNeeded]),nl,
    format('EXP Ranching    : ~w/~w', [XPranch,XPranchNeeded]),nl,
    format('EXP Farming     : ~w/~w', [XPfarm,XPfarmNeeded]),nl,
    format('Hasil Panen     : ~w', [Panen]),nl,
    format('Kapasitas Ranch : ~w', [Ranch]),nl,
    format('Keberuntungan   : ~w', [Kehokian]),nl,!.
