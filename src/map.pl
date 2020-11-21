# Fakta
mapsize(25,25).

# Right Border
draw_point(X, Y) :- mapsize(W, H),
					X =:= W + 1,
					Y =< H + 1,
					write('X '), nl,
					NewY is Y+1,
					draw_point(0, NewY).
		
# Left Border		
draw_point(X, Y) :- mapsize(_, H),
					X =:= 0,
					Y =< H+1,
					write('X '),
					NewX is X+1,
					draw_point(NewX, Y).
				
# Top Border				
draw_point(X, Y) :- mapsize(W, _),
					X < W + 1,
					X > 0,
					Y =:= 0,
					write('X '),
					NewX is X+1,
					draw_point(NewX, Y).
					
# Bottom Border				
draw_point(X, Y) :- mapsize(W, H),
					X < W + 1,
					X > 0,
					Y =:= H + 1,
					write('X '),
					NewX is X+1,
					draw_point(NewX, Y).

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

shop(8,2).
shop(10,2).
shop(19,13).

guild(2,7).
guild(10,7).
guild(22,2).

home(2,5).
home(15,2).
home(17,2).

wolf_zone(2).
wolf_zone(3).
wolf_zone(4).
wolf_zone(5).
wolf_zone(6).
wolf_zone(7).
wolf_zone(8).

slime_zone(10).
slime_zone(11).
slime_zone(12).
slime_zone(13).
slime_zone(14).
slime_zone(15).

goblin_zone(17).
goblin_zone(18).
goblin_zone(19).
goblin_zone(20).
goblin_zone(21).
goblin_zone(22).

danger_zone(24).

map :-

w :-

a :-

s :-

d :-

interact :-


draw_map :-
