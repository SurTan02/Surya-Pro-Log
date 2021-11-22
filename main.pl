/* semua include di sini */

:- include('menu.pl').


:- dynamic(state/1).

state(initialized).

start :-
   mainMenu.

mainMenu :-
    write('>>> '),
    read(Choice), nl,
    ( 
      (Choice = start, startGame);
      (Choice = load, loadGame);
      (Choice = help, help);
      (Choice = exit, exitGame)
    ). 
    
startGame :- 
     asserta(state(start)),
     write('Game Started'),nl.
     
loadGame :-
     write('Game Loaded'),nl.    

exitGame :- halt.
