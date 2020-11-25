
% Fakta
mapsize(25,25).


barrier(1,5).
barrier(1,14).
barrier(2,5).
barrier(2,14).
barrier(3,5).
barrier(3,14).
barrier(4,5).
barrier(4,14).
barrier(4,19).
barrier(5,8).
barrier(5,12).
barrier(5,13).
barrier(5,14).
barrier(5,19).
barrier(6,8).
barrier(6,19).
barrier(7,8).
barrier(7,19).
barrier(8,1).
barrier(8,2).
barrier(8,3).
barrier(8,4).
barrier(8,5).
barrier(8,6).
barrier(8,7).
barrier(8,8).
barrier(8,9).
barrier(8,10).
barrier(8,11).
barrier(8,12).
barrier(8,13).
barrier(8,14).
barrier(8,15).
barrier(8,16).
barrier(8,17).
barrier(8,18).
barrier(8,19).
barrier(9,7).
barrier(10,7).
barrier(11,7).
barrier(11,12).
barrier(11,13).
barrier(11,14).
barrier(11,15).
barrier(11,16).
barrier(11,17).
barrier(11,18).
barrier(11,19).
barrier(11,20).
barrier(11,21).
barrier(11,22).
barrier(11,23).
barrier(12,7).
barrier(12,12).
barrier(15,1).
barrier(15,2).
barrier(15,3).
barrier(15,4).
barrier(15,5).
barrier(15,6).
barrier(15,7).
barrier(15,8).
barrier(15,9).
barrier(15,10).
barrier(15,11).
barrier(15,12).
barrier(15,13).
barrier(15,14).
barrier(15,15).
barrier(15,16).
barrier(15,17).
barrier(15,18).
barrier(15,19).
barrier(17,5).
barrier(17,6).
barrier(17,7).
barrier(17,8).
barrier(17,9).
barrier(17,10).
barrier(17,11).
barrier(17,12).
barrier(17,13).
barrier(17,14).
barrier(17,15).
barrier(17,16).
barrier(17,17).
barrier(17,18).
barrier(17,19).
barrier(17,20).
barrier(17,21).
barrier(17,22).
barrier(17,23).
barrier(18,5).
barrier(18,13).
barrier(19,5).
barrier(19,13).
barrier(19,21).
barrier(20,7).
barrier(20,10).
barrier(20,11).
barrier(20,12).
barrier(20,13).
barrier(20,21).
barrier(21,7).
barrier(21,21).
barrier(22,1).
barrier(22,2).
barrier(22,3).
barrier(22,4).
barrier(22,5).
barrier(22,6).
barrier(22,7).
barrier(22,8).
barrier(22,9).
barrier(22,10).
barrier(22,11).
barrier(22,12).
barrier(22,13).
barrier(22,14).
barrier(22,15).
barrier(22,16).
barrier(22,17).
barrier(22,18).
barrier(22,19).
barrier(22,20).
barrier(22,21).

shop(7,1).
shop(9,1).
shop(18,12).

guild(1,6).
guild(9,6).
guild(21,1).

home(1,4).
home(14,1).
home(16,1).

slime_zone(2).
slime_zone(3).
slime_zone(4).
slime_zone(5).
slime_zone(6).
slime_zone(7).
slime_zone(8).

wolf_zone(10).
wolf_zone(11).
wolf_zone(12).
wolf_zone(13).
wolf_zone(14).
wolf_zone(15).

goblin_zone(17).
goblin_zone(18).
goblin_zone(19).
goblin_zone(20).
goblin_zone(21).
goblin_zone(22).

danger_zone(24).

boss(23,1).

% Top Fence
drawfence(I,J) :- 
	mapsize(_,A),
	I = 0,
	J > 0,
	J < A-1,
	write('X '),
	NewJ is J+1,
	drawfence(I, NewJ).

% Left Fence
drawfence(I,J) :-
	mapsize(A,_),
	J = 0,
	I < A,
	write('X '),
	NewJ is J+1,
	drawfence(I, NewJ).

% Right Fence
drawfence(I,J) :-
	mapsize(A,B),
	J > B-2,
	I < A,
	write('X'),
	nl,
	NewI is I+1,
	drawfence(NewI, 0).
	
% Bottom Fence
drawfence(I,J) :-
	I > 23,
	J > 0,
	J < 24,
	write('X '),
	NewJ is J+1,
	drawfence(I, NewJ).

% Draw Inside
drawfence(I,J) :-
	I > 0,
	I < 24,
	J > 0,
	J < 24,
	\+ shop(I,J),
	\+ home(I,J),
	\+ guild(I,J),
	\+ barrier(I,J),
	\+ boss(I,J),
	\+ player_location(I,J),
	write('_ '),
	NewJ is J+1,
	drawfence(I, NewJ).

% Draw Inside
drawfence(I,J) :-
	I > 0,
	I < 24,
	J > 0,
	J < 24,
	\+ playerposition(I,J),
	shop(I,J),
	player_location(I,J),
	write('P '),
	NewJ is J+1,
	drawfence(I, NewJ).

drawfence(I,J) :-
	I > 0,
	I < 24,
	J > 0,
	J < 24,
	shop(I,J),
	\+ player_location(I,J),
	write('S '),
	NewJ is J+1,
	drawfence(I, NewJ).

% Draw Inside
drawfence(I,J) :-
	I > 0,
	I < 24,
	J > 0,
	J < 24,
	\+ playerposition(I,J),
	home(I,J),
	player_location(I,J),
	write('P '),
	NewJ is J+1,
	drawfence(I, NewJ).

drawfence(I,J) :-
	I > 0,
	I < 24,
	J > 0,
	J < 24,
	home(I,J),
	\+ player_location(I,J),
	write('H '),
	NewJ is J+1,
	drawfence(I, NewJ).

% Draw Inside
drawfence(I,J) :-
	I > 0,
	I < 24,
	J > 0,
	J < 24,
	\+ playerposition(I,J),
	guild(I,J),
	player_location(I,J),
	write('P '),
	NewJ is J+1,
	drawfence(I, NewJ).

drawfence(I,J) :-
	I > 0,
	I < 24,
	J > 0,
	J < 24,
	guild(I,J),
	\+ player_location(I,J),
	write('Q '),
	NewJ is J+1,
	drawfence(I, NewJ).

% Draw Inside
drawfence(I,J) :-
	I > 0,
	I < 24,
	J > 0,
	J < 24,
	barrier(I,J),
	write('X '),
	NewJ is J+1,
	drawfence(I, NewJ).

% Draw Inside
drawfence(I,J) :-
	I > 0,
	I < 24,
	J > 0,
	J < 24,
	\+ playerposition(I,J),
	boss(I,J),
	write('B '),
	NewJ is J+1,
	drawfence(I, NewJ).

% Draw Inside
drawfence(I,J) :-
	I > 0,
	I < 24,
	J > 0,
	J < 24,
	player_location(I,J),
	\+ shop(I,J),
	\+ home(I,J),
	\+ guild(I,J),
	\+ barrier(I,J),
	\+ boss(I,J),
	write('P '),
	NewJ is J+1,
	drawfence(I, NewJ).

drawmap :-
	drawfence(0,0).

w :-
	\+ is_battle,
	player_location(I,J),
	NewI is I-1,
	NewI =\= 0,
	\+ barrier(NewI,J),
	retract(player_location(I,J)),
	assertz(player_location(NewI,J)),
	ecounter_enemy.
w :-
	is_battle,
	write('You are battling'),nl.

a :-
	\+ is_battle,
	player_location(I,J),
	NewJ is J-1,
	NewJ =\= 0,
	\+ barrier(I,NewJ),
	retract(player_location(I,J)),
	assertz(player_location(I,NewJ)),
	ecounter_enemy.
a :-
	is_battle,
	write('You are battling'),nl.
s :-
	\+ is_battle,
	player_location(I,J),
	NewI is I+1,
	NewI =\= 24,
	\+ barrier(NewI,J),
	retract(player_location(I,J)),
	assertz(player_location(NewI,J)),
	ecounter_enemy.
s :-
	is_battle,
	write('You are battling'),nl.


d :-
	\+ is_battle,
	player_location(I,J),
	NewJ is J+1,
	NewJ =\= 24,
	\+ barrier(I,NewJ),
	retract(player_location(I,J)),
	assertz(player_location(I,NewJ)),
	ecounter_enemy.
d :-
	is_battle,
	write('You are battling'),nl.
ecounter_enemy :-
	player_location(I,J),
	\+ shop(I,J),
	\+ home(I,J),
	\+ guild(I,J),
	\+ barrier(I,J),
	\+ boss(I,J),
	random(1,10, EcounterChance),
	check_ecounter(EcounterChance, I).

ecounter_enemy :-
	player_location(I,J),
	\+ shop(I,J),
	\+ home(I,J),
	\+ guild(I,J),
	\+ barrier(I,J),
	\+ boss(I,J),
	random(1,10, EcounterChance),
	check_ecounter(EcounterChance, I).

ecounter_enemy :-
	player_location(I,J),
	\+ shop(I,J),
	\+ home(I,J),
	\+ guild(I,J),
	\+ barrier(I,J),
	\+ boss(I,J),
	random(1,10, EcounterChance),
	check_ecounter(EcounterChance, I).

check_ecounter(Chance, I) :-
	Chance < 4, !,
	slime_zone(I),
	start_battle(1).

check_ecounter(Chance, I) :-
	Chance < 4, !,
	wolf_zone(I),
	start_battle(2).

check_ecounter(Chance, I) :-
	Chance < 4, !,
	goblin_zone(I),
	start_battle(3).

check_ecounter(_, _) :-
	write('Hahaha beruntung anda tidak menemukan musuh.'),nl.
	

% interact :-