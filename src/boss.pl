boss_name('Dvozak').

:- dynamic(boss_current_health/1).

boss_max_health(100).

boss_level(100).

:- dynamic(boss_attack/1).
boss_attack(1000000).

boss_defense(1).