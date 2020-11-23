
start :-
    ['player.pl'],
    retractall(player_exp(_)),
    retractall(player_location(_,_)),
    retractall(player_level(_)),
    retractall(player_current_health(_)),
    retractall(player_max_health(_)),
    retractall(player_attack(_)),
    retractall(player_defense(_)),
    retractall(player_gold(_)),
    
    assertz(player_exp(120)),
    assertz(player_location(1,1)),
    assertz(player_level(1)),
    assertz(player_current_health(30)),
    assertz(player_max_health(100)),
    assertz(player_attack(200)),
    assertz(player_defense(5)),
    assertz(player_gold(1)),

    ['enemy.pl'],
    retractall(enemy_level(_)),

    assertz(enemy_level(1)),
    ['map.pl'],
    ['battle.pl'],
    ['help.pl'],
    
    write('░██████╗░███████╗███╗░░██╗░██████╗██╗░░██╗██╗███╗░░██╗  ░██████╗███████╗██╗░░██╗░█████╗░██╗'),nl,
    write('██╔════╝░██╔════╝████╗░██║██╔════╝██║░░██║██║████╗░██║  ██╔════╝██╔════╝██║░██╔╝██╔══██╗██║'),nl,
    write('██║░░██╗░█████╗░░██╔██╗██║╚█████╗░███████║██║██╔██╗██║  ╚█████╗░█████╗░░█████═╝░███████║██║'),nl,
    write('██║░░╚██╗██╔══╝░░██║╚████║░╚═══██╗██╔══██║██║██║╚████║  ░╚═══██╗██╔══╝░░██╔═██╗░██╔══██║██║'),nl,
    write('╚██████╔╝███████╗██║░╚███║██████╔╝██║░░██║██║██║░╚███║  ██████╔╝███████╗██║░╚██╗██║░░██║██║'),nl,
    write('░╚═════╝░╚══════╝╚═╝░░╚══╝╚═════╝░╚═╝░░╚═╝╚═╝╚═╝░░╚══╝  ╚═════╝░╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝'),nl.