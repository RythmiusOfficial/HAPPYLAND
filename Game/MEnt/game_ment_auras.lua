--Handling all auras.
function p.auras_payloads_maybe(inst_id, add_to_live_world)
    p.damage_aura_payload_maybe(inst_id, add_to_live_world)
    p.picture_aura_payload_maybe(inst_id, add_to_live_world)
    --more?
end

-------------------------------------------------------------------------------
--                              Damage Aura
-------------------------------------------------------------------------------

function p.set_damage_aura(inst_id, random_start)
    local game_time = ga_get_game_time()
    local the_time = game_time
    --
    local aura_length = ga_ment_get_f(inst_id, "damage_aura_duration")

    --Setting the next aura time.
    local next_aura_time = 0.0
    if random_start then
        next_aura_time = the_time + aura_length*ga_randf()
    else
        next_aura_time = the_time + aura_length
    end
    ga_ment_set_f(inst_id, "damage_aura_next_time", next_aura_time)

    --Adding an alarm.
    ga_ment_set_alarm(inst_id, next_aura_time, "damage_aura_next")
end

--This is what an alarm should call.
function p.damage_aura_payload_maybe(inst_id, add_to_live_world)
    local type_name = ga_ment_get_type(inst_id)
    if( not ga_ment_static_b_exists_and_true(type_name, "damage_aura_has") ) then return end

    local aura_length = ga_ment_get_f(inst_id, "damage_aura_duration")
    local aura_next_time = ga_ment_get_f(inst_id, "damage_aura_next_time")
    --
    local game_time = ga_get_game_time()
    local the_time = game_time

    if( the_time > aura_next_time + 10*aura_length ) then
        --Emergency reboot.
        p.set_damage_aura(inst_id, true)
        return
    end
    if( the_time > aura_next_time - 0.1 ) then
        p.damage_aura_execute(inst_id)
    end

    --Setting another alarm.
    --The call to damage_aura_execute may have updated the ment var damage_aura_next_time.
    local aura_next_time = ga_ment_get_f(inst_id, "damage_aura_next_time")
    ga_ment_set_alarm(inst_id, aura_next_time, "damage_aura_next")
end

function p.damage_aura_execute(inst_id)
    --Adding a new alarm.
    local random_start = false
    p.set_damage_aura(inst_id, random_start)

    if( ga_ment_b_exists_and_true(inst_id, "emp_stunned") ) then return end
    if( ga_ment_b_exists_and_true(inst_id, "frozen") ) then return end

    local aura_radius = ga_ment_get_f(inst_id, "damage_aura_radius")
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    if( aura_radius > 0 ) then
        --Doing a radius check.
        local sllp = ga_ment_get_sllp(inst_id)
        local viewer_lp = ga_get_viewer_lp(start_level)
        local dist_to_viewer = std.dist(sllp, viewer_lp)
        if( dist_to_viewer > aura_radius ) then return end
    end

    if( ga_ment_b_exists_and_true(inst_id, "damage_aura_only_same_level") ) then
        player_level = ga_get_viewer_level()
        if( start_level ~= player_level ) then return end
    end

    --Damaging the player (from a direction).
    local damage = ga_ment_get_i(inst_id, "damage_aura_damage");
    local cur_level = ga_ment_get_i(inst_id, "__level")
    local lp = ga_ment_get_lp(inst_id)
    local dir = ga_get_vec_to_viewer(
         cur_level,
         lp)
    local neg_dir = std.vec_scale(dir, -1.0)
    game_top2.damage_player_from_dir(false, damage, neg_dir)

    --Suicide bomb variant.
    if ga_ment_b_exists_and_true(inst_id, "damage_aura_suicide_bomb") then
        ga_ment_remove(inst_id)
    end
end

-------------------------------------------------------------------------------
--                              Picture Aura
-------------------------------------------------------------------------------

function p.set_picture_aura(inst_id)
    local game_time = ga_get_game_time()
    local the_time = game_time
    --
    local aura_length = 0.5
    local next_aura_time = the_time + aura_length

    --Setting the next aura time.
    ga_ment_set_f(inst_id, "picture_aura_next_time", next_aura_time)

    --Adding an alarm.
    ga_ment_set_alarm(inst_id, next_aura_time, "picture_aura_next")
end

--This is what an alarm should call.
function p.picture_aura_payload_maybe(inst_id, add_to_live_world)
    local type_name = ga_ment_get_type(inst_id)
    if( not ga_ment_b_exists_and_true(inst_id, "picture_aura_has") ) then return end

    local aura_length = 0.5
    local aura_next_time = ga_ment_get_f(inst_id, "picture_aura_next_time")
    --
    local game_time = ga_get_game_time()
    local the_time = game_time

    if( aura_next_time < the_time - 10*aura_length ) then
        p.set_picture_aura(inst_id, true)
    end
    if( aura_next_time < the_time + 0.1 ) then
        p.picture_aura_execute(inst_id)
    end

    --Setting another alarm.
    --The call to picture_aura_execute may have updated the ment var picture_aura_next_time.
    local aura_next_time = ga_ment_get_f(inst_id, "picture_aura_next_time")
    ga_ment_set_alarm(inst_id, aura_next_time, "picture_aura_next")
end

function p.picture_aura_execute(inst_id)
    --Adding a new alarm.
    p.set_picture_aura(inst_id)

    if( ga_ment_b_exists_and_true(inst_id, "emp_stunned") ) then return end
    if( ga_ment_b_exists_and_true(inst_id, "frozen") ) then return end

    local aura_radius = ga_ment_get_f(inst_id, "picture_aura_radius")
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    if( aura_radius > 0 ) then
        --Doing a radius check.
        local sllp = ga_ment_get_sllp(inst_id)
        local dir = ga_get_vec_to_viewer(
            start_level,
            sllp)
        local dist_to_viewer = math.sqrt(dir.x*dir.x + dir.y*dir.y + dir.z*dir.z)
        if( dist_to_viewer > aura_radius ) then return end
    end

    --Same or different level requirements.
    if( ga_ment_b_exists_and_true(inst_id, "picture_aura_only_same_level") ) then
        player_level = ga_get_viewer_level()
        if( start_level ~= player_level ) then return end
    end
    if( ga_ment_b_exists_and_true(inst_id, "picture_aura_only_diff_level") ) then
        player_level = ga_get_viewer_level()
        if( start_level == player_level ) then return end
    end

    --Displaying a picture in the attack display.
    local icon_handle = "picture_aura_" .. tostring(inst_id)
    local tex = ""
    if ga_ment_var_exists(inst_id, "picture_aura_picture") then
        tex = ga_ment_get_s(inst_id, "picture_aura_picture")
    end
    local cur_level = ga_ment_get_i(inst_id, "__level")
    local lp = ga_ment_get_lp(inst_id)
    local dir = ga_get_vec_to_viewer(cur_level, lp)
    local neg_dir = std.vec_scale(dir, -1.0)
    local duration = 1.0
    ga_hud_reg_dir_tex(icon_handle, tex, neg_dir, duration)
end
