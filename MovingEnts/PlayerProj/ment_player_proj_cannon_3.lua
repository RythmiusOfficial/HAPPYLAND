-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 1)
    ia_ment_set_builtin_var_f(id, "__radius", 1.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "cannon3")
    ia_ment_new_static_var_b(id, "identifies", true)
end

-------------------------------------------------
--         Movement Hitting Callbacks
-------------------------------------------------

function p.__on_ment_hit(
    source_inst_id,
    target_inst_id,
    level, lp, normal)
--
    --Could make this part of game_ment_hit possibly.
    local source_ignore_inst_id = ga_ment_get_i(source_inst_id, "ignore_ment_inst_id")
    if( source_ignore_inst_id == target_inst_id ) then return false end --Passing through target!

    local args = {}
    args.source_inst_id = source_inst_id
    args.target_inst_id = target_inst_id
    args.level = level
    args.lp = lp
    args.normal = normal
    --
    local ret = game_ment_hit.process_hit_and_got_hit(args)

    if( not ret.terminal_hit ) then return false end
    --Chain lightning effect.
    if( not ret.killed ) then return true end

    --So will pass right through the corpse.
    ga_ment_set_i(source_inst_id, "ignore_ment_inst_id", target_inst_id)
    --
    local found_target = p.acquire_target(source_inst_id, level, lp)
    if( found_target ) then
        ga_return_b("remove", false)
    end
    return true
end

function p.__on_block_hit(
    inst_id,
    level, bp, lp,
    normal_side, normal)
--
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local sllp = ga_convert_lp(level, start_level, lp).value

    --The particle effect.
    for i = 0,5 do
        local dir = {}
        dir.x = normal.x + (ga_randf() - 0.5)
        dir.y = normal.y + (ga_randf() - 0.5)
        dir.z = normal.z + (ga_randf() - 0.5)

        --New way:
        --Old bug discovered by Clauvin Almeida.
        -- local color = std.vec(1.0, 0.5, 0.0)
        --To Do: make better error detection
        --to detect if color is nil.

        local args = {}
        args.level = start_level
        args.pos = sllp
        args.ttl = 1.0
        args.size = 0.4
        args.color = std.vec(1.0, 0.5, 0.0)
        args.fade_time = 0.5
        args.vel = dir
        args.tex = "particle_2"
        args.use_min_dist = false
        ga_particle_add(args)
    end
    return true
end

function p.__on_level_travel(
    inst_id, level,
    start_vec,
    end_vec)
    --Getting level info.
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local factor = ga_level_scale_factor(start_level, level).value
    local diff = start_level - level

    local args = {}
    args.level = level
    args.pos_start = start_vec
    args.pos_end = end_vec
    args.ttl_min = 10.0*factor
    args.ttl_max = 10.0*factor
    local size = 0.5 * factor
    args.size_min = size
    args.size_max = size
    args.color = std.vec(1.0, 1.0, 1.0)
    args.fade_time_min = factor
    args.fade_time_max = factor
    args.speed_min = 0.0
    args.speed_max = 0.0
    args.tex = "particle_1"
    args.radius_min = 0.0
    args.radius_max = 0.0
    args.avg_len = 1.0
    args.use_min_dist = true --No smoke too close to player.
    ga_particle_trail(args)
end

--Returns true iff found a target.
function p.acquire_target(
    source_inst_id, level, lp)
--
    local search_radius = 16.0 * 2
    local ignore_frozen = false
    return ment_player_proj_cannon_3.acquire_target_common(
        source_inst_id, level, lp,
        search_radius, ignore_frozen)
end

--A helper function used by several scripts.
function p.acquire_target_common(
    source_inst_id, level, lp,
    search_radius, ignore_frozen)
--
    local source_ignore_inst_id = ga_ment_get_i(source_inst_id, "ignore_ment_inst_id")

    --The engine sorts the result list by distance to lp.
    local ments = ga_ment_sphere_query(
        level, level, level, lp, search_radius)
    local found_one = false
    local aquired_target_inst_id
    for k,v in pairs(ments) do
        local dist = v.dist
        -- ga_print("acquire_target: dist = " .. tostring(dist))
        local nearby_target_inst_id = v.inst_id
        if( nearby_target_inst_id == source_ignore_inst_id ) then
            -- ga_print("ignoring target because it was just hit")
        else
            local target_type = ga_ment_get_type(nearby_target_inst_id)
            local getting_hit_type = ga_ment_get_s(nearby_target_inst_id, "getting_hit_type")
            -- ga_print("  target type_name = " .. target_type )
            -- ga_print("  getting_hit_type = " .. getting_hit_type)
            if getting_hit_type == "enemy" then
                local should_ignore --It makes me angry that Lua does not have a continue statement.
                if( ga_ment_static_b_exists_and_true(target_type, "is_proj") ) then
                    --The cannon does not hit projectiles.
                    should_ignore = true
                end
                if( ignore_frozen and
                    game_ment_freeze.get_ment_is_frozen(nearby_target_inst_id) )
                then
                    should_ignore = true
                end
                if( not should_ignore ) then
                    local ment_lp = ga_ment_get_lp(nearby_target_inst_id)
                    local visible = ga_vis_test_level(level, lp, ment_lp);
                    if visible then
                        aquired_target_inst_id = nearby_target_inst_id
                        found_one = true
                        break
                    end
                end
            end
        end
    end
    
    if( found_one ) then
        local target_id = aquired_target_inst_id
        if( target_id < 0 ) then return false end

        local old_vel = ga_ment_get_v(source_inst_id, "__vel")
        local old_speed = std.length(old_vel)
        local target_lp = ga_ment_get_lp(target_id)
        -- ga_print("lp = " .. std.vec_to_str(lp))
        -- ga_print("target_lp = " .. std.vec_to_str(target_lp))
        local new_vel = std.vec_sub(target_lp, lp)
        std.normalize(new_vel)
        local new_vel = std.vec_scale(new_vel, old_speed)
        ga_ment_set_v(source_inst_id, "__vel", new_vel)
    end

    return found_one
end
