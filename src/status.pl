status :- 
            player_job(PlayerJob),                
            write('Job: '),write(PlayerJob),nl,
            player_level(PlayerLevel),
            write('Level: '),write(PlayerLevel),nl,
            player_current_health(PlayerCurrentHealth),
            player_max_health(PlayerMaxHealth),
            write('Health: '),write(PlayerCurrentHealth),write('/'),write(PlayerMaxHealth),nl,
            player_attack(PlayerAttack),
            write('Attack: '),write(PlayerAttack),nl,
            player_defense(PlayerDefense),
            write('Defense: '),write(PlayerDefense),nl,
            player_exp(PlayerEXP),
            player_level(X),exp_required(X,LevelUpExp),
            write('Exp: '),write(PlayerEXP),write('/'),write(LevelUpExp),nl,
            player_gold(PlayerGold),
            write('Gold: '),write(PlayerGold),nl.