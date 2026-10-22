--Monsters that are EMP immune are actually
--only stunned for this amount of time.
function p.get_short_stun_len()
    return 2.0
end

function p.detonate_emp(level, lp, radius, stun_len, damage)
    --Doing the effect.
    --This is tricky.  Even though we only care about ments in level level,
    --their index level might be < level, so we have to consider those
    --levels as well.
    local ments = ga_ment_sphere_query(
        level, level-5, level,
        lp, radius)
    local game_time = ga_get_game_time()
    for k,v in pairs(ments) do
        local inst_id = v.inst_id
        local ment_level = ga_ment_get_level(inst_id)
        if ment_level == level then
            local getting_hit_type = ga_ment_get_s(inst_id, "getting_hit_type")
            if getting_hit_type == "enemy" then
                local short_end_time = game_time + p.get_short_stun_len()
                local stun_end_time = game_time + stun_len
                p.emp_stun(inst_id, short_end_time, stun_end_time, damage)
            end
        end
    end

    --Creating EMP blast ment.
    local index_data = std.ment_get_index_level(level, radius)
    local index_level = index_data.level
    local index_radius = index_data.radius
    ga_print("game_ment_emp.detonate_emp: index_radius = " .. tostring(index_radius))
    local index_lp = ga_convert_lp(level, index_level, lp).value
    local game_time = ga_get_sys_f("game.time.total")
    ga_ment_start(index_level, index_lp, "ment_emp_blast")
    ga_ment_init_set_f("__game_end_time", game_time + stun_len)
    ga_ment_init_set_f("emp_start_time", game_time)
    ga_ment_init_set_f("__radius", index_radius)
    ga_ment_init_set_i("damage", damage)
    ga_ment_init_set_i("effect_level", level)
    ga_ment_end()
end

function p.add_to_live(inst_id)
    p.add_to_live_helper(inst_id)

    p.emp_stun_end_maybe(inst_id)
end

function p.add_to_live_helper(inst_id)
    --Seeing if inside an EMP blast, and if so applying it.
    p.ment_see_if_in_emp_sphere_and_apply(inst_id)

    --Dealing with alarm for emp effect ending.
    local type_name = ga_ment_get_type(inst_id)
    if( not ga_ment_type_var_exists(type_name, "emp_stun_endtime") ) then return end
    local stun_end = ga_ment_get_f(inst_id, "emp_stun_endtime")
    local game_time = ga_get_game_time()
    if( stun_end < game_time ) then return end --Right?
    ga_ment_set_alarm(inst_id, stun_end, "emp_stun_end")
end

function p.ment_see_if_in_emp_sphere_and_apply(inst_id)
    local ment_level = ga_ment_get_i(inst_id, "__level")
    local min_level = ment_level - 5
    local max_level = ment_level
    local lp = ga_ment_get_lp(inst_id)
    local radius = 0.1
    local ments = ga_ment_sphere_query(
        ment_level, min_level, max_level,
        lp, radius)
    for k,v in pairs(ments) do
        local hit_inst_id = v.inst_id
        local hit_ment_type = ga_ment_get_type(hit_inst_id)
        if( hit_ment_type == "ment_emp_blast" and
            ment_level == ga_ment_get_i(hit_inst_id, "effect_level") )
        then
            local stun_start_time = ga_ment_get_f(hit_inst_id, "emp_start_time")
            local short_end_time = stun_start_time + p.get_short_stun_len()
            local stun_end_time = ga_ment_get_f(hit_inst_id, "__game_end_time")
            local damage = ga_ment_get_i(hit_inst_id, "damage")
            p.emp_stun(inst_id, short_end_time, stun_end_time, damage)
        end
    end
end

function p.emp_stun(inst_id, short_end_time, stun_end_time, damage)
    local type_name = ga_ment_get_type(inst_id)

    if( ga_ment_static_b_exists_and_true(type_name, "emp_immune") ) then
        if ga_ment_b_exists_and_true(inst_id, "emp_immune_true") then
            --Since it is trully emp immune, not stunning at all.
            return
        else
            --Only stunning for a very short time.
            stun_end_time = short_end_time
        end
    end

    --Making sure ment is on the right team.
    if( ga_ment_get_i(inst_id, "__team_id_target") ~= 2 ) then return end

    --Seeing if the same blast was applied before.
    if( ga_ment_type_var_exists(type_name, "emp_stun_endtime") ) then
        local old_endtime = ga_ment_get_f(inst_id, "emp_stun_endtime")
        if( stun_end_time < old_endtime + 0.5 ) then
            --It is probably the same EMP blast that was applied
            --before, so we are ignoring this request.
            return
        end
    end

    --Doing stun effect.

    --Dealing damage.
    --Can only be damaged if not already emp stunned.
    if( ga_ment_type_var_exists(type_name, "emp_stunned") and
        not ga_ment_get_b(inst_id, "emp_stunned") and
        game_ment_health.get_ment_has_health(inst_id) )
    then
        local damage_int = math.floor(damage)
        local old_health = game_ment_health.get_ment_health(inst_id)
        game_ment_health.set_ment_health(inst_id, old_health - damage)
    end

    --Setting the stunned var to true.
    if( ga_ment_type_var_exists(type_name, "emp_stunned") ) then
        ga_ment_set_b(inst_id, "emp_stunned", true)
    end

    --Changing the texture to green.
    --Worry about revert time?
    --Maybe all ment vars should have a 1 hour revert time.
    ga_ment_set_s(inst_id, "__tex_override", "emp")

    --Freezing the turning of the ment.
    ga_ment_set_b(inst_id, "__turning_disabled", true)
    ga_ment_set_b(inst_id, "__vel_disabled", true)
    --The same comment as in __tex_override applies here.

    --Setting the emp_stun_end alarm and related vars.
    if( ga_ment_type_var_exists(type_name, "emp_stun_endtime") ) then
        ga_ment_set_f(inst_id, "emp_stun_endtime", stun_end_time)
    end
    ga_ment_set_alarm(inst_id, stun_end_time + 0.1, "emp_stun_end")
end

function p.emp_stun_end_maybe(inst_id)
    local type_name = ga_ment_get_type(inst_id)
    if( ga_ment_type_var_exists(type_name, "emp_stunned") and
        not ga_ment_get_b(inst_id, "emp_stunned") )
    then
        return
    end

    --First, need to make sure the emp_stun
    --has in fact warn off (this is needed
    --because there could have been muliple
    --emp blasts).
    local game_time = ga_get_game_time()
    local emp_stun_endtime = ga_ment_get_f(inst_id, "emp_stun_endtime")
    if( game_time < emp_stun_endtime - 0.1 ) then return end

    --Unfreezing.

    ga_ment_set_b(inst_id, "emp_stunned", false)

    --Refreshing the __tex_override.
    game_ment_tex_override.refresh(inst_id)

    --Unfreezing the turning.
    ga_ment_set_b(inst_id, "__turning_disabled", false)
    ga_ment_set_b(inst_id, "__vel_disabled", false)
    --Same comment as for __tex_override applies here.
end

--Returns the distance of the player to the edge
--of whatever emp blast they are in.
--Returns a negative number if they are not inside
--an EMP blast.
function p.player_dist_to_edge_data()
    local ret = {}
    ret.highest_dist = -1.0
    ret.lowest_frac = 2.0
    --
    local viewer_level = ga_get_viewer_level()
    local pos = ga_get_viewer_offset()
    local min_level = viewer_level - 5
    local max_level = viewer_level
    local ments = ga_ment_sphere_query(
        viewer_level, min_level, max_level,
        pos, 1.0)
    for k,v in pairs(ments) do
        local target_inst_id = v.inst_id
        local type_name = ga_ment_get_type(target_inst_id)
        if type_name == "ment_emp_blast" then
            local ment_level = ga_ment_get_level(target_inst_id)
            local ment_level_pos = ga_ment_get_lp(target_inst_id)
            local ment_converted_pos = ga_convert_lp(
                ment_level, viewer_level, ment_level_pos).value
            local cur_radius = ga_ment_get_radius(target_inst_id)
            local converted_radius = cur_radius *
                    ga_level_scale_factor(ment_level, viewer_level).value
            local cur_dist_to_center = std.dist(pos, ment_converted_pos)
            --
            local cur_dist_to_edge = converted_radius - cur_dist_to_center
            local cur_frac = cur_dist_to_center / converted_radius
            --
            ret.highest_dist = math.max(ret.highest_dist, cur_dist_to_edge)
            ret.lowest_frac = math.min(ret.lowest_frac, cur_frac)
        end
    end
    return ret
end

--Returns a color depending on whether or not
--the player is an an emp sphere, and whether or not
--they are close to the edge of such a sphere.
function p.get_hud_emp_icon_text_color()
    local red = std.vec(1.0, 0.0, 0.0)
    local yellow = std.vec(1.0, 1.0, 0.0)
    local green = std.vec(0.0, 1.0, 0.0)
    --
    local ret = red
    local data = p.player_dist_to_edge_data()
    if data.lowest_frac < 1.0 then
        --Inside some emp sphere.
        ret = yellow
    end
    if  data.highest_dist > 256.0 or
        data.lowest_frac < 0.75
    then
        --Significantly inside an emp sphere.
        ret = green
    end
    return ret
end
