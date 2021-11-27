/* semua include di sini */

:- include('menu.pl').
:- include('peta.pl').
:- include('player.pl').
:- include('activity.pl').
:- include('command.pl').


:- dynamic(state/1).

state(initialized).


start :-
     mainMenu.
     % repeat,
     % write('>>> '),
     % read(X),
     % call(X),
     % fail.
     

mainMenu :-
     help,
     write('>>> '),
     read(Choice), nl,!,
     ( 
          (Choice = start, startGame);
          (Choice = load, loadGame);
          (Choice = help, help);
          (Choice = exit, exitGame)
     ).
    
startGame :- 
     reset,
     asserta(state(started)),
     initMap,

     write('Game Started'),nl,
     write('Selamat Datang di Game!'),nl,
     write('Pilih Job yang ingin Anda Pilih!'),nl,
     write('1. fisherman'),nl,
     write('2. rancher'),nl,
     write('3. farmer'),nl,
     write('>>> '),
     read(Choice), nl,
     pilihJob(Choice),
     menuInGame.

menuInGame :-
     write('Pilih Hal yang ingin dilakukan!'),nl,
     write('1. w,a,s,d untuk berpindah tempat'),nl,
     write('2. map'),nl,
     write('3. status'),nl,
     write('>>> '),
     read(Choice), nl,!,
     ( 
          (Choice = w, w);
          (Choice = a, a);
          (Choice = s, s);
          (Choice = d, d);
          (Choice = map, map);
          (Choice = status, showStat)
     ),
     menuInGame.



loadGame :-
     write('Game Loaded'),nl.    

exitGame :- halt.
