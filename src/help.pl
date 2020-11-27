%help untuk saat di field (exploration)
help :-
    \+ is_battle,
    \+ is_boss_battle,
    write('BASIC COMMANDS'),nl,
    write('--------------------------------------------------------------------'),nl,
    write('1. start                     : To start your adventure'),nl,
    write('2. drawmap                   : Display map'),nl,
    write('3. status                    : Display player current status'),nl,
    write('4. w                         : Move 1 step north'),nl,
    write('5. s                         : Move 1 step south'),nl,
    write('6. d                         : Move 1 step east'),nl,
    write('7. a                         : Move 1 step west'),nl,
    write('8. interact                  : Interact with map objects. Ex : shop, home'),nl,
    write('9. inventory                 : Display items in inventory'),nl,
    write('10. equip                    : Equip item from inventory'),nl,
    write('11. unequip                  : Unequip item'),nl,
    write('12. remove                   : Remove item from inventory'),nl,
    write('13. use_potion(PotionID)     : Use potion of type PotionID'),nl,
    write('14. check_quest              : Check currently active quest'),nl,
    write('15. legend                   : Display map legends'),nl,
    write('16. help                     : Display all help'),nl,
    write('---------------------------------------------------------------------'),nl,
    write('CHEAT COMMANDS'),nl,
    write('1. add_quest_progress_slime  : Add slime progress in current quest'),nl,
    write('2. add_quest_progress_wolf   : Add wolf progress in current quest'),nl,
    write('3. add_quest_progress_goblin : Add goblin progress in current quest'),nl,
    write('4. restore_full_health       : Restore health to max health'),nl,
    write('5. teleport(X,Y)             : Teleport player to X,Y point'),nl,
    write('6. whosyourdaddy             : Increase player attack and defense to 1000000'),nl,
    write('7. greedisgold               : Increase player gold to 1000000'),nl.

help :- 
    is_battle,
    write('1. attack                    : uses attack against enemy'),nl,
    write('2. special_attack            : uses special attack against enemy, available once every 3 turns'),nl,
    write('3. use_potion(PotionID)      : uses potion of type PotionID'),nl,
    write('4. run                       : run from enemy'),nl,
    write('5. status                    : check player current status'),nl,
    write('6. inventory                 : check items in inventory'),nl.

help :- 
    is_boss_battle,
    write('1. attack                    : uses attack against enemy'),nl,
    write('2. special_attack            : uses special attack against enemy, available once every 3 turns'),nl,
    write('3. use_potion(PotionID)      : uses potion of type PotionID'),nl,
    write('4. run                       : run from enemy'),nl,
    write('5. status                    : check player current status'),nl,
    write('6. inventory                 : check items in inventory'),nl.

legend :-
    write('P    : Player'),nl,
    write('#    : Border'),nl,
    write('H    : Home, interact to restore health to full health'),nl,
    write('S    : Shop, interact to access shop'),nl,
    write('Q    : Guild, interact to take a quest'),nl,
    write('D    : Dungeon Boss, WARNING! stepping into this tile automatically starts boss battle'),nl.
 