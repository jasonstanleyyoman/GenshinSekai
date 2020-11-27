%help untuk saat di field (exploration)
help :-
    \+ is_battle,
    \+ is_boss_battle,
    write('BASIC COMMANDS'),nl,
    write('--------------------------------------------------------------------'),nl,
    write('1. start         : Untuk memulai petualanganmu'),nl,
    write('2. map           : menampilkan peta'),nl,
    write('3. status        : menampilkan kondisimu terkini'),nl,
    write('4. w             : gerak ke utara 1 langkah'),nl,
    write('5. s             : gerak ke selatan 1 langkah'),nl,
    write('6. d             : gerak ke ke timur 1 langkah'),nl,
    write('7. a             : gerak ke barat 1 langkah'),nl,
    write('8. help          : menampilkan segala bantuan'),nl,
    write('9. take_quest    : untuk mengambil quest'),nl,
    write('10. interact     : untuk berinteraksi dengan komponen map'),nl,
    write('11. check_job    : untuk mengecek job sekarang'),nl,
    write('---------------------------------------------------------------------'),nl,
    write('CHEAT COMMANDS'),nl,
    write('1. add_quest_progress_slime  : Menambah progress slime pada quest'),nl,
    write('2. add_quest_progress_goblin : Menambah progress goblin pada quest'),nl,
    write('3. add_quest_progress_wolf   : Menambah progress wolf pada quest'),nl,
    write('4. restore_full_health       : Menambah darah menjadi penuh'),nl,
    write('5. teleport(X,Y)             : Teleport player ke point X,Y'),nl,
    write('6. godmode                   : Memberikan attack dan defense senilai 1000000'),nl.

help :- 
    is_battle ; is_boss_battle,

help :-
    shop    

help :- 
    quest

help :- 
    home

help :-
    inventory
