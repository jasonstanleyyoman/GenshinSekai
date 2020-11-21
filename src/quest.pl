:- dynamic(is_taking_quest/0).
% SLIME, GOBLIN, WOLF
:- dynamic(current_quest/3).
:- dynamic(quest_progress/3).
:- dynamic(current_quest_id/1).
% GOLD,EXP
:- dynamic(reward/2).

% ID, NAME, SLIME, GOBLIN, WOLF
quest(1, "Beginner", 2,1,1).
quest(2, "Beginner", 2,1,1).
quest(2, "Beginner", 2,1,1).


take_quest :-
