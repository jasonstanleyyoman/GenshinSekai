:- dynamic(is_battle/0).
:- dynamic(special_attack_available/0).
:- dynamic(special_attack_cooldown/1).

start_battle(ID) :-
    retractall(is_battle),
    retractall(enemy_current_health(_)),
    retractall(enemy_max_health(_)),
    retractall(enemy_attack(_)),
    retractall(enemy_defense(_)),
    assertz(is_battle),
    enemy(ID, EnemyType),
    write('Ketemu '), write(EnemyType),nl,
    enemy_level(EnemyLevel),
    max_health_multiplier(ID, HealthMult),
    attack_multiplier(ID, AttackMult),
    defense_multiplier(ID, DefenseMult),
    Health is EnemyLevel * HealthMult,
    Attack is EnemyLevel * AttackMult,
    Defense is EnemyLevel * DefenseMult,
    retractall(is_battle),
    assertz(enemy_id(ID)),
    assertz(is_battle),
    assertz(enemy_current_health(Health)),
    assertz(enemy_max_health(Health)),
    assertz(enemy_attack(Attack)),
    assertz(enemy_defense(Defense)).
    
attack :-
    player_attack(Attack),
    enemy_current_health(EnemyHealth),
    enemy_defense(EnemyDefense),
    NewEnemyHealth is (EnemyHealth - Attack + EnemyDefense),
    retractall(enemy_current_health(_)),
    assertz(enemy_current_health(NewEnemyHealth)),
    enemy_turn.

enemy_turn :-
    enemy_current_health(EnemyHealth),
    enemy_id(ID),
    enemy(ID, EnemyName),
    EnemyHealth > 0,!,
    write('You Belum defeat '), write(EnemyName).

enemy_turn :-
    enemy_current_health(EnemyHealth),
    enemy_id(ID),
    enemy(ID, EnemyName),
    EnemyHealth =< 0, !,
    write('You defeat '), write(EnemyName).

%attack :-

%special_attack :-

%use_potion :-

%run :-
