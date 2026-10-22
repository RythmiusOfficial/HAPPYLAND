-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 2)
    ia_ment_set_builtin_var_f(id, "__radius", 4.0)
    ia_ment_set_builtin_var_b(id, "__turn_around_vel", true)
    ia_ment_set_builtin_var_f(id, "__turn_speed", 6.0) --Radians per second.
    ia_ment_set_builtin_var_s(id, "__mesh", "rocket5")
    ia_ment_set_builtin_var_f(id, "__max_screen_size", 0.25)
    ia_ment_set_builtin_var_f(id, "__max_screen_size_time_len", 1.0)
    ia_ment_new_static_var_b(id, "identifies", true)
end

-------------------------------------------------
--              Inst Functions
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
    local valid_hit = ret.terminal_hit --This was missing, causing a bug.

    if( valid_hit ) then
        local start_level = ga_ment_get_i(source_inst_id, "__start_level")
        local sllp = ga_convert_lp(level, start_level, lp).value
        p.ring_effect(start_level, sllp, normal)
        p.play_sound()
    end

    local terminal_hit = false
    if( valid_hit ) then terminal_hit = true end
    if( ret.killed ) then terminal_hit = false end

    return terminal_hit
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
    args.ttl_min = factor
    args.ttl_max = factor
    local size = 0.5 * factor
    args.size_min = size
    args.size_max = size
    args.color = std.vec(1.0, 0.0, 1.0)
    args.fade_time_min = factor
    args.fade_time_max = factor
    args.speed_min = 0.0
    args.speed_max = 0.0
    args.tex = "particle_1"
    args.radius_min = 0.0
    args.radius_max = 0.0
    args.avg_len = 2.0
    args.use_min_dist = true --No smoke to close to player.
    ga_particle_trail(args)
end

function p.__on_block_hit(
    inst_id,
    level, bp, lp,
    normal_side,
    normal)
--
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local sllp = ga_convert_lp(level, start_level, lp).value

    p.ring_effect(start_level, sllp, normal)
    p.play_sound()

    return true
end

function p.ring_effect(level, lp, normal)
    local mod_lp = std.vec_add(lp, std.vec_scale(normal,0.5))

    --New way:
    local args = {}
    args.level = level
    args.pos = mod_lp
    args.normal = normal
    args.ttl_min = 1.0
    args.ttl_max = 2.0
    args.size_min = 0.7
    args.size_max = 1.0
    args.color = std.vec(1.0, 0.0, 1.0)
    args.fade_time_min = 1.0
    args.fade_time_max = 1.0
    args.tex = "particle_2"
    args.radius = 2.0
    args.speed = 6.0
    args.num = 100
    args.use_min_dist = false
    ga_particle_ring(args)
end

function p.play_sound()
    ga_play_sound("rocket_secondary_hit")
end
