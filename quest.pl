/* Quest itu dalam bentuk tuple 17 elemen,
   (Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des).
   available_quest: list semua quest yang ada.
   current_quest: quest yang sedang dikerjakan, cuman boleh satu di setiap waktu.
   Quest cuman bisa dipilih di tile (Q).

/* dynamic stuff */
:- dynamic(available_quest/1).
:- dynamic(current_quest/17).

remove_available_quest :-
	available_quest(_),!,
	retractall(available_quest(_)).
remove_available_quest.

remove_current_quest :-
	current_quest(_,_,_,_,_,_),!,
	retractall(current_quest(_,_,_,_,_,_)).
remove_current_quest.

/* Membuat daftar semua quest yang ada, post_quest dilakukan sekali di awal New Game */
buat_quest(Tuple) :- \+available_quest(_), asserta(available_quest([Tuple])), !.
buat_quest(Tuple) :-
	available_quest(OldAvailableQuest),
	retractall(available_quest(_)),
	appendList(Tuple,OldAvailableQuest,NewAvailableQuest),
	asserta(available_quest(NewAvailableQuest)).
post_quest :- 
   buat_quest([5,5,5,5,5,5,6,6,6,6,6,7,7,7,999,999,'Tolong! Saya jomblo... hiks hiks']),
   buat_quest([5,5,5,5,5,5,6,6,6,6,6,7,7,7,999,999,'Tolong! Saya jelek... hiks hiks']),
   buat_quest([5,5,5,5,5,5,6,6,6,6,6,7,7,7,999,999,'Tolong! Saya kere... hiks hiks']),
   buat_quest([5,5,5,5,5,5,6,6,6,6,6,7,7,7,999,999,'Tolong! Saya bahlul... hiks hiks']),
   buat_quest([5,5,5,5,5,5,6,6,6,6,6,7,7,7,999,999,'Tolong! Saya vvibu... hiks hiks']), !.

/* Display papan quest */
display_quest(X,[[Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des]]) :- 
	format('  ~d. ~d Egg, ~d Wool, ~d Milk, ~d Mayonnaise, ~d Sweater, ~d Cheese\n     ~d Carrot, ~d Potato, ~d Corn, ~d Tomato, ~d Pumkin\n     ~d Ikan Teri, ~d Ikan Gurame, ~d Ikan Betutu\n     Upah: ~d EXP dan ~d Gold.\n\n     - ~w\n\n',[X,Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des]).
display_quest(X,[[Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des]|Tail]) :-
	format('  ~d. ~d Egg, ~d Wool, ~d Milk, ~d Mayonnaise, ~d Sweater, ~d Cheese\n     ~d Carrot, ~d Potato, ~d Corn, ~d Tomato, ~d Pumkin\n     ~d Ikan Teri, ~d Ikan Gurame, ~d Ikan Betutu\n     Upah: ~d EXP dan ~d Gold.\n\n     - ~w\n\n',[X,Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des]),
	NextX is X + 1,
	display_quest(NextX,Tail), !.
display_quest :-
	write('###########################=================================###########################\n'),
   write('###########################====  % Papan Quest Desa %   ====###########################\n'),
	write('###########################=================================###########################\n'),
	write('                                                                                       \n'),
	available_quest(Q),
	display_quest(1,Q),
	write('#######################################################################################\n').

/* COMMAND QUEST */
/* Player tidak sedang berada di tile Quest */
/* Di komen-in dlu biar gampang debug
quest :-
	playerCoord(X,Y),
   \+questCoord(X,Y),
   write('Papan Quest Desa (Q) bukan di sini!\n'),!,fail.*/

/* Masih ada current_quest */
quest :-
	current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_),!,
	write('Kamu masih punya Quest yang sedang berlangsung! Ngerjainnya mesti satu-satu atuh.\n').

/* Semua quest sudah diambil */
quest :-
	\+available_quest(_),!,
	write('WOW! Kamu sudah membantu semua orang di Desa! Keren banget euy!!\n').

/* Normal */
quest :-
	display_quest,
	write('  - Ayo kita saling membantu sesama warga Desa!\n  - Silakan masukkan nomor Quest yang ingin kamu ambil.\n  - Untuk keluar dari Papan Quest Desa, masukkan 999.\n  - '),
	read(Query),
	(
		available_quest(QuestList),
		jmlhList(QuestList,JmlhQuest),
		Query =< JmlhQuest,
      Query >= 0,

      /* Menghapus quest yang diambil dari daftar quest*/
		del_at(QuestList,Query,NewQuestList,[Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des]),
		retractall(available_quest(_)),
		asserta(available_quest(NewQuestList)),

      /* Set quest menjadi current_quest */
		asserta(current_quest(Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des)),
      format('Kamu mengambil Quest nomor ~d!\n',[Query]),
		write('Kamu keluar dari Papan Quest Desa. Good Luck!\n'),
		!);
   (
		write('Kamu keluar dari Papan Quest Desa.\n'),
		!).

/* MEKANISME REWARD */










/* Operasi List biar hidup tenang*/
jmlhList([], 0).
jmlhList([_|T], Cnt) :- jmlhList(T, LastCnt), Cnt is LastCnt+1.

delElList(_, [], []) :- !.
delElList(X, [X|T], T) :- !.
delElList(X, [H|T], [H|Ret]) :- delElList(X, T, Ret), !.

del_at([X|Tail],1,Tail,X).
del_at([Head|Tail],N,RetList,RemovedElmt) :-
	NextN is N - 1,
	del_at(Tail,NextN,Tmp,RemovedElmt),
	RetList = [Head|Tmp].

appendList(X, [], [X]).
appendList(X, [H|T], Ret) :- appendList(X, T, TailRet), Ret = [H|TailRet].