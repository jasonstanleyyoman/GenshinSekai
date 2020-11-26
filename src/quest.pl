:- dynamic(is_taking_quest/0).
% SLIME, GOBLIN, WOLF
:- dynamic(current_quest/3).
:- dynamic(quest_progress/3).
:- dynamic(current_quest_id/1).

current_quest_id(0).

% ID,GOLD,EXP
reward(1,500,4).
reward(2,600,5).
reward(3,650,6).
reward(4,700,7).
reward(5,800,8).
reward(6,800,9).
reward(7,900,10).
reward(8,950,11).
reward(9,980,12).
reward(10,1000,13).

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
    I<11,
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

add_quest_progress_slime :-
    quest_progress(A,B,C),
    retractall(quest_progress(A,B,C)),
    NewA is A+1,
    assertz(quest_progress(NewA,B,C)).

add_quest_progress_goblin :-
    quest_progress(A,B,C),
    retractall(quest_progress(A,B,C)),
    NewB is B+1,
    assertz(quest_progress(A,NewB,C)).

add_quest_progress_wolf :-
    quest_progress(A,B,C),
    retractall(quest_progress(A,B,C)),
    NewC is C+1,
    assertz(quest_progress(A,B,NewC)).

% ngecek quest uda kelar ato belom
check_quest_done :-
    quest_progress(A,B,C),
    current_quest_id(I),
    quest(I, J, K, L, M),
    A >= K,
    B >= L,
    C >= M,
    write('Congratulations! Your quest is done! Rewards have been sent to your inventory!'),nl,
    retract(is_taking_quest),
    retractall(quest_progress(_,_,_)),
    player_gold(PG),
    player_exp(PExp),
    retractall(player_gold(_)),
    retractall(player_exp(_)),
    reward(I,Gold,Exp),
    NewPG is (Gold + PG),
    NewExp is (PExp + Exp),
    assertz(player_gold(NewPG)),
    assertz(player_exp(NewExp)).
    
