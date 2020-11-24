/* File : inventory.pl */
/* Inventory system dari player */

/* -----[ INVENTORY ] ----- */
% ----- Equipment Count -----
% Base selalu 3 karena minimal ada weapon,
% armor, dan accesory
:- dynamic(equipment_count/1).
equipment_count(3).
update_equip_count :-
    update_pot,
    potion_count(1, A),
    potion_count(2, B),
    potion_count(3, C),
    Y is 3+A+B+C,

    retract(equipment_count(N)),
    assertz(equipment_count(Y)).

% ----- Print Inventory -----
inventory :-
    write('Your inventory:'), nl,
    weapon(WeaponName, _, _, _, _),
    write('1 '), write(WeaponName), nl,
    armor(ArmorName, _, _, _, _),
    write('1 '), write(ArmorName), nl,
    accessory(AccName, _, _, _, _),
    write('1 '), write(AccName), nl,

    update_pot,
    print_potion.

    
/* -----[ EQUIPMENT ] ----- */
% ----- List -----
% Job ID :  1 - Swordsman
%           2 - Archer
%           3 - Sorcerer
% Details : ITEM ID, NAME, JOB ID, HEALTH, ATTACK, DEFENSE
:- dynamic(weapon/6).
:- dynamic(armor/6).
:- dynamic(accessory/6).
weapon(0, 'Wooden Sword', 1, 0, 0, 0).
armor(0, 'Iron Armor', 1, 0, 0, 0).
accessory(0, 'Wood Talisman', 1, 0, 0, 0).

/* -----[ POTIONS ] ----- */
% ----- List -----
% Details : ID, HEALTH REGAINED
potion(1, 300).
potion(1, 300).
potion(1, 300).
%potion(2, 600).
potion(3, 900).

potion_name(1, 'Small Potion (300 HP)').
potion_name(2, 'Medium Potion (600 HP)').
potion_name(3, 'Large Potion (900 HP)').

% ----- Commands -----
% Details : ID, COUNT
:- dynamic(potion_count/2).
potion_count(1, 0).
potion_count(2, 0).
potion_count(3, 0).

update_pot :-
    between(1, 3, PotionID),
    findall(PotionID, potion(PotionID, _), PotList),
    length(PotList, Count), 
    retract(potion_count(PotionID, _)),
    asserta(potion_count(PotionID, Count)),
    PotionID = 3.

print_potion :-
    between(1, 3, PotionID), 
    potion_count(PotionID, Count),
    potion_name(PotionID, PotName), 
    print_potion(Count, PotName),
    PotionID = 3.

print_potion(0, PotName):- !.
print_potion(Count, PotName) :-
    write(Count), write(' '), write(PotName), nl.
    
