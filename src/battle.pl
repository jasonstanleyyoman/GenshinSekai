:- dynamic(is_battle/0).
:- dynamic(special_attack_available/0).
:- dynamic(special_attack_cooldown/1).
:- dynamic(enemy_special_attack_available/0).
:- dynamic(enemy_special_attack_cooldown/1).


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
    write('Ketemu '), write(EnemyType),nl,
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
    assertz(enemy_special_attack_available).
    
attack :-
    is_battle,
    player_attack(Attack),
    enemy_current_health(EnemyHealth),
    enemy_defense(EnemyDefense),
    DamageDealt is Attack - EnemyDefense,
    NewEnemyHealth is (EnemyHealth - DamageDealt),
    write('You deal '), write(DamageDealt), write(' damage!.'),nl,
    retractall(enemy_current_health(_)),
    assertz(enemy_current_health(NewEnemyHealth)),  
    enemy_turn,
    enemy_reduce_special_attack_cooldown. 
attack :-
    write('You are not in battle.'),nl.

special_attack:-
    is_battle,
    special_attack_available,!,
    player_attack(PlayerAttack),
    NewPlayerAttack is PlayerAttack * 2,
    enemy_current_health(EnemyCurrentHealth),
    enemy_defense(EnemyDefense),
    DamageDealt is NewPlayerAttack - EnemyDefense,
    NewEnemyCurrentHealth is EnemyCurrentHealth - DamageDealt,
    write('You deal '), write(DamageDealt), write(' damage with special attack.'), nl,
    retractall(special_attack_available),
    retractall(special_attack_cooldown(_)),
    retractall(enemy_current_health(_)),
    assertz(enemy_current_health(NewEnemyCurrentHealth)),
    assertz(special_attack_cooldown(3)),
    enemy_turn,
    enemy_reduce_special_attack_cooldown.

special_attack:-
    is_battle,
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
    write('You run away successfully'),nl.

run_succeed(RunChance) :-
    RunChance >= 8,
    RunChance =< 10,
    write('You failed to run away '),nl,
    enemy_turn,
    enemy_reduce_special_attack_cooldown.

%enemy_turn kasus enemy berhasil dikalahkan
enemy_turn :-
    enemy_current_health(EnemyHealth),
    enemy_id(ID),
    enemy(ID, EnemyName),
    EnemyHealth =< 0,
    write('You defeat '), write(EnemyName),nl,
    exp_gained(ExpGained),
    player_exp(PlayerExp),
    NewPlayerExp is PlayerExp + ExpGained,
    write('You gain '), write(ExpGained), write(' EXP'),nl,
    retractall(player_exp(_)),
    assertz(player_exp(NewPlayerExp)),
    retractall(is_battle),
    level_up.

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
    max_value(DamageDealt, 0, NewDamageDealt),!,
    PlayerNewHealth is PlayerHealth - NewDamageDealt,
    retractall(player_current_health(_)),
    assertz(player_current_health(PlayerNewHealth)),
    write(EnemyName), write(' deal '), write(NewDamageDealt), write(' damage to you'),nl,
    check_player_status,
    reduce_special_attack_cooldown.

enemy_special_attack :-
    enemy_id(ID),
    enemy(ID, EnemyName),
    enemy_attack(EnemyAttack),
    player_current_health(PlayerHealth),
    player_defense(PlayerDefense),
    DamageDealt is 2*EnemyAttack - PlayerDefense,
    max_value(DamageDealt, 0, NewDamageDealt),!,
    PlayerNewHealth is PlayerHealth - NewDamageDealt,
    write(EnemyName), write(' deal '), write(NewDamageDealt), write(' damage with special attack to you'),nl,
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

check_player_status :-
    player_current_health(PlayerHealth),
    PlayerHealth =< 0,
    write('You die'),nl.

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



%attack :-

%special_attack :-

%use_potion :-

%run :-
