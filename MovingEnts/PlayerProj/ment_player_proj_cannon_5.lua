-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_f(id, "__ttl", 10 * 60.0) --Very long.
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
    args.color = std.vec(0.0, 0.0, 0.0)
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
    local search_radius = 16.0 * 5 --Bigger than "The Sheriff".
    local ignore_frozen = true
    return ment_player_proj_cannon_3.acquire_target_common(
        source_inst_id, level, lp,
        search_radius, ignore_frozen)
end
