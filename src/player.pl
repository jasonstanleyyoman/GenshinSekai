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

player_level(30).

%level_up :-
