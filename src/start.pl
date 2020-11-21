
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
    
    assert(player_exp(120)),
    assert(player_location(1,1)),
    assert(player_level(1)),
    assert(player_current_health(30)),
    assert(player_max_health(100)),
    assert(player_attack(20)),
    assert(player_defense(5)),
    assert(player_gold(1)),

    ['enemy.pl'],
    retractall(enemy_level(_)),

    assert(enemy_level(1)).