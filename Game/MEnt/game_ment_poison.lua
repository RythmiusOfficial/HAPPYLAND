function p.add_to_live(inst_id)
    local type_name = ga_ment_get_type(inst_id)
    if( not ga_ment_type_var_exists(type_name, "poisoned") ) then return end
    if( not ga_ment_get_b(inst_id, "poisoned") ) then return end
    --It is poisoned.

    local game_time = ga_get_game_time()

    --Taking damage from existing poison.
    local poison_dps = ga_ment_get_f(inst_id, "poison_dps")
    local lasthit_time = ga_ment_get_f(inst_id, "poison_lasthit")
    local since_last_hit = math.floor(game_time - lasthit_time)
    if( since_last_hit > 0 ) then
        poison_damage = math.floor(poison_dps * since_last_hit)
        if( game_ment_health.get_ment_has_health(inst_id) ) then
            old_health = game_ment_health.get_ment_health(inst_id)
            game_ment_health.set_ment_health(inst_id, old_health - poison_damage)
        end
    end
    
    ga_ment_set_alarm(inst_id, game_time + 1.0, "poison")
end

function p.poison_initial_hit(inst_id, dps, len)
    local type_name = ga_ment_get_type(inst_id)

    -- --Making sure it can be frozen.
    if( ga_ment_static_b_exists_and_true(type_name, "poison_immune") ) then return end
    if( ga_ment_get_i(inst_id, "__team_id_target") ~= 2 ) then return end
    if( not ga_ment_type_var_exists(type_name, "poisoned") ) then return end
    if( not ga_ment_type_var_exists(type_name, "poison_dps") ) then return end
    if( not ga_ment_type_var_exists(type_name, "poison_endtime") ) then return end

    local already_poisoned = ga_ment_get_b(inst_id, "poisoned")

    -- --Doing poison effect.

    ga_ment_set_b(inst_id, "poisoned", true)

    -- --Changing the texture to the poison texture.
    --Worry about revert time?
    --Maybe all ment vars should have a 1 hour revert time.
    ga_ment_set_s(inst_id, "__tex_override", "ment_poison")

    local game_time = ga_get_game_time()

    --Will reset these if already_poisoned.
    local new_poison_endtime = game_time + len
    local new_poison_dps = dps
    --
    if( already_poisoned ) then
        local first_poison_length = ga_ment_get_f(inst_id, "poison_endtime") - game_time
        if( first_poison_length < 0.0 ) then first_poison_length = 0.0 end
        local first_poison_dps = ga_ment_get_f(inst_id, "poison_dps")
        local first_poison_total = first_poison_length * first_poison_dps
        --
        local second_poison_length = len
        local second_poison_dps = dps
        local second_poison_total = second_poison_length * second_poison_dps
        --
        new_poison_dps = math.min( first_poison_dps, second_poison_dps )
        local new_poison_total = first_poison_total + second_poison_total
        local new_poison_length = new_poison_total / new_poison_dps
        new_poison_endtime = game_time + new_poison_length
    end
    --
    ga_ment_set_f(inst_id, "poison_endtime", new_poison_endtime)
    ga_ment_set_f(inst_id, "poison_dps", new_poison_dps)

    --If already poisoned, there is already a poison alarm set
    --(within the next second).
    if( not already_poisoned ) then
        ga_ment_set_alarm(inst_id, game_time + 1.0, "poison")
    end
end

function p.poison_hit(inst_id)
    --Making sure is frozen.
    local type_name = ga_ment_get_type(inst_id)
    if( ga_ment_type_var_exists(type_name, "poisoned") and
        not ga_ment_get_b(inst_id, "poisoned") )
        then
            return
    end

    local game_time = ga_get_game_time()
    local poison_endtime = ga_ment_get_f(inst_id, "poison_endtime")
    if( game_time > poison_endtime + 0.1 ) then
        --Need to end the poison effect.
        ga_ment_set_b(inst_id, "poisoned", false)
        --Refreshing the __tex_override.
        game_ment_tex_override.refresh(inst_id)
        return
    end

    --Dealing damage.
    --(should happen once per second).
    local poison_dps = ga_ment_get_f(inst_id, "poison_dps")
    local poison_damage = math.floor(poison_dps)
    --
    --Added Jun 27, 2026.
    local allow_powerups = false
    local poison_damage_adjusted = game_damage.calc_damage_from_player(poison_damage, allow_powerups)
    local poison_damage_curved = game_difficulty_curve.curve_player_damage(poison_damage_adjusted)
    --
    if( game_ment_health.get_ment_has_health(inst_id) ) then
        local old_health = game_ment_health.get_ment_health(inst_id)
        game_ment_health.set_ment_health(inst_id, old_health - poison_damage_adjusted)
    end
    ga_ment_set_f(inst_id, "poison_lasthit", game_time)

    --Setting another alarm.
    ga_ment_set_alarm(inst_id, game_time + 1.0, "poison")
end
