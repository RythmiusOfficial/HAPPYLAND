-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_f(id, "__ttl", 10.0)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 1)
    ia_ment_set_builtin_var_f(id, "__radius", 1.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "cannon2")
    ia_ment_set_builtin_var_f(id, "__max_screen_size", 0.25)
    ia_ment_set_builtin_var_f(id, "__max_screen_size_time_len", 1.0)
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
    local args = {}
    args.source_inst_id = source_inst_id
    args.target_inst_id = target_inst_id
    args.level = level
    args.lp = lp
    args.normal = normal
    --
    local ret = game_ment_hit.process_hit_and_got_hit(args)
    
    local terminal_hit = ret.terminal_hit
    if( ret.killed ) then terminal_hit = false end

    return terminal_hit
end

function p.__on_block_hit(
    inst_id,
    level, bp, lp,
    normal_side, normal)
--
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local sllp = ga_convert_lp(level, start_level, lp).value

    --Sparks.
    for i = 0,5 do
        dir = {}
        dir.x = normal.x + (ga_randf() - 0.5)
        dir.y = normal.y + (ga_randf() - 0.5)
        dir.z = normal.z + (ga_randf() - 0.5)

        local args = {}
        args.level = start_level
        args.pos = sllp
        args.ttl = 1.5
        args.size = 0.2
        args.color = std.vec(1.0, 0.5, 0.0)
        args.fade_time = 0.5
        args.vel = std.vec_scale(dir, 0.5)
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
    args.ttl_min = 0.0*factor
    args.ttl_max = 1.0*factor
    -- local size = 0.5 * factor
    local size = 0.5 * factor
    if diff == 1 then size = size * 2.0 end
    if diff == 2 then size = size * 5.0 end
    args.size_min = size
    args.size_max = size
    args.color = std.vec(1.0, 1.0, 1.0)
    args.fade_time_min = factor
    args.fade_time_max = factor
    args.speed_min = 0.0
    args.speed_max = 0.0
    args.tex = "particle_2"
    args.radius_min = 0.0
    args.radius_max = 0.0
    args.avg_len = 1.0
    args.use_min_dist = true --No smoke to close to player.
    ga_particle_trail(args)
end
