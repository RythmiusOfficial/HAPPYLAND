-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_f(id, "__ttl", 20.0)
    ia_ment_set_builtin_var_f(id, "__radius", 0.1)
    ia_ment_set_builtin_var_s(id, "__mesh", "plasma1")
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
    return ret.terminal_hit
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

        --New way:
        local args = {}
        args.level = start_level
        args.pos = sllp
        args.ttl = 1.0
        args.size = 0.2
        args.color = std.vec(1.0, 1.0, 1.0)
        args.fade_time = 0.5
        args.vel = std.vec_scale(dir, 0.5)
        args.tex = "particle_2"
        args.use_min_dist = false
        ga_particle_add(args)
    end

    return true
end
