    -------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_f(id, "__ttl", 10.0)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 1)
    ia_ment_set_builtin_var_f(id, "__radius", 0.1)
    ia_ment_set_builtin_var_s(id, "__mesh", "minigun2")
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
    local valid_hit = ret.terminal_hit

    if( valid_hit ) then
        --Poison effect.
        local poison_len = game_wep_modes.get_poison_len(6,2)
        local poison_total = game_wep_modes.get_poison_total_damage(6,2)
        local poison_dps = math.floor(poison_total / poison_len)
        game_ment_poison.poison_initial_hit(target_inst_id, poison_dps, poison_len)

        local start_level = ga_ment_get_i(source_inst_id, "__start_level")
        local sllp = ga_convert_lp(level, start_level, lp).value
        p.ring_effect(start_level, sllp, normal)
    end

    return ret.terminal_hit
end

function p.__on_level_travel(
    inst_id, level,
    start_vec,
    end_vec)
    --Getting level info.
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local factor = ga_level_scale_factor(start_level, level).value
    local diff = start_level - level

    -- start_vec = std.vec(start_x, start_y, start_z)
    -- end_vec = std.vec(end_x, end_y, end_z)

    local half_factor = 0.5 * factor

    local args = {}
    args.level = level
    args.pos_start = start_vec
    args.pos_end = end_vec
    args.ttl_min = half_factor
    args.ttl_max = half_factor
    args.size_min = half_factor
    args.size_max = half_factor
    args.color = std.vec(1.0, 1.0, 1.0)
    args.fade_time_min = half_factor
    args.fade_time_max = half_factor
    args.speed_min = 0.0
    args.speed_max = 0.0
    args.tex = "particle_2"
    args.radius_min = 0.0
    args.radius_max = 0.0
    args.avg_len = 1.0
    args.use_min_dist = false
    ga_particle_trail(args)
end

function p.__on_block_hit(
    inst_id,
    level, bp, lp,
    normal_side, normal)
--
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local sllp = ga_convert_lp(level, start_level, lp).value

    p.ring_effect(start_level, sllp, normal)

    return true
end

function p.ring_effect(level, lp, normal)
    local mod_lp = std.vec_add(lp, std.vec_scale(normal,0.5))

    local args = {}
    args.level = level
    args.pos = mod_lp
    args.normal = normal
    args.ttl_min = 1.0
    args.ttl_max = 2.0
    args.size_min = 0.4
    args.size_max = 0.6
    args.color = std.vec(1.0, 1.0, 1.0)
    args.fade_time_min = 1.0
    args.fade_time_max = 1.0
    args.tex = "particle_2"
    args.radius = 1.0
    args.speed = 2.0
    args.num = 100
    args.use_min_dist = false
    ga_particle_ring(args)
end
