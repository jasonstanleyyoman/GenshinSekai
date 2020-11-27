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

%enemy_base     ID, Base Status
enemy_base_attack(1,30).
enemy_base_attack(2,50).
enemy_base_attack(3,70).

enemy_base_defense(1,7).
enemy_base_defense(2,17).
enemy_base_defense(3,25).

enemy_base_max_health(1,30).
enemy_base_max_health(2,35).
enemy_base_max_health(3,40).


max_health_multiplier(1.1).

attack_multiplier(1.1).

defense_multiplier(1.1).

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
is_defeated :- 
                enemy_current_health(X),
                X =< 0.

%set_enemy_level menetapkan level enemy sesuai level player
set_enemy_level :-  
                    retractall(enemy_level(_)),
                    player_level(X),
                    asserta(enemy_level(X)).



