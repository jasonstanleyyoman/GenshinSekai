
:- dynamic(game_start/1).
:- dynamic(game_win/0).

game_start(false).
start :-
    game_start(IsGameStarted),
    \+ IsGameStarted,
    retractall(game_start(_)),
    assertz(game_start(true)),
    ['player.pl'],
    ['inventory.pl'],
    ['enemy.pl'],
    ['help.pl'],
    ['map.pl'],
    ['battle.pl'],
    ['status.pl'],
    ['quest.pl'],
    ['home.pl'],
    ['shop.pl'],
    ['boss.pl'],
    ['quit.pl'],
    ['animation.pl'],
    retractall(player_exp(_)),
    retractall(player_location(_,_)),
    retractall(player_level(_)),
    retractall(player_current_health(_)),
    retractall(player_max_health(_)),
    retractall(player_attack(_)),
    retractall(player_defense(_)),
    retractall(player_gold(_)),
    retractall(is_taking_quest),
    
    pick_job,
    starter_pack,

    assertz(player_exp(0)),
    assertz(player_location(1,1)),
    assertz(player_level(1)),
    assertz(player_gold(10000)),
    
    retractall(enemy_level(_)),
    assertz(enemy_level(1)),
    retractall(special_attack_available),
    retractall(is_battle),

    player_location(1,1),

    write(' _________                  ______ _____             ________    ______        _____ '),nl,
    write(' __  ____/_____________________  /____(_)______      __  ___/_______  /_______ ___(_)'),nl,
    write(' _  / __ _  _ \\_  __ \\_  ___/_  __ \\_  /__  __ \\     _____ \\_  _ \\_  //_/  __ `/_  / '),nl,
    write(' / /_/ / /  __/  / / /(__  )_  / / /  / _  / / /     ____/ //  __/  ,<  / /_/ /_  /  '),nl,
    write(' \\____/  \\___//_/ /_//____/ /_/ /_//_/  /_/ /_/      /____/ \\___//_/|_| \\__,_/ /_/   '),nl,
    nl,
    nl,
    write('   The year is 3092. Humanity has survived through countless trials. Nuclear wars, reactor blasts, exposure'),nl,
    write('to radioactive components have caused all the lifeforms on earth to mutate into something else. Octopi'),nl,
    write('that couldn\'t adapt itself to the situation had learnt to live with a developed slimy skin. Their anatomy'),nl,
    write('resembles fully of a slime. Because of the look, people named them slimes, just like their physical look.'),nl,
    write('Some humans who were exposed to too much radiation had died of severe health condition. Some who were able'),nl,
    write('to survive developed a longer and sharper ears, their height decreased, and their skin turned green. They'),nl,
    write('were given the name goblins because of their physical look. Wolves didn\'t evolve much, but they became'),nl,
    write('much more aggressive.'),nl,
    write('   You are a normal human being whose ancestors survived the calamity of the world and didn\'t evolve into'),nl,
    write('a goblin. You live in Asinyalisisville, a village with a lot of cotton-filled trees. Life is harsh and challenging'),nl,
    write('in Sinyalisisville. Therefore, you seek to migrate into Sinyalisisville, a city which people dreamt to live in.'),nl,
    write('Utopia, is the word used to resemble the city. But then, as what people used to say, "Great things come at'),nl,
    write('a great cost." This saying applies to Sinyalisisville; only people who have achieved something great'), nl,
    write('and reached certain level are allowed to live here. People who are willing to enter have to fight to the'),nl,
    write('death with a monstrous creature which is guarding the city.'),nl,
    write('   Are you able to level yourself up and achieve completion of all quests to be able to defeat the creature '),nl,
    write('and earn yourself a place in Sinyalisisville ?'),nl.

start :-
    game_start(IsGameStarted),
    IsGameStarted,
    write('The game has been started.'),nl.
    
