:- dynamic(is_taking_quest/0).
% SLIME, GOBLIN, WOLF
:- dynamic(current_quest/3).
:- dynamic(quest_progress/3).
:- dynamic(current_quest_id/1).

current_quest_id(0).

% ID,GOLD,EXP
reward(1,500,10),
reward(2,600,20),
reward(3,650,25),
reward(4,700,30),
reward(5,800,40),
reward(6,800,45),
reward(7,900,55),
reward(8,950,70),
reward(9,980,80),
reward(10,1000,90).

% ID, NAME, SLIME, GOBLIN, WOLF
quest(1, "Nama Quest", 2,0,0).
quest(2, "Nama Quest", 4,0,0).
quest(3, "Nama Quest", 5,0,0).
quest(4, "Nama Quest", 3,2,0).
quest(5, "Nama Quest", 1,4,0).
quest(6, "Nama Quest", 0,7,0).
quest(7, "Nama Quest", 3,3,1).
quest(8, "Nama Quest", 0,6,3).
quest(9, "Nama Quest", 0,2,5).
quest(10, "Nama Quest", 0,0,8).

take_quest :-
    \+ is_taking_quest,
    assertz(is_taking_quest),
    current_quest_id(I),
    NewI is I+1,
    retract(current_quest_id(I)),
    assertz(current_quest_id(NewI)),
    assertz(quest_progress(0,0,0)).