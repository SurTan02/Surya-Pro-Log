/* semua include di sini */

:- include('menu.pl').
:- include('peta.pl').
:- include('player.pl').
:- include('activity.pl').
:- include('command.pl').


:- dynamic(state/1).
:- dynamic(day/1).

sleep :-
     houseCoord(X,Y),
     retractall(playerCoord(_,_)),
     asserta(playerCoord(X,Y)),


     maxEnergy(MaxE),
     day(CurrDay),
     NextDay is CurrDay + 1,
     retractall(energy(_)),
     retractall(day(_)),
     asserta(energy(MaxE)),
     asserta(day(NextDay)).

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
     asserta(day(1)),
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
     
     


     write('What do you want to do : '),nl,
     write('1. w,a,s,d untuk berpindah tempat'),nl,
     write('2. map'),nl,
     write('3. status'),nl,
     write('3. fish'),nl,
     write('10. exit'),nl,
     write('>>> '),
     read(Choice), nl,!,
     ( 
          (Choice = w, w);
          (Choice = a, a);
          (Choice = s, s);
          (Choice = d, d);
          (Choice = fish, mancing);
          (Choice = map, map);
          (Choice = status, showStat);
          (Choice = exit, exitGame)
          % (write('Invalid command'),nl)
     ),
     energy(E),
     E =< 0,
     write('You have run out of energy and magically sleep in your house'),
     sleep,
     
     menuInGame.
     



loadGame :-
     write('Game Loaded'),nl.    

exitGame :- 
     write('Are you sure you want to exit the game? (y/n)'),nl,
     write('>>> '),
     read(Choice), nl,!,
     (
          (Choice = y, write('Thank You for playing the game!'), halt);
          (Choice= n, menuInGame)
     ).

