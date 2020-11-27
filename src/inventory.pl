/* File : inventory.pl */
/* Inventory system dari player */

/*
% Testing Purposes
:- dynamic(player_max_health/1).
:- dynamic(player_attack/1).
:- dynamic(player_defense/1).
player_max_health(10).
player_attack(10).
player_defense(10).
*/

/* -----[ INVENTORY ] ----- */
% ----- Equipment Count -----
:- dynamic(inventory_count/1).
inventory_count(0).
update_inventory:-
    %update_pot,
    potion_count(1, A),
    potion_count(2, B),
    potion_count(3, C),

    update_equip,
    equip_count(D),

    Y is A+B+C+D,

    retract(inventory_count(_)),
    assertz(inventory_count(Y)).

% ----- Print Inventory -----
inventory :-
    update_inventory,
    write('Your inventory:'), nl,
    print_equip,
    print_potion.

    
/* -----[ EQUIPMENT ] ----- */
% ----- List -----
% Job ID :  1 - Swordsman
%           2 - Archer
%           3 - Sorcerer
:- dynamic(equip_count/1).
equip_count(3).

% Details : ITEM ID, NAME, JOB ID, HEALTH, ATTACK, DEFENSE, STATUS
% Status :  0 - Unequipped
%           1 - Equipped
%           2 - Disabled (Item Removed)
:- dynamic(weapon/7).
:- dynamic(armor/7).
:- dynamic(accessory/7).
/*
weapon(0, 'Wooden Sword', 1, 2, 2, 2, 0).
armor(0, 'Iron Armor', 1, 5, 5, 5, 0).
accessory(0, 'Wood Talisman', 1, 3, 3, 3, 0).
*/

% ----- Commands -----
% Count Equipment
update_equip :- 
    updateWeapon(A), updateArmor(B), updateAcc(C),
    Count is A+B+C,

    retract(equip_count(_)), asserta(equip_count(Count)).

updateWeapon(Count) :-
    weapon(_, _, _, _, _, _, Status),
    Status == 2 *-> Count = 0 ; Count = 1.

updateArmor(Count) :-
    armor(_, _, _, _, _, _, Status),
    Status == 2 *-> Count = 0 ; Count = 1.

updateAcc(Count) :-
    accessory(_, _, _, _, _, _, Status),
    Status == 2 *-> Count = 0 ; Count = 1.

% Equipment Information
print_equip :-
    weapon(_, _, _, _, _, _, Weapon), armor(_, _, _, _, _, _, Armor), accessory(_, _, _, _, _, _, Acc),
    print_weapon(Weapon), print_armor(Armor), print_acc(Acc).

print_weapon(2) :- !.
print_weapon(_) :-
   weapon(_, Name, _, _, _, _, _),
   write('1 '), write(Name), nl.

print_armor(2) :- !.
print_armor(_) :-
   armor(_, Name, _, _, _, _, _),
   write('1 '), write(Name), nl.

print_acc(2) :- !.
print_acc(_) :-
   accessory(_, Name, _, _, _, _, _),
   write('1 '), write(Name), nl.

% Inventory Management
remove :-
    write('To remove your weapon, write removeWeapon.'), nl,
    write('               armor, write removeArmor.'), nl,
    write('               accessory, write removeAcc.'), nl,
    write('               potion, write removePot.'), nl.

removeWeapon :-
    weapon(_, _, _, _, _, _, Status),
    Status == 1 *-> 
        write('You are currently equipping your equipment.'), nl,
        write('If you want to remove your equipment, uneqeuip it first.'), nl
    ; weapon(_, _, _, _, _, _, Status),
    Status == 2 *-> 
        write('You already removed your equipment.'), nl
    ;  weapon(Item, ItemName, JobID, Health, Attack, Defense, _),
        retract(weapon(_, _, _, _, _, _, _)),
        asserta(weapon(Item, ItemName, JobID, Health, Attack, Defense, 2)),

        write('You have succesfully removed your equipment.').

removeArmor :-
    armor(_, _, _, _, _, _, Status),
    Status == 1 *-> 
        write('You are currently equipping your equipment.'), nl,
        write('If you want to remove your equipment, uneqeuip it first.'), nl
    ; armor(_, _, _, _, _, _, Status),
    Status == 2 *-> 
        write('You already removed your equipment.'), nl
    ;  armor(Item, ItemName, JobID, Health, Attack, Defense, _),
        retract(armor(_, _, _, _, _, _, _)),
        asserta(armor(Item, ItemName, JobID, Health, Attack, Defense, 2)),
        write('You have succesfully removed your equipment.').

removeAcc :-
    accessory(_, _, _, _, _, _, Status),
    Status == 1 *-> 
        write('You are currently equipping your equipment.'), nl,
        write('If you want to remove your equipment, uneqeuip it first.'), nl
    ; accessory(_, _, _, _, _, _, Status),
    Status == 2 *-> 
        write('You already removed your equipment.'), nl
    ;  accessory(Item, ItemName, JobID, Health, Attack, Defense, _),
        retract(accessory(_, _, _, _, _, _, _)),
        asserta(accessory(Item, ItemName, JobID, Health, Attack, Defense, 2)),
        write('You have succesfully removed your equipment.').

% Equip System 
equip :- 
    write('To equip your weapon please write equipWeapon.'), nl,
    write('         your armor please write equipArmor.'), nl,
    write('         your accessory please write equipAcc.'), nl.

equipWeapon :-
    weapon(_, _, _, _, _, _, Status),
    Status == 1 *->
        write('You already equipped your equipment.'), nl
    ; weapon(_, _, _, _, _, _, Status),
    Status == 2 *->
        write('You have no equipment because you removed your weapon.'), nl,
        write('To obtain an equipment, please go to the shop.'), nl
    ; weapon(Item, ItemName, JobID, Health, Attack, Defense, _),
        retract(weapon(_, _, _, _, _, _, _)),
        asserta(weapon(Item, ItemName, JobID, Health, Attack, Defense, 1)),

        % Update Stats Player
        player_defense(Def), player_attack(Atk), player_max_health(HP),
        UpdatedDef is Def + Defense,
        UpdatedAtk is Atk + Attack,
        UpdatedHealth is HP + Health,
        
        retract(player_defense(_)), retract(player_max_health(_)), retract(player_attack(_)),
        asserta(player_defense(UpdatedDef)), asserta(player_max_health(UpdatedHealth)), asserta(player_attack(UpdatedAtk)),

        write('You have succesfully equipped your equipment.'), nl,
        write('----- [ PLAYER STATUS UPDATED ] -----'), nl,
        write('Health : '), write(UpdatedHealth), nl,
        write('Attack : '), write(UpdatedAtk), nl,
        write('Defense : '), write(UpdatedDef), nl.

equipArmor :-
    armor(_, _, _, _, _, _, Status),
    Status == 1 *->
        write('You already equipped your equipment.'), nl
    ; armor(_, _, _, _, _, _, Status),
    Status == 2 *->
        write('You have no equipment because you removed your armor.'), nl,
        write('To obtain an equipment, please go to the shop.'), nl
    ; armor(Item, ItemName, JobID, Health, Attack, Defense, _),
        retract(armor(_, _, _, _, _, _, _)),
        asserta(armor(Item, ItemName, JobID, Health, Attack, Defense, 1)),

        % Update Stats Player
        player_defense(Def), player_attack(Atk), player_max_health(HP),
        UpdatedDef is Def + Defense,
        UpdatedAtk is Atk + Attack,
        UpdatedHealth is HP + Health,
        
        retract(player_defense(_)), retract(player_max_health(_)), retract(player_attack(_)),
        asserta(player_defense(UpdatedDef)), asserta(player_max_health(UpdatedHealth)), asserta(player_attack(UpdatedAtk)),

        write('You have succesfully equipped your equipment.'), nl,
        write('----- [ PLAYER STATUS UPDATED ] -----'), nl,
        write('Health : '), write(UpdatedHealth), nl,
        write('Attack : '), write(UpdatedAtk), nl,
        write('Defense : '), write(UpdatedDef), nl.

equipAcc :-
    accessory(_, _, _, _, _, _, Status),
    Status == 1 *->
        write('You already equipped your equipment.'), nl
    ; accessory(_, _, _, _, _, _, Status),
    Status == 2 *->
        write('You have no equipment because you removed your accessory.'), nl,
        write('To obtain an equipment, please go to the shop.'), nl
    ; accessory(Item, ItemName, JobID, Health, Attack, Defense, _),
        retract(accessory(_, _, _, _, _, _, _)),
        asserta(accessory(Item, ItemName, JobID, Health, Attack, Defense, 1)),

        % Update Stats Player
        player_defense(Def), player_attack(Atk), player_max_health(HP),
        UpdatedDef is Def + Defense,
        UpdatedAtk is Atk + Attack,
        UpdatedHealth is HP + Health,
        
        retract(player_defense(_)), retract(player_max_health(_)), retract(player_attack(_)),
        asserta(player_defense(UpdatedDef)), asserta(player_max_health(UpdatedHealth)), asserta(player_attack(UpdatedAtk)),

        write('You have succesfully equipped your equipment.'), nl,
        write('----- [ PLAYER STATUS UPDATED ] -----'), nl,
        write('Health : '), write(UpdatedHealth), nl,
        write('Attack : '), write(UpdatedAtk), nl,
        write('Defense : '), write(UpdatedDef), nl.

% Unequip System
unequip :-
    write('To unequip your weapon please write unequipWeapon.'), nl,
    write('           your armor please write unequipArmor.'), nl,
    write('           your accessory please write unequipAcc.'), nl.

unequipWeapon :-
    weapon(_, _, _, _, _, _, Status),
    Status == 0 *->
        write('You equipment is already uneqeuipped.'), nl
    ; weapon(_, _, _, _, _, _, Status),
    Status == 2 *->
        write('You have no equipment because you removed your weapon.'), nl,
        write('To obtain an equipment, please go to the shop.'), nl
    ; weapon(Item, ItemName, JobID, Health, Attack, Defense, _),
        retract(weapon(_, _, _, _, _, _, _)),
        asserta(weapon(Item, ItemName, JobID, Health, Attack, Defense, 0)),

        % Update Stats Player
        player_defense(Def), player_attack(Atk), player_max_health(HP),
        UpdatedDef is Def - Defense,
        UpdatedAtk is Atk - Attack,
        UpdatedHealth is HP - Health,
        
        retract(player_defense(_)), retract(player_max_health(_)), retract(player_attack(_)),
        asserta(player_defense(UpdatedDef)), asserta(player_max_health(UpdatedHealth)), asserta(player_attack(UpdatedAtk)),

        write('You have succesfully unequipped your equipment.'), nl,
        write('----- [ PLAYER STATUS UPDATED ] -----'), nl,
        write('Health : '), write(UpdatedHealth), nl,
        write('Attack : '), write(UpdatedAtk), nl,
        write('Defense : '), write(UpdatedDef), nl.

unequipArmor :-
    armor(_, _, _, _, _, _, Status),
    Status == 0 *->
        write('You equipment is already uneqeuipped.'), nl
    ; armor(_, _, _, _, _, _, Status),
    Status == 2 *->
        write('You have no equipment because you removed your weapon.'), nl,
        write('To obtain an equipment, please go to the shop.'), nl
    ; armor(Item, ItemName, JobID, Health, Attack, Defense, _),
        retract(armor(_, _, _, _, _, _, _)),
        asserta(armor(Item, ItemName, JobID, Health, Attack, Defense, 0)),

        % Update Stats Player
        player_defense(Def), player_attack(Atk), player_max_health(HP),
        UpdatedDef is Def - Defense,
        UpdatedAtk is Atk - Attack,
        UpdatedHealth is HP - Health,
        
        retract(player_defense(_)), retract(player_max_health(_)), retract(player_attack(_)),
        asserta(player_defense(UpdatedDef)), asserta(player_max_health(UpdatedHealth)), asserta(player_attack(UpdatedAtk)),

        write('You have succesfully unequipped your equipment.'), nl,
        write('----- [ PLAYER STATUS UPDATED ] -----'), nl,
        write('Health : '), write(UpdatedHealth), nl,
        write('Attack : '), write(UpdatedAtk), nl,
        write('Defense : '), write(UpdatedDef), nl.

unequipAcc :-
    accessory(_, _, _, _, _, _, Status),
    Status == 0 *->
        write('You equipment is already uneqeuipped.'), nl
    ; accessory(_, _, _, _, _, _, Status),
    Status == 2 *->
        write('You have no equipment because you removed your weapon.'), nl,
        write('To obtain an equipment, please go to the shop.'), nl
    ; accessory(Item, ItemName, JobID, Health, Attack, Defense, _),
        retract(accessory(_, _, _, _, _, _, _)),
        asserta(accessory(Item, ItemName, JobID, Health, Attack, Defense, 0)),

        % Update Stats Player
        player_defense(Def), player_attack(Atk), player_max_health(HP),
        UpdatedDef is Def - Defense,
        UpdatedAtk is Atk - Attack,
        UpdatedHealth is HP - Health,
        
        retract(player_defense(_)), retract(player_max_health(_)), retract(player_attack(_)),
        asserta(player_defense(UpdatedDef)), asserta(player_max_health(UpdatedHealth)), asserta(player_attack(UpdatedAtk)),

        write('You have succesfully unequipped your equipment.'), nl,
        write('----- [ PLAYER STATUS UPDATED ] -----'), nl,
        write('Health : '), write(UpdatedHealth), nl,
        write('Attack : '), write(UpdatedAtk), nl,
        write('Defense : '), write(UpdatedDef), nl.

/* -----[ POTIONS ] ----- */
% ----- List -----
% Details : ID, HEALTH REGAINED
:- dynamic(potion/2).

potion(1, 300).
potion(2, 600).
potion(3, 900).


potion_name(1, 'Small Potion (300 HP)').
potion_name(2, 'Medium Potion (600 HP)').
potion_name(3, 'Large Potion (900 HP)').

% Details : ID, COUNT
:- dynamic(potion_count/2).
potion_count(1, 0).
potion_count(2, 0).
potion_count(3, 0).

% ----- Commands -----

% Potion Count
update_pot :-
    between(1, 3, PotionID),
    findall(PotionID, potion(PotionID, _), PotList),
    length(PotList, Count), 
    retract(potion_count(PotionID, _)),
    asserta(potion_count(PotionID, Count)),
    PotionID = 3.

% Potion Information
print_potion :-
    between(1, 3, PotionID), 
    potion_count(PotionID, Count),
    potion_name(PotionID, PotName), 
    print_potion(Count, PotName),
    PotionID = 3.

print_potion(0, _):- !.
print_potion(Count, PotName) :-
    write(Count), write(' '), write(PotName), nl.

% Potion Management 
removePot :-
    write('You currently have : '), nl,
    print_potion, nl,
    write('To remove your Small Potion, write removeSmall.'), nl,
    write('               Medium Potion, write removeMedium.'), nl,
    write('               Large Potion, write removeLarge.'), nl.

removeSmall :-
    potion_count(1, Count), 
    Count == 0 *->
        write('You don\'t have any Small Potion to remove.')
    ; potion_count(1, Count),
        NewCount is Count - 1,
        %retract(potion(1, _)),
        retract(potion_count(1, _)),
        asserta(potion_count(1, NewCount)),

        write('You have succesfully removed 1 Small Potion.'), nl,
        write('You currently have '), write(NewCount), write(' potion(s) left.'), nl.

removeMedium :-
    potion_count(2, Count), 
    Count == 0 *->
        write('You don\'t have any Medium Potion to remove.')
    ; potion_count(2, Count),
        NewCount is Count - 1,
        %retract(potion(2, _)),
        retract(potion_count(2, _)),
        asserta(potion_count(2, NewCount)),

        write('You have succesfully removed 1 Medium Potion.'), nl,
        write('You currently have '), write(NewCount), write(' potion(s) left.'), nl.

removeLarge :-
    potion_count(3, Count), 
    Count == 0 *->
        write('You don\'t have any Large Potion to remove.')
    ; potion_count(3, Count),
        NewCount is Count - 1,
        %retract(potion(3, _)),
        retract(potion_count(3, _)),
        asserta(potion_count(3, NewCount)),

        write('You have succesfully removed 1 Large Potion.'), nl,
        write('You currently have '), write(NewCount), write(' potion(s) left.'), nl.


