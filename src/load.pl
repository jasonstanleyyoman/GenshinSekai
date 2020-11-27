load :-
    retractall(player_exp(_)),
    retractall(player_location(_,_)),
    retractall(player_level(_)),
    retractall(player_current_health(_)),
    retractall(player_max_health(_)),
    retractall(player_attack(_)),
    retractall(player_defense(_)),
    retractall(player_gold(_)),

    write('Loading savefile.dat...'),
    nl,
    ['savefile.dat'],
    write('Load successful!'),
    nl.