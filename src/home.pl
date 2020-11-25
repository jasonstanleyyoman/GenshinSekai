restore_full_health :-  
    player_max_health(PlayerMaxHealth),
    retractall(player_current_health(_)),
    write('Restore jadi '), write(PlayerMaxHealth),nl,
    assertz(player_current_health(PlayerMaxHealth)).