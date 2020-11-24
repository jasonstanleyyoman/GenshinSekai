boss_name(dwalin).

:- dynamic(boss_current_health/1).

boss_max_health(1000).

boss_level(100).

boss_attack(200).

boss_special_attack(300).

boss_defense(150).

battle_boss :- 
                1 =:= 1.

%boss_turn giliran boss
boss_turn :-
                boss_current_health(BossHealth),
                BossHealth > 0,!,
                boss_is_enraged,
                write('Boss is not defeated').

boss_turn :-    
                boss_current_health(BossHealth),
                BossHealth =< 0,!,
                write('Boss is defeated').

%boss_action menentukan tindakan boss pada gilirannya
boss_action :-  
                random(1,15,BossAction),
                boss_attack_action(BossAction),
                boss_special_attack_action(BossAction),
                boss_gust_action(BossAction),
                boss_healing_action(BossAction).

%boss_attack serangan boss
boss_attack_action(BossAction) :- 
                BossAction >= 1,
                BossAction =< 7,
                boss_attack(BossAttack),
                player_current_health(PlayerHealth),
                player_defense(PlayerDefense),
                BossDamageDealt is (BossAttack - PlayerDefense),
                NewPlayerHealth is (PlayerHealth - BossDamageDealt),
                retractall(player_current_health(_)),
                assertz(player_current_health(NewPlayerHealth)),
                write('Boss uses attack'),nl,
                write('Boss dealt '),
                write(BossDamageDealt),
                write(' damage.'),
                player_turn.

%boss_special_attack serangan spesial boss
boss_special_attack_action(BossAction) :-
                BossAction >= 8,
                BossAction =< 11,
                boss_special_attack(BossAttack),
                player_current_health(PlayerHealth),
                player_defense(PlayerDefense),
                BossDamageDealt is (BossAttack - PlayerDefense),
                NewPlayerHealth is (PlayerHealth - BossDamageDealt),
                retractall(player_current_health(_)),
                assertz(player_current_health(NewPlayerHealth)),
                write('Boss uses special attack'),nl,
                write('Boss dealt '),
                write(BossDamageDealt),
                write(' damage.'),
                player_turn.

%boss_gust serangan boss yang mengakibatkan player kehilangan sejumlah potion
boss_gust_action(BossAction) :-
                BossAction >= 12,
                BossAction =< 14,
                random(1,3,PotionID),
                potion_count(PotionID, CurrentPotionCount),
                CurrentPotionCount >= 10,
                NewPotionCount is (CurrentPotionCount - 10),
                retract(potion_count(PotionID,_)),
                assertz(potion_count(PotionID,NewPotionCount)),
                write('Boss uses gust'),nl,
                write('Player loses 10 potions.'),
                player_turn.

boss_gust_action(BossAction) :-
                BossAction >= 12,
                BossAction =< 14,
                random(1,3,PotionID),
                potion_count(PotionID, CurrentPotionCount),
                CurrentPotionCount < 10,
                NewPotionCount is 0,
                retract(potion_count(PotionID,_)),
                assertz(potion_count(PotionID,NewPotionCount)),
                write('Boss uses gust'),nl,
                write('Player loses '),
                write(CurrentPotionCount),
                write(' potions.'),
                player_turn.

%boss_healing boss dapat memulihkan healthnya
boss_healing_action(BossAction) :- 
                BossAction =:= 15,
                boss_current_health(CurrentHealth),
                boss_max_health(MaxHealth),
                BossHealAmount is (15/100*MaxHealth),
                NewBossHealth is (CurrentHealth + BossHealAmount),
                retractall(boss_current_health(_)),
                assertz(boss_current_health(NewBossHealth)),
                write('Boss heals himself for '),
                write(BossHealAmount),
                write(' health.'),
                player_turn.

%boss_is_enraged mengecek apakah boss enraged
boss_is_enraged :-
                boss_current_health(CurrentHealth),
                boss_max_health(MaxHealth),
                CurrentHealth =:= (3/10 * MaxHealth),
                boss_enraged.

%boss_enraged saat health boss rendah, attack boss akan meningkat
boss_enraged :- 
                write('Boss is enraged'),nl,
                write('Boss attack rose'),
                boss_attack(BossAttack),
                BossNewAttack is (BossAttack + 2/5*BossAttack),
                retractall(boss_attack(_)),
                assertz(boss_attack(BossNewAttack)).



