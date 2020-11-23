/* File : shop.pl */
/* Gacha dan Buy Potions */

/*
% Testing Purposes 
:- dynamic(player_gold/1).
:- dynamic(potion/2).
:- dynamic(weapon/5).
:- dynamic(armor/5).
:- dynamic(accessory/5).
player_gold(1000).
player_job(2).
weapon('Wooden Sword', 1, 0, 0, 0).
armor('Iron Armor', 1, 0, 0, 0).
accessory('Wood Talisman', 1, 0, 0, 0). 
*/

/* -----[ SHOP ] ----- */
% ----- Inside Shop -----
:- dynamic(insideShop/1).
insideShop(false).

% ----- Open Shop -----
shop :-
    write('Welcome to Mondstadt General Goods!'), nl,
    write('What do you want to buy?'), nl,
    write('1. Gacha : 1000 Gold'), nl,
    write('2. Small Potion (300 HP) : 200 Gold'), nl,
    write('3. Medium Potion (600 HP) : 400 Gold'), nl,
    write('4. Large Potion (900 HP) : 600 Gold'), nl,
    nl,
    write('(Commands : gacha, smallPotion, mediumPotion)'), nl,
    write('(           largePotion, exitShop)'),

    retract(insideShop(_)),
    asserta(insideShop(true)).

% ----- Exit Shop -----
exitShop :-
    write('Thank you for coming to Mondstadt General Goods.'), nl,
    write('Please come again. '),
    
    retract(insideShop(_)),
    asserta(insideShop(false)).

/* -----[ GACHA ] ----- */
% Job ID :  1 - Swordsman
%           2 - Archer
%           3 - Sorcerer
% Details : ITEM ID, NAME, JOB ID, HEALTH, ATTACK, DEFENSE
% ----- { ITEM LIST } -----
% Note : Ini bukan starter pack
% ----- Weapon -----
% Swordsman
weapon_loot(1, 'Dull Blade', 1, 0, 25, 0).
weapon_loot(2, 'Sacrificial Sword', 1, 0, 100, 0).
weapon_loot(3, 'Aquila Favonia', 1, 0, 250, 0).
% Archer
weapon_loot(1, 'Hunter\'s Bow', 2, 0, 25, 0).
weapon_loot(2, 'Blackcliff Warbow', 2, 0, 100, 0).
weapon_loot(3, 'The Viridescent Hunt', 2, 0, 250, 0).
% Sorcerer
weapon_loot(1, 'Pocket Grimoire', 3, 0, 25, 0).
weapon_loot(2, 'Favonius Codex', 3, 0, 100, 0).
weapon_loot(3, 'Lost Prayer to the Sacred Winds', 3, 0, 250, 0).

% ----- Armor -----
% Swordsman
armor_loot(1, 'Cuirass of Ending Whispers', 1, 0, 0, 0).
armor_loot(2, 'War-Forged Tunic of Heroes', 1, 0, 0, 0).
armor_loot(3, 'Mithril Battleplate', 1, 0, 0, 0).
% Archer
armor_loot(1, 'Vest of the Falling Sky', 2, 0, 0, 0).
armor_loot(2, 'Adamantite Chestguard', 2, 0, 0, 0).
armor_loot(3, 'Slumber Boots', 2, 0, 0, 0).
% Sorcerer
armor_loot(1, 'Bloodcursed Robes', 3, 0, 0, 0).
armor_loot(2, 'Vindicator of Darkness', 3, 0, 0, 0).
armor_loot(3, 'Mourning Dragon Armor', 3, 0, 0, 0).

% ----- Accessory -----
% Swordsman
accessory_loot(1, 'Equinox Fruit', 1, 0, 0, 0).
accessory_loot(2, 'Hide of Lifeblood', 1, 0, 0, 0).
accessory_loot(3, 'Mantle of Death', 1, 0, 0, 0).
% Archer
accessory_loot(1, 'Key of Rain', 2, 0, 0, 0).
accessory_loot(2, 'Soul Horn', 2, 0, 0, 0).
accessory_loot(3, 'Petrifying Cup', 2, 0, 0, 0).
% Sorcerer
accessory_loot(1, 'Mirage Elixir', 3, 0, 0, 0).
accessory_loot(2, 'Domination Crown', 3, 0, 0, 0).
accessory_loot(3, 'Shard of Riddles', 3, 0, 0, 0).


% ----- { COMMANDS } -----
gacha :-
    player_gold(PlayerGold),
    PlayerGold < 1000 ->
        write('You don\'t have enough gold.'), nl, shop
    ;   player_gold(PlayerGold),
        CurrentGold is PlayerGold - 1000,
        retract(player_gold(_)),
        asserta(player_gold(CurrentGold)),

        player_job(JobID), gacha(JobID).

% LootType : 1 - Weapon
%            2 - Armor
%            3 - Accessory
gacha(JobID) :-
    random(1, 3, LootType), 
    LootType =:= 1 ->
        random(1, 3, Item),
        weapon_loot(Item, ItemName, JobID, Health, Attack, Defense),
        retract(weapon(_, _, _, _, _)),
        asserta(weapon(ItemName, JobID, Health, Attack, Defense)),

        write('Congratulations! You got '), write(ItemName), write('.'), nl,
        write('--- Item Details ---'), nl,
        write('Type : Weapon'), nl,
        write('Attack :'), write(Attack), nl

    ; random(2, 3, LootType), 
        LootType =:= 2 ->
            random(1, 3, Item), player_job(JobID),
            armor_loot(Item, ItemName, JobID, Health, Attack, Defense),
            retract(armor(_, _, _, _, _)),
            asserta(armor(ItemName, JobID, Health, Attack, Defense)),

            write('Congratulations! You got '), write(ItemName), write('.'), nl,
            write('--- Item Details ---'), nl,
            write('Type : Armor'), nl,
            write('Health :'), write(Health), nl,
            write('Defense :'), write(Defense), nl

    ; random(1, 3, Item), player_job(JobID),
        accessory_loot(Item, ItemName, JobID, Health, Attack, Defense),
        retract(accessory(_, _, _, _, _)),
        asserta(accessory(ItemName, JobID, Health, Attack, Defense)),

        write('Congratulations! You got '), write(ItemName), write('.'), nl,
        write('--- Item Details ---'), nl,
        write('Type : Accessory'), nl,
        write('Health :'), write(Health), nl,
        write('Attack :'), write(Attack), nl,
        write('Defense :'), write(Defense), nl.


/* -----[ POTIONS ] ----- */
% ----- Equipment Count -----
smallPotion :-
    player_gold(PlayerGold),
    PlayerGold < 200 ->
        write('You don\'t have enough gold.'), nl, shop
    ;   asserta(potion(1, 300)),
        player_gold(PlayerGold),
        CurrentGold is PlayerGold - 200,

        write('You bought a Small Potion (300 HP).'), nl,
        retract(player_gold(_)),
        asserta(player_gold(CurrentGold)).

mediumPotion :-
    player_gold(PlayerGold),
    PlayerGold < 400 ->
        write('You don\'t have enough gold.'), nl, shop
    ;   asserta(potion(2, 600)),
        player_gold(PlayerGold),
        CurrentGold is PlayerGold - 400,

        write('You bought a Medium Potion (600 HP).'), nl,
        retract(player_gold(_)),
        asserta(player_gold(CurrentGold)).

largePotion :-
    player_gold(PlayerGold),
    PlayerGold < 600 ->
        write('You don\'t have enough gold.'), nl, shop
    ;   asserta(potion(3, 900)),
        player_gold(PlayerGold),
        CurrentGold is PlayerGold - 600,

        write('You bought a Large Potion (900 HP).'), nl,
        retract(player_gold(_)),
        asserta(player_gold(CurrentGold)).
