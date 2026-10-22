    -------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_f(id, "__ttl", 10.0)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 0) --For speed.
    ia_ment_set_builtin_var_f(id, "__radius", 0.1)
    ia_ment_set_builtin_var_s(id, "__mesh", "minigun2")
    ia_ment_new_static_var_b(id, "identifies", true)
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

--White trail.
function p.__on_level_travel(
    inst_id, level,
    start_vec,
    end_vec)

    --Getting level info.
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local factor = ga_level_scale_factor(start_level, level).value
    local diff = start_level - level

    if( diff > 0 ) then
        ga_print("ment_player_proj_plasma_6_2.__on_level_travel: end")
        ga_flush()
        return
    end --For speed.

    local args = {}
    args.level = level
    args.pos_start = start_vec
    args.pos_end = end_vec
    args.ttl_min = 3.0 * factor
    args.ttl_max = 5.0 * factor
    local size = 0.5 * factor
    -- if diff == 1 then size = size * 2.0 end
    -- if diff == 2 then size = size * 5.0 end
    args.size_min = size
    args.size_max = size
    args.color = std.vec(1.0, 1.0, 1.0)
    args.fade_time_min = 0.5 * factor
    args.fade_time_max = 0.5 * factor
    args.speed_min = 0.0
    args.speed_max = 0.0
    args.tex = "particle_2"
    args.radius_min = 0.0
    args.radius_max = 0.0
    args.avg_len = 0.4 * factor
    args.use_min_dist = false
    ga_particle_trail(args)
end

function p.__on_block_hit(
    inst_id,
    level, bp, lp,
    normal_side, normal)
--
    return true
end
