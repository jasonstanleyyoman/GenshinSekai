%enemy(id, name)
enemy(1, 'Slime').
enemy(2, 'Wolf').
enemy(3, 'Goblin').

%spawned enemy id in battle
:- dynamic(enemy_id/1).

:- dynamic(enemy_level/1).

:- dynamic(enemy_current_health/1).
:- dynamic(enemy_max_health/1).
:- dynamic(enemy_attack/1).
:- dynamic(enemy_defense/1).

max_health_multiplier(1,20).
max_health_multiplier(2,30).
max_health_multiplier(3,50).

attack_multiplier(1,1).
attack_multiplier(2,1.3).
attack_multiplier(3,1.6).

defense_multiplier(1,0.8).
defense_multiplier(2,1).
defense_multiplier(3,1.2).

%Rules
%exp_gained, depends on enemy type(different multipliers)

exp_gained(X) :- 
    enemy_id(ID),
    ID =:= 1,
    enemy_level(Y),
    X is 2*Y.
exp_gained(X) :- 
    enemy_id(ID),
    ID =:= 2,
    enemy_level(Y),
    X is 4*Y.
exp_gained(X) :- 
    enemy_id(ID),
    ID =:= 3,
    enemy_level(Y),
    X is 6*Y.

%is_defeated mengecek apakah enemy berhasil dikalahkan
is_defeated :- enemy_current_health(X),
                X =< 0.

%set_enemy_level menetapkan level enemy sesuai level player
set_enemy_level :-  retractall(enemy_level(_)),
                    player_level(X),
                    asserta(enemy_level(X)).



