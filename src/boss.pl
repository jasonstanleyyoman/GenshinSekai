boss_name('Dvozak').

:- dynamic(boss_current_health/1).

boss_max_health(100).

boss_level(100).

:- dynamic(boss_attack/1).
boss_attack(2).

boss_defense(1).

%boss_is_enraged mengecek apakah boss enraged
boss_is_enraged :-
                boss_current_health(CurrentHealth),
                boss_max_health(MaxHealth),
                CurrentHealth =:= (3/10 * MaxHealth),
                boss_enraged.

%boss_enraged saat health boss rendah, attack boss akan meningkat
boss_enraged :- 
                write('Dvalin is enraged'),nl,
                write('Dvalin attack rose'),
                boss_attack(BossAttack),
                BossNewAttack is (BossAttack + 2/5*BossAttack),
                retractall(boss_attack(_)),
                assertz(boss_attack(BossNewAttack)).



