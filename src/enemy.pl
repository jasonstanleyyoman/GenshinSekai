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

max_health_multiplier(1,100).
max_health_multiplier(2,110).
max_health_multiplier(3,120).

attack_multiplier(1,1).
attack_multiplier(2,1.3).
attack_multiplier(3,1.6).

defense_multiplier(1,0.8).
defense_multiplier(2,1).
defense_multiplier(3,1.2).

%Rules
%exp_gained, depends on enemy type(different multipliers)
exp_gained(ExpGained) :-    
                            enemy_id(slime),
                            enemy_level(EnemyLevel),
                            ExpGained is 1.1*EnemyLevel.

exp_gained(ExpGained) :-    
                            enemy_id(wolf),
                            enemy_level(EnemyLevel),
                            ExpGained is 1.3*EnemyLevel.

exp_gained(ExpGained) :-    
                            enemy_id(goblin),
                            enemy_level(EnemyLevel),
                            ExpGained is 1.5*EnemyLevel.

%is_defeated mengecek apakah enemy berhasil dikalahkan
is_defeated :- 
                enemy_current_health(X),
                X =< 0.

%set_enemy_level menetapkan level enemy sesuai level player
set_enemy_level :-  
                    retractall(enemy_level(_)),
                    player_level(X),
                    asserta(enemy_level(X)).



