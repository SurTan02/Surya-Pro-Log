% :- include('activity.pl').
% :- include('quest.pl').

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

% baseExp(100).
% baseEnergy(100).
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
                asserta(maxEnergy(150)),
                firstLevel,
                format('You choose ~w, let\'s start working', [Job]),nl,
                 updatePrice,
                status.



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
    asserta(jobPlayer(farmer)),
    asserta(luck(1)),!.

setStat(farmer) :-
    asserta(jobPlayer(rancher)),
    asserta(luck(1)),!.

earnMoney(X):-
    money(Before),
    retractall(money(_)),
    After is Before + X,
    asserta(money(After)),
    format('You just gained ~w gold, you have ~w gold',[X,After]), nl, nl, checkGoalMoney,nl,!.
    
spendMoney(X):-
    money(Before),
    retractall(money(_)),
    After is Before - X,
    asserta(money(After)),
    format('You just spent ~w gold, you have ~w gold',[X,After]), nl.

% gainEnergy(_) :-
%     energy(Eawal),
%     maxEnergy(MaxE),
%     Eawal = MaxE,
%     write('Your current energy is full!'),nl, !.

gainEnergy(X) :-
    energy(Eawal),
    maxEnergy(MaxE),
    (Eawal + X>= MaxE -> Eakhir is MaxE;
    Eakhir is Eawal + X),
    retractall(energy(_)),
    asserta(energy(Eakhir)),
    format('You energy becomes ~w ',[Eakhir]), nl.


% exp untuk level up adalah 100,200,300,400....
earnEXPPlayer(X):-
    % format('you gained ~w exp!',[X]), nl,
    expPlayer(XP),
    levelPlayer(CurrLvl),
    NewXP is XP + X,
    NewXP >= (100 * (CurrLvl)) ,!,
    Sisa is NewXP-(100 * (CurrLvl)),
    % write([CurrLvl,XP,X,NewXP,Sisa]),
    naikLevelPlayer(Sisa).
    
earnEXPPlayer(X):-
    % format('you gained ~w exp!',[X]), nl,
    expPlayer(XP),
    NewXP is XP + X,
    retractall(expPlayer(_)), 
    asserta(expPlayer(NewXP)).


earnEXPFishing(X):-
    % format('you gained ~w fishing exp!',[X]), nl,
    expFishing(XP),
    levelFishing(CurrLvlF),
    NewXP is XP + X,
    NewXP >= (100 * (CurrLvlF)), !,
    Sisa is NewXP-(100 * (CurrLvlF)),
    naikLevelFishing(Sisa).
    

earnEXPFishing(X):-
    % format('you gained ~w fishing exp!',[X]), nl,
    expFishing(XP),
    NewXP is XP + X,
    retractall(expFishing(_)), asserta(expFishing(NewXP)).

earnEXPRanching(X):-
    % format('you gained ~w ranching exp!',[X]), nl,
    expRanching(XP),
    levelRanching(CurrLvlR),
    
    NewXP is XP + X,
    NewXP >= (100 * (CurrLvlR)), !,
    Sisa is NewXP-(100 * (CurrLvlR)),
    naikLevelRanching(Sisa).

earnEXPRanching(X):-
    % format('you gained ~w ranching exp!',[X]), nl,
    expRanching(XP),
    NewXP is XP + X,
    retractall(expRanching(_)), asserta(expRanching(NewXP)).

earnEXPFarming(X):-
    % format('you gained ~w farming exp!',[X]), nl,
    expFarming(XP),
    levelFarming(CurrLvlFa),
    NewXP is XP + X,
    NewXP >= (100 * (CurrLvlFa)), !,
    Sisa is NewXP-(100 * (CurrLvlFa)),
    naikLevelFarming(Sisa).

earnEXPFarming(X):-
    % format('you gained ~w farming exp!',[X]), nl,
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
    format('You just advanced to level ~w!', [NewLVL]),nl,
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
    format('Your fishing skill just advanced to level ~w!', [NewLVL]),nl,
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
    format('Your ranching skill just advanced to level ~w!', [NewLVL]),nl,
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
    
    format('Your farming skill just advanced to level ~w!', [NewLVL]),nl,
    earnEXPFarming(X).

status :-
    maxEnergy(MaxE),
    (money(Money)),
    (energy(E)),
    % (hasilPanen(Panen)),
    % (ranchCapacity(Ranch)),
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
    format('Energy          : ~w/~w', [E,MaxE]),nl,
    format('Gold            : ~w', [Money]),nl,
    format('Player Level    : ~w', [LVLP]),nl,
    format('Player Exp      : ~w/~w', [XPplayer,XPplayerNeeded]),nl,
    format('Fishing Level   : ~w', [LVLfish]),nl,
    (
        LVLfish < 10 -> format('Fishing Exp     : ~w/~w', [XPfish,XPfishNeeded]),nl;
        LVLfish >= 10 -> write('Fishing Exp     :  MAX'),nl    
    ),
    format('Ranching Level  : ~w', [LVLranch]),nl,
    (
        LVLranch < 10 -> format('Ranching Exp    : ~w/~w', [XPranch,XPranchNeeded]),nl;
        LVLranch >= 10 -> write('Ranching Exp     :  MAX'),nl   

    ),
    format('Farming Level   : ~w', [LVLfarm]),nl,
    (
        LVLfarm < 10 -> format('Farming Exp     : ~w/~w', [XPfarm,XPfarmNeeded]),nl;
        LVLfarm >= 10  -> write('Farming Exp     :  MAX'),nl

    ),

    % format('Hasil Panen     : ~w', [Panen]),nl,
    % format('Ranch Capacity  : ~w', [Ranch]),nl,
    format('Luck            : ~w', [Kehokian]),nl,
    stat_quest, !.
