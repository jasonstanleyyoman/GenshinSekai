:- dynamic(player_location/2).
:- dynamic(player_level/1).
:- dynamic(player_current_health/1).
:- dynamic(player_max_health/1).
:- dynamic(player_attack/1).
:- dynamic(player_defense/1).
:- dynamic(player_exp/1).
:- dynamic(player_gold/1).
:- dynamic(player_job/1).

joblist(1, 'Tukang tusuk').
joblist(2, 'Tukang tembak').
joblist(3, 'Tukang ngutuk').

exp_required(1,4).
exp_required(2,6).
exp_required(3,7).
exp_required(4,10).
exp_required(5,11).
exp_required(6,15).
exp_required(7,19).
exp_required(8,20).
exp_required(9,24).
exp_required(10,30).
exp_required(11,34).
exp_required(12,40).
exp_required(13,50).
exp_required(14,60).
exp_required(15,65).
exp_required(16,78).
exp_required(17,80).
exp_required(18,88).


level_up :-
    player_level(CurrentLevel),
    player_exp(CurrentExp),
    exp_required(CurrentLevel, ExpRequired),
    write('Current EXP : '), write(CurrentExp), write('/'), write(ExpRequired),nl,
    CurrentExp >= ExpRequired,
    retractall(player_level(_)),
    NewLevel is CurrentLevel + 1,
    assertz(player_level(NewLevel)),
    retractall(player_exp(_)),
    NewPlayerExp is CurrentExp - ExpRequired,
    assertz(player_exp(NewPlayerExp)),
    %grow player status
    %grow player max health
    player_max_health(CurrentMaxHealth),
    retractall(player_max_health(_)),
    NewPlayerMaxHealth is CurrentMaxHealth * 1.2,
    NewNewPlayerMaxHealth is round(NewPlayerMaxHealth),
    assertz(player_max_health(NewNewPlayerMaxHealth)),
    %grow player attack
    player_attack(CurrentAttack),
    retractall(player_attack(_)),
    AfterGrowAttack is CurrentAttack * 1.2,
    NewPlayerAttack is round(AfterGrowAttack),
    assertz(player_attack(NewPlayerAttack)),
    %grow player defense 
    player_defense(CurrentDefense),
    retractall(player_defense(_)),
    AfterGrowDefense is CurrentDefense * 1.2,
    NewPlayerDefense is round(AfterGrowDefense),
    assertz(player_defense(NewPlayerDefense)),
    %restore player current health sejumlah growth max health (tidak langsung restore jadi max health)
    player_current_health(CurrentHealth),
    retractall(player_current_health(_)),
    NewPlayerCurrentHealth is (NewNewPlayerMaxHealth - CurrentMaxHealth + CurrentHealth),
    assertz(player_current_health(NewPlayerCurrentHealth)),
    set_enemy_level,
    write('Congratulation you ascend to Level '), write(NewLevel),nl,
    level_up.

level_up.

pick_job :-
    \+ player_job(_),
    write('Choose your job :'),nl,
    write('--------------------------'),nl,
    write('1. Tukang tusuk'),nl,
    write('2. Tukang tembak'),nl,
    write('3. Tukang ngutuk'),nl,
    write('---------------------------'),nl,
    write('Choose your job : '),
    read(JobPick),
    (( JobPick = 1 -> assertz(player_job(1));
       JobPick = 2 -> assertz(player_job(2));
       JobPick = 3 -> assertz(player_job(3));
       JobPick > 3 -> write('Budayakan membaca :)'),nl,nl, pick_job;
       JobPick < 1 -> write('Budayakan membaca :)'),nl,nl, pick_job)),
    ((JobPick = 1 -> assertz(player_max_health(100)), assertz(player_current_health(100)), assertz(player_attack(15)), assertz(player_defense(20)));
    (JobPick = 2 -> assertz(player_max_health(90)), assertz(player_current_health(90)), assertz(player_attack(17)), assertz(player_defense(17)));
    (JobPick = 3 -> assertz(player_max_health(80)), assertz(player_current_health(80)), assertz(player_attack(20)), assertz(player_defense(15)))).


whosyourdaddy :-
    retractall(player_max_health(_)),
    retractall(player_current_health(_)),
    retractall(player_attack(_)),
    retractall(player_defense(_)),
    assertz(player_max_health(1000000)),
    assertz(player_current_health(1000000)),
    assertz(player_attack(1000000)),
    assertz(player_defense(1000000)).

greedisgold :-
    retractall(player_gold(_)),
    assertz(player_gold(1000000)).

% Starter Equipment
starter_pack :-
    player_job(JobID),
    ((JobID = 1 ->
        asserta(weapon(0, 'Wooden Sword', 1, 0, 10, 0, 0)),
        asserta(armor(0, 'Basic Iron Armor', 1, 0, 0, 15, 0)),
        asserta(accessory(0, 'Wood Talisman', 1, 25, 0, 0, 0));
    JobID = 2 -> 
        asserta(weapon(0, 'Basic Bow', 2, 0, 12, 0, 0)),
        asserta(armor(0, 'Basic Leather Armor', 2, 0, 0, 12, 0)),
        asserta(accessory(0, 'Robin\'s Hope', 2, 25, 0, 0, 0));
    JobID = 3 ->
        asserta(weapon(0, 'Old Staff', 3, 0, 15, 0, 0)),
        asserta(armor(0, 'Old Robe', 3, 0, 0, 10, 0)),
        asserta(accessory(0, 'Drop of Dragon\'s Blood', 3, 25, 0, 0, 0))
        )),
    retractall(potion_count(1,_)),
    assertz(potion_count(1,5)),
    write('To kick start your journey, here is a starter pack:'),nl,
    weapon(_,WeaponName,_,_,_,_,_),
    write('Obtained 1 '), write(WeaponName),nl,
    armor(_,ArmorName,_,_,_,_,_),
    write('Obtained 1 '), write(ArmorName),nl,
    accessory(_,AccessoryName,_,_,_,_,_),
    write('Obtained 1 '), write(AccessoryName),nl,
    potion_name(1,PotionName),
    write('Obtained 5 '), write(PotionName),nl.



