function p.get_ment_has_health(inst_id)
    local ment_type = ga_ment_get_type(inst_id)
    return ga_ment_type_var_exists(ment_type, "health")
end

function p.init_maybe(inst_id)
    ga_debug_push("game_ment_health.init_maybe")
    local health_max_curved = ga_ment_get_i(inst_id, "health_max_curved")
    if( health_max_curved == -1 ) then
        --Need to init.
        -- local ment_type = ga_ment_get_type(inst_id)
        -- local uncurved_max_health = ga_ment_get_static_i(ment_type, "health") --I hate static variables.
        local uncurved_max_health = ga_ment_get_i(inst_id, "health")
        local health_max_curved = game_difficulty_curve.curve_enemy_health(uncurved_max_health)
        local health_curved = health_max_curved
        ga_ment_set_i(inst_id, "health_max_curved", health_max_curved)
        ga_ment_set_i(inst_id, "health_curved", health_curved)
    end
    ga_debug_pop("game_ment_health.init_maybe")
end

--Returns the curved value
--if curving is in effect.
function p.get_ment_health(inst_id)
    -- ga_print("game_ment_health.get_ment_health begin")
    local health = 0
    if( ga_get_b("xar.difficulty.curve.enabled") ) then
        -- ga_print("getting curved health 1")
        p.init_maybe(inst_id)
        -- ga_print("getting curved health 2")
        health = ga_ment_get_i(inst_id, "health_curved")
    else
        -- ga_print("getting uncurved health")
        health = ga_ment_get_i(inst_id, "health")
    end
    -- ga_print("game_ment_health.get_ment_health end")
    return health
end

--Sets the curved value
--if curving is in effect.
function p.set_ment_health(inst_id, amount)
    if( ga_get_b("xar.difficulty.curve.enabled") ) then
        p.init_maybe(inst_id)
        ga_ment_set_i(inst_id, "health_curved", amount)
    else
        ga_ment_set_i(inst_id, "health", amount)
    end

    if( amount <= 0 ) then
        local counts = true
        local ment_type = ga_ment_get_type(inst_id)
        if( ga_ment_type_var_exists(ment_type, "counts_for_pacifist") and
            not ga_ment_get_b(inst_id, "counts_for_pacifist") )
        then
            counts = false
        end
        --
        if( counts ) then
            game_kill_count.add_frag()
        end
    end
end

function p.take_damage(inst_id, damage)
    if not ga_ment_var_exists(inst_id, "health_curved") then return end
    if not ga_ment_var_exists(inst_id, "health") then return end
    --
    local old_health = p.get_ment_health(inst_id)
    local new_health = old_health - damage
    if( new_health < 0 ) then new_health = 0 end
    p.set_ment_health(inst_id, new_health)
end

--Returns the curved value
--if curving is in effect.
function p.get_ment_max_health(inst_id)
    if( ga_get_b("xar.difficulty.curve.enabled") ) then
        p.init_maybe(inst_id)
        return ga_ment_get_i(inst_id, "health_max_curved")
    else
        local ment_type = ga_ment_get_type(inst_id)
        return ga_ment_get_static_i(ment_type, "health")
    end
end

--The callback that is called when either the "health"
--or "health_cuved" variable.  Note: the type of old_value and new_value
--is the type of var, which is this case is "int".
function p.health_var_changed_cb(inst_id, var, old_value, new_value)
    if( new_value > 0 ) then return end
    --
    --Note: Need to think more about making death animations general.
    if( ga_ment_get_i(inst_id, "__death_anim_stage") == 0 ) then
        --Calling the "die" function.
        game_ment_die.main(inst_id)
        ga_ment_set_i(inst_id, "__death_anim_stage", 1)
    end

    local death_anim_str = ga_ment_get_s(inst_id, "__death_anim")
    if death_anim_str == "" then
        --Can remove the ment right now.
        ga_ment_remove(inst_id)
    else
        --Will remove the ment when the death animation is over.
        local game_time = ga_get_game_time()
        local alarm_time = game_time + 0.1
        local alarm_name = "death_anim"
        ga_ment_set_alarm(inst_id, alarm_time, alarm_name)
    end
end
