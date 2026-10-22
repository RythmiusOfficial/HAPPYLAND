function p.get_the_time(inst_id)
    local type_name = ga_ment_get_type(inst_id)
    local game_time = ga_get_game_time()
    local lvlinv = ga_ment_get_static_b(type_name, "secondary_shoot_period_lvlinv")
    local the_time = 0.0
    if( lvlinv ) then the_time = game_time
    else
        local start_level = ga_ment_get_i(inst_id, "__start_level")
        the_time = ga_get_level_time(start_level)
    end
    return the_time
end

function p.add_alarm(inst_id, next_shoot_time)
    local type_name = ga_ment_get_type(inst_id)
    local lvlinv = ga_ment_get_static_b(type_name, "secondary_shoot_period_lvlinv")
    if( lvlinv ) then
        --A game time alarm.
        ga_ment_set_alarm(inst_id, next_shoot_time, "secondary_shoot_next")
    else
        --A level time alarm.
        local start_level = ga_ment_get_i(inst_id, "__start_level")
        ga_ment_set_alarm_on_level(inst_id, start_level, next_shoot_time, "secondary_shoot_next")
    end
end

function p.set_shoot_time(inst_id, random_start)
    -- game_time = ga_get_game_time()
    local the_time = p.get_the_time(inst_id) --Note: this might be level time.
    -- --
    local shoot_length = ga_ment_get_f(inst_id, "secondary_shoot_period")

    --Setting the next aura time.
    local next_shoot_time = 0.0
    if random_start then
        next_shoot_time = the_time + shoot_length*ga_randf()
        else
        next_shoot_time = the_time + shoot_length
    end
    ga_ment_set_f(inst_id, "secondary_shoot_time", next_shoot_time)

    -- ga_print("game_ment_shoot_secondary.set_shoot_time: the_time = " .. tostring(the_time))
    -- ga_print("game_ment_shoot_secondary.set_shoot_time: next_time = " .. tostring(next_shoot_time))

    --Adding an alarm.
    -- ga_print("game_ment_shoot_secondary.set_shoot_time: adding alarm for " .. tostring(next_shoot_time))
    p.add_alarm(inst_id, next_shoot_time)
end

--This is what an alarm should call.
--Also, add to live would should call this.
function p.shoot_maybe(inst_id, add_to_live)
    -- ga_print("game_ment_shoot_secondary.shoot_maybe 1")

    -- local type_name = ga_ment_get_type(inst_id)
    -- ga_print("game_ment_shoot_secondary.shoot_maybe type_name = " .. type_name)

    if( not ga_ment_b_exists_and_true(inst_id, "secondary_shoots") ) then return end
    --Before this function ends, we must set an alarm.

    -- if( not ga_ment_static_b_exists_and_true(type_name, "secondary_shoots") ) then return end

    -- ga_print("game_ment_shoot_secondary.shoot_maybe: secondary_shoots is true")

    local shoot_length = ga_ment_get_f(inst_id, "secondary_shoot_period")
    local shoot_time = ga_ment_get_f(inst_id, "secondary_shoot_time")
    -- -- --
    local the_time = p.get_the_time(inst_id)

    -- ga_print("game_ment_shoot_secondary.shoot_maybe: shoot_time = " .. tostring(shoot_time))
    -- ga_print("game_ment_shoot_secondary.shoot_maybe: the_time = " .. tostring(the_time))

    if( shoot_time < the_time - 10*shoot_length ) then
        p.set_shoot_time(inst_id, true) --This sets an alarm.
        return
    end
    if( shoot_time < the_time + 0.1 ) then
        p.shoot_execute(inst_id) --This sets an alarm.
        return
    end
    --Should do nothing.
    --Normally when this happens, we should have
    --shoot_time < game_time + shoot_length.
    --Otherwise, something is fishy.
    -- if( add_to_live ) then
        --Adding an alarm.
        -- ga_print("adding an alarm to shoot (in add_to_live)")
    p.add_alarm(inst_id, shoot_time) --This sets an alarm.
    -- end
end

function p.shoot_execute(inst_id)
    -- ga_print("game_ment_shoot_secondary.shoot_execute 1")

    --Just in case.
    local type_name = ga_ment_get_type(inst_id)
    if( not ga_ment_static_b_exists_and_true(type_name, "secondary_shoots") ) then
        return
    end
    local type_name = ga_ment_get_type(inst_id)

    --Important to get now, before
    --restting the shoot time.
    local shoot_time = ga_ment_get_f(inst_id, "secondary_shoot_time")

    -- ---------------------------------------------
    -- --     Setting alarm to shoot again
    -- ---------------------------------------------

    --Adding a new alarm.
    --Important to do this at the beginning.
    local random_start = false
    p.set_shoot_time(inst_id, random_start)

    -- ---------------------------------------------
    -- --     Determining if should shoot
    -- ---------------------------------------------

    --Returning if old projectile still exists.
    local proj_inst_id = ga_ment_get_i(inst_id, "secondary_shoot_proj_inst_id")
    if( proj_inst_id >= 0 ) then
        local exists = ga_ment_exists(proj_inst_id)
        if( exists ) then
            --Cannot shoot because projectile still exists.
            return
        end
    end

    --Getting "the_time" and shoot_time.
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local the_time = p.get_the_time(inst_id)

    if (the_time < shoot_time - 0.1) then return end

    --Emp.
    if( ga_ment_b_exists_and_true(inst_id, "emp_stunned") ) then return end
    if( ga_ment_b_exists_and_true(inst_id, "frozen") ) then return end

    --Shoot radius.
    local dist_to_viewer = ga_ment_get_var_special_dist_to_viewer(inst_id)
    local shoot_radius = ga_ment_get_f(inst_id, "secondary_shoot_radius")
    if( dist_to_viewer > shoot_radius ) then return end

    --Only same level.
    local only_diff_level = ga_ment_get_b(inst_id, "secondary_shoot_only_different_level")
    if( only_diff_level ) then
        local viewer_level = ga_get_viewer_level()
        if( start_level == viewer_level ) then return end
    end

    if ga_ment_b_exists_and_true(inst_id, "secondary_shoot_only_same_level") then
        local viewer_level = ga_get_viewer_level()
        if( start_level ~= viewer_level ) then return end
    end

    -- ---------------------------------------------
    -- --          Spawning the projectile
    -- ---------------------------------------------
    -- --Mar 21, 2020.

    --Ready to actually fire.

    local proj_type = ga_ment_get_s(inst_id, "secondary_shoot_proj_type")
    local shoot_speed = ga_ment_get_f(inst_id, "secondary_shoot_proj_speed")
    local towards_viewer = ga_ment_get_var_special_vec_to_viewer(inst_id)
    --See comment about the mothership in "game_ment_shoot.lua".
    -- --
    std.normalize(towards_viewer)
    local shoot_vel = {}
    local shoot_vel = std.vec_scale(towards_viewer, shoot_speed)
    local proj_ttl = ga_ment_get_f(inst_id, "secondary_shoot_proj_ttl")

    local shoot_damage = ga_ment_get_i(inst_id, "secondary_shoot_proj_damage")

    local sllp = ga_ment_get_sllp(inst_id)
    ga_ment_start(
        start_level, sllp,
        proj_type)
    ga_ment_init_set_v("__vel", shoot_vel)
    ga_ment_init_set_f("__ttl", proj_ttl)
    ga_ment_init_set_i("damage", shoot_damage) --Don't need to worry about damage_no_powerups.

    local alt_attack_icon = ga_ment_get_s(inst_id, "secondary_shoot_alt_attack_icon")
    if( alt_attack_icon ~= "" ) then
        ga_ment_init_set_s("alt_attack_icon", alt_attack_icon)
    end

    local proj_inst_id = ga_ment_end()
    ga_ment_set_i(inst_id, "secondary_shoot_proj_inst_id", proj_inst_id)
end
