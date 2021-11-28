/* Quest itu dalam bentuk tuple 17 elemen,

   (Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des).

   available_quest: list semua quest yang ada.
   current_quest: quest yang sedang dikerjakan, cuman boleh satu di setiap waktu.

   Quest cuman bisa dipilih di tile (Q).

/* dynamic stuff */
:- dynamic(available_quest/1).
:- dynamic(current_quest/17).

/* Membuat daftar semua quest yang ada, post_quest dilakukan sekali di awal New Game */
buat_quest(Tuple) :- \+available_quest(_), asserta(available_quest([Tuple])), !.
buat_quest(Tuple) :-
	available_quest(Quest),
	retractall(available_quest(_)),
	appendList(Tuple,Quest,NewQuest),
	asserta(available_quest(NewQuest)).
post_quest :- 
   buat_quest([3,0,3,0,0,0,3,3,3,0,0,3,0,0,100,100,'Desa ini harus kuat imun-nya! Mari makan makanan 4 sehat 5 sempurna :D']),
   buat_quest([0,0,0,0,0,0,5,5,5,3,2,0,0,0,125,125,'Eat... Your... Vegetableeeee!! - Seorang guru vegan']),
   buat_quest([7,0,5,0,0,0,7,7,7,3,0,7,0,0,145,145,'Desa sebelah terkena musibah banjir, kita harus beri mereka bantuan!']),
   buat_quest([0,0,0,0,0,0,0,0,0,0,0,5,3,1,125,125,'Tolong bantu istri saya yang sedang hamil, dia tiba-tiba ngidam seafood.']),
   buat_quest([15,0,3,5,0,5,0,0,0,5,0,0,0,0,145,145,'Ayo bantu Desa ini memecahkan rekor omelette terbesar di dunia!']),
   buat_quest([0,10,0,0,10,0,0,5,0,0,8,0,0,0,155,155,'Winter is coming... and we know whats coming with it.']),
   buat_quest([0,0,7,0,0,7,0,0,10,0,0,0,0,0,175,175,'Ada bioskop baru buka di Desa! Semuanya skuy nonton Spider-Man yuuukk']),
   buat_quest([3,0,2,0,0,0,5,5,5,5,5,1,1,0,140,140,'Saya cape jomblo. Tolong bantu saya untuk diet dan jadi tamvan mempesona...']),
   buat_quest([10,0,10,10,0,10,10,10,10,10,10,10,10,10,500,500,'Gordon Ramsey otw ke sini... Kita harus cepat sediakan bahan-bahan terbaik!!']), !.

/* Display papan quest */
display_quest(X,[[Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des]]) :- 
	format('  ~d. ~d Egg, ~d Wool, ~d Milk, ~d Mayonnaise, ~d Sweater, ~d Cheese\n     ~d Carrot, ~d Potato, ~d Corn, ~d Tomato, ~d Pumpkin\n     ~d Ikan Teri, ~d Ikan Gurame, ~d Ikan Betutu\n     Upah: ~d EXP dan ~d Gold.\n\n     - ~w\n\n',[X,Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des]).
display_quest(X,[[Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des]|Tail]) :-
	format('  ~d. ~d Egg, ~d Wool, ~d Milk, ~d Mayonnaise, ~d Sweater, ~d Cheese\n     ~d Carrot, ~d Potato, ~d Corn, ~d Tomato, ~d Pumpkin\n     ~d Ikan Teri, ~d Ikan Gurame, ~d Ikan Betutu\n     Upah: ~d EXP dan ~d Gold.\n\n     - ~w\n\n',[X,Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des]),
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
	available_quest(Q),
   Q = [],!,
	write('\n  - WOW! Kamu sudah membantu semua orang di Desa! Keren banget euy!!\n').

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
      format('Kamu mengambil Quest nomor ~d! Good Luck!\n\n',[Query]),
		write('Kamu keluar dari Papan Quest Desa.\n'),
		!);
   (
		write('\nKamu keluar dari Papan Quest Desa.\n'),
		!).

/* MEKANISME REWARD */

/* Buat debug: Auto selesai current_quest */
auto_selesai :- retractall(current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).

/* Memberikan reward quest */
quest_rewarding :- 
   current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,Exp,Gld,_),
	write('Quest selesai! Terima kasih atas bantuannya! Ini upahmu: \n'),
   earnEXPPlayer(Exp),
   format('Anda mendapat ~d EXP\n',[Exp]),
	earnMoney(Gld),
	retractall(current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),!.

/* Apakah current_quest sudah selesai atau belum */
is_quest_done :-
	current_quest(Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,_,_,_),
	Egg = 0, Wol = 0, Mlk = 0,
   Myo = 0, Swt = 0, Chs = 0,
   Crt = 0, Pto = 0, Crn = 0, Tmo = 0, Pkn = 0,
   Tri = 0, Grm = 0, Btu = 0,
	quest_rewarding, !.
is_quest_done.

/* Update isi current_quest */
update_quest(ID) :-
	current_quest(Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des),
	((
			ID = 5,
			NewEgg is Egg - 1,
			NewEgg >= 0,!,
			retractall(current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
			asserta(current_quest(NewEgg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des))
		);
		(
			ID = 6,
			NewWol is Wol - 1,
			NewWol >= 0,!,
			retractall(current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
			asserta(current_quest(Egg,NewWol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des))
		);
      (
			ID = 4,
			NewMlk is Mlk - 1,
			NewMlk >= 0,!,
			retractall(current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
			asserta(current_quest(Egg,Wol,NewMlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des))
		);
      (
			ID = 8,
			NewMyo is Myo - 1,
			NewMyo >= 0,!,
			retractall(current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
			asserta(current_quest(Egg,Wol,Mlk,NewMyo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des))
		);
      (
			ID = 9,
			NewSwt is Swt - 1,
			NewSwt >= 0,!,
			retractall(current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
			asserta(current_quest(Egg,Wol,Mlk,Myo,NewSwt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des))
		);
      (
			ID = 7,
			NewChs is Chs - 1,
			NewChs >= 0,!,
			retractall(current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
			asserta(current_quest(Egg,Wol,Mlk,Myo,Swt,NewChs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des))
		);
      (
			ID = 15,
			NewCrt is Crt - 1,
			NewCrt >= 0,!,
			retractall(current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
			asserta(current_quest(Egg,Wol,Mlk,Myo,Swt,Chs,NewCrt,Pto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des))
		);
      (
			ID = 16,
			NewPto is Pto - 1,
			NewPto >= 0,!,
			retractall(current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
			asserta(current_quest(Egg,Wol,Mlk,Myo,Swt,Chs,Crt,NewPto,Crn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des))
		);
      (
			ID = 17,
			NewCrn is Crn - 1,
			NewCrn >= 0,!,
			retractall(current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
			asserta(current_quest(Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,NewCrn,Tmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des))
		);
      (
			ID = 18,
			NewTmo is Tmo - 1,
			NewTmo >= 0,!,
			retractall(current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
			asserta(current_quest(Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,NewTmo,Pkn,Tri,Grm,Btu,Exp,Gld,Des))
		);
      (
			ID = 19,
			NewPkn is Pkn - 1,
			NewPkn >= 0,!,
			retractall(current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
			asserta(current_quest(Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,NewPkn,Tri,Grm,Btu,Exp,Gld,Des))
		);
      (
			ID = 22,
			NewTri is Tri - 1,
			NewTri >= 0,!,
			retractall(current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
			asserta(current_quest(Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,NewTri,Grm,Btu,Exp,Gld,Des))
		);
      (
			ID = 21,
			NewGrm is Grm - 1,
			NewGrm >= 0,!,
			retractall(current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
			asserta(current_quest(Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,NewGrm,Btu,Exp,Gld,Des))
		);
      (
			ID = 20,
			NewBtu is Btu - 1,
			NewBtu >= 0,!,
			retractall(current_quest(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)),
			asserta(current_quest(Egg,Wol,Mlk,Myo,Swt,Chs,Crt,Pto,Crn,Tmo,Pkn,Tri,Grm,NewBtu,Exp,Gld,Des))
	)),
   is_quest_done,!.
update_quest(_).

/*####################################################################################################*/

/* Operasi List biar hidup lebih tenang */
jmlhList([], 0).
jmlhList([_|T], Count) :-
   jmlhList(T, LastCount), Count is LastCount + 1.

delElList(_, [], []) :- !.
delElList(X, [X|T], T) :- !.
delElList(X, [H|T], [H|New]) :-
   delElList(X, T, New), !.

del_at([X|Tail],1,Tail,X).
del_at([Head|Tail],N,NewList,RemovedElmt) :-
	NextN is N - 1,
	del_at(Tail,NextN,Temp,RemovedElmt),
	NewList = [Head|Temp].

appendList(X, [], [X]).
appendList(X, [H|T], New) :-
   appendList(X, T, TailNew), New = [H|TailNew].