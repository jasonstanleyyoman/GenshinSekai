restore_full_health :-  
    player_max_health(PlayerMaxHealth),
    retractall(player_current_health),
    assertz(player_current_health(PlayerMaxHealth)).

