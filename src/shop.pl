/* File : shop.pl */
/* Gacha dan Buy Potions */

:- include('inventory.pl').
/*
% Testing Purposes 
:- dynamic(player_gold/1).
:- dynamic(potion/2).
:- dynamic(weapon/7).
:- dynamic(armor/7).
:- dynamic(accessory/7).
:- dynamic(player_max_health/1).
:- dynamic(player_attack/1).
:- dynamic(player_defense/1).
weapon(0, 'Wooden Sword', 1, 0, 200, 0, 1).
armor(0, 'Iron Armor', 1, 0, 0, 0, 0).
accessory(0, 'Wood Talisman', 1, 0, 0, 0, 0).
player_gold(10000000).
player_job(2).
player_max_health(10).
player_attack(210).
player_defense(10).
*/

% Utility Command
update_player_status(0, _, _, _) :- !.
update_player_status(2, _, _, _) :- !.
update_player_status(1, H, A, D) :-
    player_attack(Atk), player_defense(Def), player_max_health(HP),
    UpdatedHealth is HP-H, UpdatedAtk is Atk-A, UpdatedDef is Def-D,
    retract(player_defense(_)), retract(player_max_health(_)), retract(player_attack(_)),
    asserta(player_defense(UpdatedDef)), asserta(player_max_health(UpdatedHealth)), asserta(player_attack(UpdatedAtk)).

/* -----[ SHOP ] ----- */
% ----- Inside Shop -----
:- dynamic(insideShop/1).
insideShop(false).

% ----- Open Shop -----
shop :-
    write('>----- { MONDSTADT GENERAL GOODS } -----<'), nl, 
    write('Welcome to Mondstadt General Goods!'), nl,
    write('What do you want to buy?'), nl,
    write('1. Gacha : 1000 Gold'), nl,
    write('!Warning! The gacha system will automatically replace your equipments.'), nl,
    write('          You may or may not get stronger equipments.'), nl,
    write('2. Small Potion (300 HP) : 200 Gold'), nl,
    write('3. Medium Potion (600 HP) : 400 Gold'), nl,
    write('4. Large Potion (900 HP) : 600 Gold'), nl,
    nl,
    write('(Commands : gacha, smallPotion, mediumPotion'), nl,
    write('            largePotion, exitShop           )'), nl,
    write('(Tip : Before gacha, try to equip all your equipments first,'), nl,
    write('(      So, you will see an accurate before and after stats  )'),

    retract(insideShop(_)),
    asserta(insideShop(true)).

% ----- Exit Shop -----
exitShop :-
    write('Thank you for coming to Mondstadt General Goods.'), nl,
    write('Please come again. '), nl,
    write('>---------------------------------------<'), nl, 
    
    retract(insideShop(_)),
    asserta(insideShop(false)).

/* -----[ GACHA ] ----- */
% Job ID :  1 - Swordsman
%           2 - Archer
%           3 - Sorcerer
% Details : ITEM LIST
:- dynamic(weapon_stock/1).
:- dynamic(armor_stock/1).
:- dynamic(accessory_stock/1).
% Details : ITEM ID, NAME, JOB ID, HEALTH, ATTACK, DEFENSE
:- dynamic(weapon_loot/6).
:- dynamic(armor_loot/6).
:- dynamic(accessory_loot/6).

% ----- { ITEM LIST } -----
% Note : 0 - Starter Item
%        1,2,3 - Loot Item 
weapon_stock([1, 2, 3]).
armor_stock([1, 2, 3]).
accessory_stock([1, 2, 3]).
% ----- Weapon -----
% Swordsman
weapon_loot(0, 'Wooden Sword', 1, 0, 10, 0).
weapon_loot(1, 'Dull Blade', 1, 0, 25, 0).
weapon_loot(2, 'Sacrificial Sword', 1, 0, 100, 0).
weapon_loot(3, 'Aquila Favonia', 1, 0, 250, 0).
% Archer
weapon_loot(0, 'Basic Bow', 2, 0, 10, 0).
weapon_loot(1, 'Hunter\'s Bow', 2, 0, 25, 0).
weapon_loot(2, 'Blackcliff Warbow', 2, 0, 100, 0).
weapon_loot(3, 'The Viridescent Hunt', 2, 0, 250, 0).
% Sorcerer
weapon_loot(0, 'Old Staff', 3, 0, 10, 0).
weapon_loot(1, 'Pocket Grimoire', 3, 0, 25, 0).
weapon_loot(2, 'Favonius Codex', 3, 0, 100, 0).
weapon_loot(3, 'Lost Prayer to the Sacred Winds', 3, 0, 250, 0).

% ----- Armor -----
% Swordsman
armor_loot(0, 'Basic Iron Armor', 1, 20, 0, 35).
armor_loot(1, 'Cuirass of Ending Whispers', 1, 30, 0, 50).
armor_loot(2, 'War-Forged Tunic of Heroes', 1, 80, 0, 150).
armor_loot(3, 'Mithril Battleplate', 1, 100, 0, 350).
% Archer
armor_loot(0, 'Basic Leather Armor', 2, 10, 0, 20).
armor_loot(1, 'Vest of the Falling Sky', 2, 25, 0, 30).
armor_loot(2, 'Adamantite Chestguard', 2, 80, 0, 150).
armor_loot(3, 'Slumber Boots', 2, 30, 0, 45).
% Sorcerer
armor_loot(0, 'Old Robe', 3, 0, 0, 10).
armor_loot(1, 'Bloodcursed Robes', 3, 15, 0, 20).
armor_loot(2, 'Vindicator of Darkness', 3, 20, 0, 35).
armor_loot(3, 'Mourning Dragon Armor', 3, 50, 0, 100).

% ----- Accessory -----
% Swordsman
accessory_loot(0, 'Wood Talisman', 1, 5, 5, 5).
accessory_loot(1, 'Equinox Fruit', 1, 0, 35, 10).
accessory_loot(2, 'Hide of Lifeblood', 1, 45, 5, 40).
accessory_loot(3, 'Mantle of Death', 1, -10, 60, 55).
% Archer
accessory_loot(0, 'Robin\'s Hope', 1, 10, 10, 0).
accessory_loot(1, 'Key of Rain', 2, 0, 25, 30).
accessory_loot(2, 'Soul Horn', 2, 0, 60, 5).
accessory_loot(3, 'Petrifying Cup', 2, -5, 75, 45).
% Sorcerer
accessory_loot(0, 'Drop of Dragon\'s Blood', 1, 0, 10, 5).
accessory_loot(1, 'Mirage Elixir', 3, 10, 25, 0).
accessory_loot(2, 'Domination Crown', 3, 20, 30, 0).
accessory_loot(3, 'Shard of Riddles', 3, -10, 80, 30).


% ----- { COMMANDS } -----
gacha :-
    player_gold(PlayerGold),
    PlayerGold < 1000 ->
        write('You don\'t have enough gold.'), nl, shop
    ;   player_gold(PlayerGold),
        CurrentGold is PlayerGold - 1000,
        retract(player_gold(_)),
        asserta(player_gold(CurrentGold)),

        player_attack(Atk), player_defense(Def), player_max_health(HP),
        write('This is your status before Gacha : '), nl,
        write('----- [ CURRENT PLAYER STATUS ] -----'), nl,
        write('Health : '), write(HP), nl,
        write('Attack : '), write(Atk), nl,
        write('Defense : '), write(Def), nl, nl,

        
        write('           .-----------------.'), nl,
        write('           | Mondstadt Gacha |'), nl,
        write('           \'-----------------\''), nl,
    
        player_job(JobID), gacha(JobID).

% LootType : 1 - Weapon
%            2 - Armor
%            3 - Accessory
gacha(JobID) :-
    random(1, 3, LootType), 
    LootType =:= 1 ->
        % Selecting Item from Stock
        weapon_stock(WeaponStock), length(WeaponStock, Stock), Gacha is Stock+1,
        random(1, Gacha, NthItem), nth(NthItem, WeaponStock, SelectedItem),
        % Update Stock Information
        select(SelectedItem, WeaponStock, UpdatedWeaponStock),
        weapon(ItemID, _, _, H, A, D, Stat), TempList = [ItemID], append(TempList, UpdatedWeaponStock, FinalWeaponStock),
        retract(weapon_stock(_)), asserta(weapon_stock(FinalWeaponStock)),
        % Get Item
        weapon_loot(SelectedItem, ItemName, JobID, Health, Attack, Defense),
        
        % Update Player Status
        update_player_status(Stat, H, A, D),

        % Update Player Inventory
        retract(weapon(ItemID, _, _, _, _, _, _)),
        asserta(weapon(Item, ItemName, JobID, Health, Attack, Defense, 0)),

        write('Congratulations! You got '), write(ItemName), write('.'), nl,
        write('      ----- < Item Details > -----'), nl,
        write('         Type : Weapon'), nl,
        write('         Attack :'), write(Attack), nl, nl,

        write('Equipment will be automatically equipped. Equipping equipment...'), nl,
        equipWeapon,
        write('Above is your updated status after gacha.'), nl

    ; random(2, 4, LootType), 
        LootType =:= 2 ->
            % Selecting Item from Stock
            armor_stock(ArmorStock), length(ArmorStock, Stock), Gacha is Stock+1,
            random(1, Gacha, NthItem), nth(NthItem, ArmorStock, SelectedItem),
            % Update Stock Information
            select(SelectedItem, ArmorStock, UpdatedArmorStock),
            armor(ItemID, _, _, H, A, D, _), TempList = [ItemID], append(TempList, UpdatedArmorStock, FinalArmorStock),
            retract(armor_stock(_)), asserta(armor_stock(FinalArmorStock)),
            % Get Item
            armor_loot(SelectedItem, ItemName, JobID, Health, Attack, Defense),

            % Update Player Status
            update_player_status(Stat, H, A, D),

            % Update Player Inventory
            retract(armor(ItemID, _, _, _, _, _, _)),
            asserta(armor(Item, ItemName, JobID, Health, Attack, Defense, 0)),

            write('Congratulations! You got '), write(ItemName), write('.'), nl,
            write('      ----- < Item Details > -----'), nl,
            write('         Type : Armor'), nl,
            write('         Health :'), write(Health), nl,
            write('         Defense :'), write(Defense), nl, nl,

            write('Equipment will be automatically equipped. Equipping equipment...'), nl,
            equipArmor,
            write('Above is your updated status after gacha.'), nl

    ; player_job(JobID),
        % Selecting Item from Stock
        accessory_stock(AccStock), length(AccStock, Stock), Gacha is Stock+1,
        random(1, Gacha, NthItem), nth(NthItem, AccStock, SelectedItem),
        % Update Stock Information
        select(SelectedItem, AccStock, UpdatedAccStock),
        accessory(ItemID, _, _, H, A, D, _), TempList = [ItemID], append(TempList, UpdatedAccStock, FinalAccStock),
        retract(accessory_stock(_)), asserta(accessory_stock(FinalAccStock)),
        % Get Item
        accessory_loot(SelectedItem, ItemName, JobID, Health, Attack, Defense),

       % Update Player Status
       update_player_status(Stat, H, A, D),

        % Update Player Inventory
        retract(accessory(ItemID, _, _, _, _, _, _)),
        asserta(accessory(Item, ItemName, JobID, Health, Attack, Defense, 0)),

        write('Congratulations! You got '), write(ItemName), write('.'), nl,
        write('      ----- < Item Details > -----'), nl,
        write('         Type : Accessory'), nl,
        write('         Health :'), write(Health), nl,
        write('         Attack :'), write(Attack), nl,
        write('         Defense :'), write(Defense), nl, nl,

        write('Equipment will be automatically equipped. Equipping equipment...'), nl,
        equipAcc,
        write('Above is your updated status after gacha.'), nl.

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
