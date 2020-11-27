% DUNGEON ENEMY
:- dynamic(is_battle/0).
:- dynamic(is_boss_battle/0).
:- dynamic(special_attack_available/0).
:- dynamic(special_attack_cooldown/1).
:- dynamic(enemy_special_attack_available/0).
:- dynamic(enemy_special_attack_cooldown/1).

% BOSS
:- dynamic(boss_special_attack_available/0).
:- dynamic(boss_special_attack_cooldown/1).

start_boss_battle :-
    retractall(is_boss_battle),
    retractall(boss_current_health(_)),
    retractall(special_attack_available),
    retractall(boss_special_attack_available),
    retractall(enemy_id(_)),
    retractall(enemy_current_health(_)),
    retractall(enemy_max_health(_)),
    retractall(enemy_attack(_)),
    retractall(enemy_defense(_)),
    retractall(enemy_special_attack_available),
    boss_name(BossName),
    write('Ketemu '), write(BossName),nl,
    assertz(is_boss_battle),
    boss_max_health(BossMaxHealth),
    assertz(boss_current_health(BossMaxHealth)),
    assertz(special_attack_available),
    draw_dragon,
    assertz(boss_special_attack_available).

% START BATTLE DENGAN ENEMY (SLIME / GOBLIN / WOLF)
start_battle(ID) :-
    retractall(is_battle),
    retractall(enemy_id(_)),
    retractall(enemy_current_health(_)),
    retractall(enemy_max_health(_)),
    retractall(enemy_attack(_)),
    retractall(enemy_defense(_)),
    retractall(special_attack_available),
    retractall(enemy_special_attack_available),
    enemy(ID, EnemyType),
    write('You found a wild '), write(EnemyType),nl,
    enemy_level(EnemyLevel),
    max_health_multiplier(ID, HealthMult),
    attack_multiplier(ID, AttackMult),
    defense_multiplier(ID, DefenseMult),
    Health is EnemyLevel * HealthMult,
    Attack is (2 * EnemyLevel) + (EnemyLevel * AttackMult),
    Defense is (1.5 * EnemyLevel) + (EnemyLevel * DefenseMult),
    assertz(enemy_id(ID)),
    assertz(is_battle),
    assertz(enemy_current_health(Health)),
    assertz(enemy_max_health(Health)),
    assertz(enemy_attack(Attack)),
    assertz(enemy_defense(Defense)),
    assertz(special_attack_available),
    assertz(enemy_special_attack_available),


    (( ID = 1 -> (draw_slime); 

       ID = 2 -> (draw_wolf);

       ID = 3 -> (draw_goblin)
        )).
    
attack :-
    is_battle,!,
    player_attack(Attack),
    enemy_current_health(EnemyHealth),
    enemy_defense(EnemyDefense),
    DamageDealt is Attack - EnemyDefense,
    max_value(DamageDealt, 0, SafeDamageDealt),
    NewDamageDealt is round(SafeDamageDealt),
    NewEnemyHealth is (EnemyHealth - NewDamageDealt),
    write('You deal '), write(NewDamageDealt), write(' damage!.'),nl,
    retractall(enemy_current_health(_)),
    assertz(enemy_current_health(NewEnemyHealth)),  
    enemy_turn,
    enemy_reduce_special_attack_cooldown. 

attack :-
    is_boss_battle,!,
    player_attack(Attack),
    boss_current_health(BossHealth),
    boss_defense(BossDefense),
    DamageDealt is Attack - BossDefense,
    max_value(DamageDealt, 0, SafeDamageDealt),
    NewBossHealth is (BossHealth - SafeDamageDealt),
    write('You deal '), write(DamageDealt), write(' damage!.'),nl,
    retractall(boss_current_health(_)),
    assertz(boss_current_health(NewBossHealth)),  
    boss_turn,
    boss_reduce_special_attack_cooldown. 

attack :-
    \+ is_battle,
    \+ is_boss_battle,
    write('You are not in battle.'),nl.

special_attack:-
    is_battle,
    special_attack_available,!,
    player_attack(PlayerAttack),
    NewPlayerAttack is PlayerAttack * 2,
    enemy_current_health(EnemyCurrentHealth),
    enemy_defense(EnemyDefense),
    DamageDealt is NewPlayerAttack - EnemyDefense,
    max_value(DamageDealt, 0, SafeDamageDealt),
    NewDamageDealt is round(SafeDamageDealt),
    NewEnemyCurrentHealth is EnemyCurrentHealth - NewDamageDealt,
    write('You deal '), write(NewDamageDealt), write(' damage with special attack.'), nl,
    retractall(special_attack_available),
    retractall(special_attack_cooldown(_)),
    retractall(enemy_current_health(_)),
    assertz(enemy_current_health(NewEnemyCurrentHealth)),
    assertz(special_attack_cooldown(3)),
    enemy_turn,
    enemy_reduce_special_attack_cooldown.

special_attack:-
    is_boss_battle,!,
    special_attack_available,!,
    player_attack(PlayerAttack),
    NewPlayerAttack is PlayerAttack * 2,
    boss_current_health(BossCurrentHealth),
    boss_defense(BossDefense),
    DamageDealt is NewPlayerAttack - BossDefense,
    max_value(DamageDealt, 0, SafeDamageDealt),
    NewDamageDealt is round(SafeDamageDealt),
    NewBossCurrentHealth is BossCurrentHealth - NewDamageDealt,
    write('You deal '), write(NewDamageDealt), write(' damage with special attack.'), nl,
    retractall(special_attack_available),
    retractall(special_attack_cooldown(_)),
    retractall(boss_current_health(_)),
    assertz(boss_current_health(NewBossCurrentHealth)),
    assertz(special_attack_cooldown(3)),
    boss_turn,
    boss_reduce_special_attack_cooldown.

special_attack:-
    is_battle,
    special_attack_cooldown(Cooldown),
    write('Special Attack is not Available'),nl,
    write('Will available again in '), write(Cooldown), write(' turn.'),nl.

special_attack:-
    is_boss_battle,
    special_attack_cooldown(Cooldown),
    write('Special Attack is not Available'),nl,
    write('Will available again in '), write(Cooldown), write(' turn.'),nl.

special_attack :-
    write('You are not in battle'),nl.

%charge_special_attack membuat special attack available kalau cooldown telah habis
charge_special_attack:-
    special_attack_cooldown(Cooldown),
    Cooldown =:= 0,
    assertz(special_attack_available).

%reduce_special_attack_cooldown kasus mengurangi cooldown dari special attack
reduce_special_attack_cooldown:-
    special_attack_cooldown(Cooldown),
    Cooldown > 0,
    NewCooldown is Cooldown - 1,
    retractall(special_attack_cooldown(_)),
    assertz(special_attack_cooldown(NewCooldown)),
    charge_special_attack.

%reduce_special_attack_cooldown kasus special attack masih available (tidak memiliki cooldown)
reduce_special_attack_cooldown.

%potion_list menampilkan list potion, hp gain potion, dan jumlah tiap potion
potion_list :-
    between(1,3,PotionID),
    potion_name(PotionID, PotionName),
    potion_count(PotionID, PotionCount),
    write(PotionID), write('. '),write(PotionName),write('Count: '),write(PotionCount),nl,
    PotionID = 3.

%use_potion menggunakan potion
use_potion(PotionID) :-
    is_battle,
    potion_count(PotionID, PotionCount),
    PotionCount > 0,
    potion(PotionID, PotionHealthGain),
    potion_name(PotionID, PotionName),
    player_current_health(PlayerCurrentHealth),
    player_max_health(PlayerMaxHealth),
    PlayerCurrentHealth < PlayerMaxHealth,
    PlayerLostHealth is PlayerMaxHealth - PlayerCurrentHealth,
    min_value(PotionHealthGain, PlayerLostHealth, HealthRestored),
    PlayerNewHealth is PlayerCurrentHealth + HealthRestored,
    %memulihkan health player
    retractall(player_current_health(_)),
    assertz(player_current_health(PlayerNewHealth)),
    %mengurangi jumlah potion karena terpakai
    NewPotionCount is PotionCount - 1,
    retractall(potion_count(PotionID, _)),
    assertz(potion_count(PotionID, NewPotionCount)),
    write('You use '), write(PotionName),nl,
    write('You restored '), write(HealthRestored), write(' health'),nl,
    enemy_turn,
    enemy_reduce_special_attack_cooldown.

use_potion(PotionID) :-
    is_boss_battle,
    potion_count(PotionID, PotionCount),
    PotionCount > 0,
    potion(PotionID, PotionHealthGain),
    potion_name(PotionID, PotionName),
    player_current_health(PlayerCurrentHealth),
    player_max_health(PlayerMaxHealth),
    PlayerCurrentHealth < PlayerMaxHealth,
    PlayerLostHealth is PlayerMaxHealth - PlayerCurrentHealth,
    min_value(PotionHealthGain, PlayerLostHealth, HealthRestored),
    PlayerNewHealth is PlayerCurrentHealth + HealthRestored,
    %memulihkan health player
    retractall(player_current_health(_)),
    assertz(player_current_health(PlayerNewHealth)),
    %mengurangi jumlah potion karena terpakai
    NewPotionCount is PotionCount - 1,
    retractall(potion_count(PotionID, _)),
    assertz(potion_count(PotionID, NewPotionCount)),
    write('You use '), write(PotionName),nl,
    write('You restored '), write(HealthRestored), write(' health'),nl,
    boss_turn,
    boss_reduce_special_attack_cooldown.

%use_potion kasus sedang tidak battle
use_potion(PotionID) :-
    \+ is_battle,
    \+ is_boss_battle,
    potion_count(PotionID, PotionCount),
    PotionCount > 0,
    potion(PotionID, PotionHealthGain),
    potion_name(PotionID, PotionName),
    player_current_health(PlayerCurrentHealth),
    player_max_health(PlayerMaxHealth),
    PlayerCurrentHealth < PlayerMaxHealth,
    PlayerLostHealth is PlayerMaxHealth - PlayerCurrentHealth,
    min_value(PotionHealthGain, PlayerLostHealth, HealthRestored),
    PlayerNewHealth is PlayerCurrentHealth + HealthRestored,
    %memulihkan health player
    retractall(player_current_health(_)),
    assertz(player_current_health(PlayerNewHealth)),
    %mengurangi jumlah potion karena terpakai
    NewPotionCount is PotionCount - 1,
    retractall(potion_count(PotionID, _)),
    assertz(potion_count(PotionID, NewPotionCount)),
    write('You use '), write(PotionName),nl,
    write('You restored '), write(HealthRestored), write(' health'),nl.

use_potion(_) :-
    player_current_health(PlayerCurrentHealth),
    player_max_health(PlayerMaxHealth),
    PlayerCurrentHealth =:= PlayerMaxHealth,
    write('You are already on max health'),nl.

use_potion(PotionID) :-
    potion_count(PotionID, PotionCount),
    PotionCount =< 0,
    potion_name(PotionID, PotionName),
    write('You run out of '), write(PotionName),nl.

run :-
    random(1,10, RunChance),
    run_succeed(RunChance).

%chance lari dari slime
run_succeed(RunChance) :-
    RunChance >= 1,
    RunChance =< 7,
    retractall(is_battle),
    retractall(is_boss_battle),
    write('You run away successfully'),nl.

run_succeed(RunChance) :-
    is_battle,
    RunChance >= 8,
    RunChance =< 10,
    write('You failed to run away '),nl,
    enemy_turn,
    enemy_reduce_special_attack_cooldown.

run_succeed(RunChance) :-
    is_boss_battle,
    RunChance >= 8,
    RunChance =< 10,
    write('You failed to run away '),nl,
    boss_turn,
    boss_reduce_special_attack_cooldown.

%enemy_turn kasus enemy berhasil dikalahkan
enemy_turn :-
    enemy_current_health(EnemyHealth),
    enemy_id(ID),
    enemy(ID, EnemyName),
    EnemyHealth =< 0,
    write('You defeated '), write(EnemyName),nl,
    exp_gained(ExpGained),
    player_exp(PlayerExp),
    NewPlayerExp is PlayerExp + ExpGained,
    write('You gain '), write(ExpGained), write(' EXP'),nl,
    retractall(player_exp(_)),
    assertz(player_exp(NewPlayerExp)),
    retractall(is_battle),
    level_up,nl,
    add_quest_progress(ID).

%enemy_turn kasus enemy bisa special attack
enemy_turn :-
    enemy_special_attack_available,!,
    enemy_current_health(EnemyHealth),
    enemy_id(ID),
    enemy(ID, EnemyName),
    EnemyHealth > 0,
    write(EnemyName), write(' Hang up with '), write(EnemyHealth), write(' health left.'),nl,
    enemy_special_attack.

%enemy_turn kasus enemy tidak bisa special attack
enemy_turn :-
    enemy_current_health(EnemyHealth),
    enemy_id(ID),
    enemy(ID, EnemyName),
    EnemyHealth > 0,
    write(EnemyName), write(' Hang up with '), write(EnemyHealth), write(' health left.'),nl,
    enemy_attack.


enemy_attack :-
    enemy_id(ID),
    enemy(ID, EnemyName),
    enemy_attack(EnemyAttack),
    player_current_health(PlayerHealth),
    player_defense(PlayerDefense),
    DamageDealt is EnemyAttack - PlayerDefense,
    max_value(DamageDealt, 0, NewDamageDealt),
    NewNewDamageDealt is round(NewDamageDealt),
    PlayerNewHealth is PlayerHealth - NewNewDamageDealt,
    retractall(player_current_health(_)),
    assertz(player_current_health(PlayerNewHealth)),
    write(EnemyName), write(' deal '), write(NewNewDamageDealt), write(' damage to you'),nl,
    check_player_status,
    reduce_special_attack_cooldown.

enemy_special_attack :-
    enemy_id(ID),
    enemy(ID, EnemyName),
    enemy_attack(EnemyAttack),
    player_current_health(PlayerHealth),
    player_defense(PlayerDefense),
    DamageDealt is EnemyAttack - PlayerDefense,
    max_value(DamageDealt, 0, NewDamageDealt),
    NewNewDamageDealt is round(NewDamageDealt),
    PlayerNewHealth is PlayerHealth - NewNewDamageDealt,
    write(EnemyName), write(' deal '), write(NewNewDamageDealt), write(' damage with special attack to you'),nl,
    retractall(enemy_special_attack_available),
    retractall(enemy_special_attack_cooldown(_)),
    retractall(player_current_health(_)),
    assertz(player_current_health(PlayerNewHealth)),
    assertz(enemy_special_attack_cooldown(3)),
    check_player_status,
    reduce_special_attack_cooldown.

enemy_charge_special_attack :-
    enemy_special_attack_cooldown(Cooldown),
    Cooldown =:= 0,
    assertz(enemy_special_attack_available).

%enemy_reduce_special_attack_cooldown kasus mengurangi cooldown special attack enemy
enemy_reduce_special_attack_cooldown :-
    enemy_special_attack_cooldown(Cooldown),
    Cooldown > 0,
    NewCooldown is Cooldown - 1,
    retractall(enemy_special_attack_cooldown(_)),
    assertz(enemy_special_attack_cooldown(NewCooldown)),
    enemy_charge_special_attack.

%enemy_reduce_special_attack_cooldown kasus enemy special attack masih available (tidak memiliki cooldown)
enemy_reduce_special_attack_cooldown.

%boss_turn kasus boss berhasil dikalahkan
boss_turn :-
    boss_current_health(BossHealth),
    BossHealth =< 0,
    boss_name(BossName),
    write('You defeated '), write(BossName),nl,
    retractall(is_boss_battle),
    draw_win,
    nl,nl,
    write('     As how the old saying goes, good things go to those who triumph, you are now able to enter Sinyalisisville'),nl,
    write('You feel tremendous joy as you enter the gate to Sinyalisisville. People cheered as you walk through the main'),nl,
    write('road. The city is majestic and is better than the tales told by travellers. Seeing this beautiful sight, sometimes'),nl,
    write('makes people wonder; is life here as good as what it seems?'),nl,
    write('     Well, the answer would remain a mystery as the programmers are too lazy to make a sequel :D. Now shoo!'),nl,
    nl,nl,
    write('Type "quit." and press enter : '),
    read(X),
    halt.

%boss_turn 
boss_turn :-
    boss_current_health(BossHealth),
    boss_name(BossName),
    BossHealth > 0,
    write(BossName), write(' Hang up with '), write(BossHealth), write(' health left.'),nl,
    boss_action.

%boss_action menentukan tindakan boss pada gilirannya
boss_action :-  
                random(1,15,BossAction),
                boss_attack_action(BossAction),
                boss_special_attack_action(BossAction),
                boss_gust_action(BossAction),
                boss_healing_action(BossAction).

boss_attack_action(BossAction) :-
    BossAction >= 1,
    BossAction =< 7,
    boss_name(BossName),
    boss_attack(BossAttack),
    player_current_health(PlayerHealth),
    player_defense(PlayerDefense),
    DamageDealt is BossAttack - PlayerDefense,
    max_value(DamageDealt, 0, NewDamageDealt),!,
    PlayerNewHealth is PlayerHealth - NewDamageDealt,
    retractall(player_current_health(_)),
    assertz(player_current_health(PlayerNewHealth)),
    write(BossName), write(' deal '), write(NewDamageDealt), write(' damage to you'),nl,
    check_player_status,
    reduce_special_attack_cooldown.

boss_attack_action(_).

boss_special_attack_action(BossAction) :-
    boss_special_attack_available,
    BossAction >= 8,
    BossAction =< 11,
    boss_name(BossName),
    boss_attack(BossAttack),
    player_current_health(PlayerHealth),
    player_defense(PlayerDefense),
    DamageDealt is 2*BossAttack - PlayerDefense,
    max_value(DamageDealt, 0, NewDamageDealt),!,
    PlayerNewHealth is PlayerHealth - NewDamageDealt,
    write(BossName), write(' deal '), write(NewDamageDealt), write(' damage with special attack to you'),nl,
    retractall(boss_special_attack_available),
    retractall(boss_special_attack_cooldown(_)),
    retractall(player_current_health(_)),
    assertz(player_current_health(PlayerNewHealth)),
    assertz(boss_special_attack_cooldown(3)),
    check_player_status,
    reduce_special_attack_cooldown.

boss_special_attack_action(BossAction) :-
    BossAction >= 8,
    BossAction =< 11,
    \+ boss_special_attack_available,
    boss_action.

boss_special_attack_action(_).

boss_charge_special_attack :-
    boss_special_attack_cooldown(Cooldown),
    Cooldown =:= 0,
    assertz(boss_special_attack_available).

%boss_reduce_special_attack_cooldown kasus mengurangi cooldown special attack boss
boss_reduce_special_attack_cooldown :-
    boss_special_attack_cooldown(Cooldown),
    Cooldown > 0,
    NewCooldown is Cooldown - 1,
    retractall(boss_special_attack_cooldown(_)),
    assertz(boss_special_attack_cooldown(NewCooldown)),
    boss_charge_special_attack.

%boss_reduce_special_attack_cooldown kasus boss special attack masih available (tidak memiliki cooldown)
boss_reduce_special_attack_cooldown.


%boss_gust serangan boss yang mengakibatkan player kehilangan sejumlah potion
boss_gust_action(BossAction) :-
    BossAction >= 12,
    BossAction =< 14,
    boss_name(BossName),
    random(1,3,PotionID),
    potion_count(PotionID, CurrentPotionCount),
    min_value(1, CurrentPotionCount, PotionLost),
    NewPotionCount is (CurrentPotionCount - PotionLost),
    retract(potion_count(PotionID,_)),
    assertz(potion_count(PotionID,NewPotionCount)),
    write(BossName), write(' uses gust'),nl,
    write('Player loses '), write(PotionLost), write(' potion(s)'),nl,
    check_player_status,
    reduce_special_attack_cooldown.

boss_gust_action(_).

%boss_healing boss dapat memulihkan healthnya
boss_healing_action(BossAction) :- 
    BossAction =:= 15,
    boss_name(BossName),
    boss_current_health(CurrentHealth),
    boss_max_health(MaxHealth),
    CurrentHealth < MaxHealth,
    BossHealthLoss is MaxHealth - CurrentHealth,
    SkillHealAmount is (1/10*MaxHealth),
    min_value(BossHealthLoss, SkillHealAmount, BossHealAmount),
    NewBossHealth is (CurrentHealth + BossHealAmount),
    retractall(boss_current_health(_)),
    assertz(boss_current_health(NewBossHealth)),
    write(BossName), write(' heals himself for '), write(BossHealAmount), write(' health.'),nl,
    check_player_status,
    reduce_special_attack_cooldown.

boss_healing_action(BossAction) :-
    BossAction =:= 15,
    boss_current_health(CurrentHealth),
    boss_max_health(MaxHealth),
    CurrentHealth =:= MaxHealth,
    boss_action.

boss_healing_action(_).

check_player_status :-
    player_current_health(PlayerHealth),
    PlayerHealth =< 0,!,
    retractall(is_battle),
    retractall(game_start),
    draw_skull,
    nl,nl,
    write('     You have been devoured by the cruelty of this world. Many may try, but only few will succeed. You lost'),nl,
    write('your life as you journey through the wilderness. You may not see what lies within the gate of Sinyalisisville,'),nl,
    write('but at least you do not have to cope with the hardship of this life anymore. Requiescat in pace.'),nl,
    write('     Thank you for wasting a portion of your life by playing this game. Start this game again to continue'),nl,
    write('wasting your time.'),
    nl,nl,
    write('Type "quit." and press enter : '),
    read(X),
    halt.

check_player_status :-
    player_current_health(PlayerHealth),
    PlayerHealth > 0,
    write('Health Remaining : '), write(PlayerHealth),nl.


max_value(X,Y,Z) :-
    Y >= X,
    Z is Y.


max_value(X,Y,Z) :-
    X > Y,
    Z is X.

min_value(X,Y,Z) :-
    Y =< X,
    Z is Y.

min_value(X,Y,Z) :-
    X < Y,
    Z is X.