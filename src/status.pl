status :- 
            write('Job: '),write(player_job),nl,
            write('Level: '),write(player_level),nl,
            write('Health: '),write(player_current_health),write('/'),
            write(player_max_health),nl,
            write('Attack: '),write(player_attack),nl,
            write('Defense: '),write(player_defense),nl,
            write('Exp: '),write('player_exp'),write('/'),
            player_level(X),exp_required(X,LevelUpExp),write(LevelUpExp),nl,
            write('Gold: '),write(player_gold),nl.