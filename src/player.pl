:- dynamic(player_location/2).
:- dynamic(player_level/1).
:- dynamic(player_current_health/1).
:- dynamic(player_max_health/1).
:- dynamic(player_attack/1).
:- dynamic(player_defense/1).
:- dynamic(player_exp/1).
:- dynamic(player_gold/1).
:- dynamic(player_job/1).

exp_required(1,100).
exp_required(2,100).
exp_required(3,100).
exp_required(4,100).
exp_required(5,100).
exp_required(6,100).
exp_required(7,100).
exp_required(9,100).
exp_required(10,100).
exp_required(11,100).
exp_required(12,100).
exp_required(13,100).
exp_required(14,100).
exp_required(15,100).
exp_required(16,100).
exp_required(17,100).
exp_required(18,100).

level_up :-
    player_level(CurrentLevel), !,
    player_exp(CurrentExp), !,
    exp_required(CurrentLevel, ExpRequired), !,
    CurrentExp >= ExpRequired,
    retractall(player_level(_)),
    NewLevel is CurrentLevel + 1,
    assertz(player_level(NewLevel)),
    retractall(player_exp(_)),
    NewPlayerExp is CurrentExp - ExpRequired,
    assertz(player_exp(NewPlayerExp)),
    player_max_health(CurrentMaxHealth),
    retractall(player_max_health(_)),
    NewPlayerMaxHealth is NewLevel * 100,
    assertz(player_max_health(NewPlayerMaxHealth)),
    player_current_health(CurrentHealth),
    retractall(player_current_health(_)),
    NewPlayerCurrentHealth is (NewPlayerMaxHealth - CurrentMaxHealth + CurrentHealth),
    assertz(player_current_health(NewPlayerCurrentHealth)),
    set_enemy_level,
    write('Congratulation you ascend to Level '), write(NewLevel),nl.
    
