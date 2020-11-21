%enemy(id, name)
enemy(1, Slime).
enemy(2, Wolf).
enemy(3, Goblin).

%spawned enemy id in battle
:- dynamic(enemy_id/1).

:- dynamic(enemy_level/1).

:- dynamic(enemy_current_health/1).
:- dynamic(enemy_max_health/1).
:- dynamic(enemy_attack/1).
:- dynamic(enemy_defense/1).

%Rules
%exp_gained, depends on enemy type(different multipliers)
exp_gained(X) :-    enemy_id(slime),
                    enemy_level(Y),
                    X is 1.1*Y.

exp_gained(X) :-    enemy_id(wolf),
                    enemy_level(Y),
                    X is 1.3*Y.

exp_gained(X) :-    enemy_id(goblin),
                    enemy_level(Y),
                    X is 1.5*Y.

%is_defeated mengecek apakah enemy berhasil dikalahkan
is_defeated :- enemy_current_health(X),
                X =< 0.

%set_enemy_level menetapkan level enemy sesuai level player
set_enemy_level :-  ['player.pl'],
                    retractall(enemy_level(_)),
                    player_level(X),
                    asserta(enemy_level(X)).



