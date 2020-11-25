:- dynamic(is_taking_quest/0).
% SLIME, GOBLIN, WOLF
:- dynamic(current_quest/3).
:- dynamic(quest_progress/3).
:- dynamic(current_quest_id/1).

current_quest_id(0).

% ID,GOLD,EXP
reward(1,500,10).
reward(2,600,20).
reward(3,650,25).
reward(4,700,30).
reward(5,800,40).
reward(6,800,45).
reward(7,900,55).
reward(8,950,70).
reward(9,980,80).
reward(10,1000,90).

% ID, NAME, SLIME, GOBLIN, WOLF
quest(1, 'Getting Started', 2,0,0).
quest(2, 'Beginner\'s Quest', 4,0,0).
quest(3, 'Warming Up', 5,0,0).
quest(4, 'Kill \'em All', 3,2,0).
quest(5, 'Training to be a Pro', 1,4,0).
quest(6, 'Killing Spree', 0,7,0).
quest(7, 'Continuing the Streak', 3,3,1).
quest(8, 'Going on a Rampage', 0,6,3).
quest(9, 'Being a God', 0,2,5).
quest(10, 'Resin Hell', 0,0,8).

take_quest :-
    \+ is_taking_quest,
    player_location(X,Y),
    guild(X,Y),
    assertz(is_taking_quest),
    current_quest_id(I),
    NewI is I+1,
    retract(current_quest_id(I)),
    assertz(current_quest_id(NewI)),
    assertz(quest_progress(0,0,0)).

check_quest :-
    is_taking_quest,
    current_quest_id(I),
    quest(I, J, K, L, M),
    write(J),nl,
    write('Slime : '),write(K),nl,
    write('Goblin : '),write(L),nl,
    write('Wolf : '),write(M),nl.