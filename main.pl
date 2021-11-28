/* semua include di sini */

:- include('menu.pl').
:- include('peta.pl').
:- include('player.pl').
:- include('mancing.pl').
:- include('command.pl').
:- include('inventory.pl').
:- include('market.pl').
:- include('items.pl').
:- include('quest.pl').

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




% MAIN PROGRAM
help :-
     write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
     write('%                                  HELP                                         %\n'),
     write('%                                                                               %\n'),
     write('%                                                                               %\n'),
     write('% 1. start         : Start the game                                             %\n'),
     write('% 2. map           : Open the Map                                               %\n'),
     write('% 3. status        : Check player current status                                %\n'),
     write('% 4. w             : Move one step up                                           %\n'),
     write('% 5. s             : Move one step down                                         %\n'),
     write('% 6. a             : Move one step to the left                                  %\n'),
     write('% 7. d             : Move one step to the right                                 %\n'),
     write('% 8. inventory     : Open inventory                                             %\n'),
     write('% 9. market        : Open up market menu                                        %\n'),
     write('% 10. fish         : Catch a fish in the river                                  %\n'),
     write('% 11. dig          : Dig a tile                                                 %\n'),
     write('% 12. plant        : Plant a crop on digged tile                                %\n'),
     write('% 13. harvest      : Harvest a crop                                             %\n'),
     write('% 14. ranch        : Collecting animal products                                 %\n'),
     write('% 15. sleep        : Sleep                                                      %\n'),
     write('% 16. exit         : Quit the game                                              %\n'),
     write('%                                                                               %\n'),
     write('%                                                                               %\n'),
     write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n').
  

tampilanAwal :-
     write(' _   _                           _\n'),   
     write('| | | | __ _ _ ____   _____  ___| |_ \n'),   
     write('| |_| |/ _` | \'__\\ \\ / / _ \\/ __| __|\n'),   
     write('|  _  | (_| | |   \\ V /  __/\\__ \\ |_\n'),   
     write('|_| |_|\\__,_|_|    \\_/ \\___||___/\\__|\n\n'),   
                    
     write('Harvest Star!!!\n'),
     write('Let\'s play and pay our debts together!\n'),
                     
               
     write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
     write('%                                  MENU                                         %\n'),
     write('%                                                                               %\n'),
     write('%                                                                               %\n'),
     write('% 1. start         : Start the game                                             %\n'),
     write('% 2. exit          : Quit the game                                              %\n'),
     write('%                                                                               %\n'),
     write('%                                                                               %\n'),
     write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n').


menuAwal :-
     write('>>> '),
     read(Choice), nl,
     ( 
          (Choice = start, startGame);
          % (Choice = load, loadGame);
          % (Choice = help, help);
          (Choice = exit, halt)
          % (write('Invalid command!\n'),menuAwal)
     ).

start :-
     tampilanAwal,
     menuAwal.
    
startGame :- 
     reset,
     asserta(state(started)),
     asserta(day(1)),
     initMap,
     post_quest.
     write('Game Started'),nl,
     write('Welcome to Harvest Star. Choose your job!'),nl,
     write('1. fisherman'),nl,
     write('2. rancher'),nl,
     write('3. farmer'),nl,
     write('>>> '),
     read(Choice), nl,
     % (    \+job(Choice), 
     %      write('Invalid Job!\n'), 
     %      write('>>> '),
     %      read(Choice), nl
     % );
     (    pilihJob(Choice)
     ),
     menuInGame.

menuInGame :-
     write('What do you want to do : '),nl,
     write('>>> '),
     read(Choice), nl,!,
     call(Choice),
     % ( 
          
     %      (Choice = map, map);
     %      (Choice = status, showStat);
     %      (Choice = w, w);
     %      (Choice = a, a);
     %      (Choice = s, s);
     %      (Choice = d, d);
     %      (Choice = inventory, inventory);
     %      (Choice = market, market);
     %      (Choice = fish, mancing);
     %      (Choice = dig, dig);
     %      (Choice = plant, plant);
     %      (Choice = harvest, harvest);
          
          
     %      (Choice = exit, exitGame)
     %      % (write('Invalid command'),nl)
     % ),
     % energy(E),
     % E =< 0,
     % write('You have run out of energy and magically sleep in your house'),
     % sleep,
     
     menuInGame.
     



loadGame :-
     write('Game Loaded'),nl.    

exit :- 
     write('Are you sure you want to exit the game? (y/n)'),nl,
     write('>>> '),
     read(Choice), nl,!,
     (
          (Choice = y, write('Thank You for playing the game!'), halt);
          (Choice= n, menuInGame)
     ).

