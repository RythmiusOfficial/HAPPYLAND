-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster_proj(id)
    ia_ment_set_builtin_var_f(id, "__radius", 0.1)
    ia_ment_set_builtin_var_s(id, "__mesh", "inner_core_proj")
    ia_ment_set_builtin_var_i(id, "__team_id_source", 2)
    ia_ment_set_builtin_var_i(id, "__team_id_target", 2)
    ia_ment_new_var_i(id, "health", 2000000, 60.0)
    ia_ment_new_static_var_s(id, "identity_str", "Inner Core Missile")
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.__on_block_hit(
    inst_id,
    level, bp, lp,
    normal_side, normal)

    p.on_closest_helper(inst_id)
    return true
end

function p.__on_too_fine(
    inst_id,
    fine_chunk_id,
    fine_offset)

    p.on_closest_helper(inst_id)
    return true
end

-- Called when this entity is closest to the viewer
-- (when this entity stats to more farther away).
function p.__on_closest(inst_id)
    p.on_closest_helper(inst_id)

    ga_ment_remove(inst_id)
end

function p.on_closest_helper(inst_id)
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local cur_level = ga_ment_get_i(inst_id, "__level")
    local sllp = ga_ment_get_sllp(inst_id)
    local lp = ga_ment_get_lp(inst_id)

    local ls = ga_level_scale_factor(start_level, cur_level).value

    local fudge2 = 1.0
    if( start_level == cur_level ) then fudge2 = 2.0 end

    local args = {}
    args.level = cur_level
    args.pos = lp
    args.ttl_min = 0.01*ls
    args.ttl_max = 0.03*ls
    args.size_min = 0.04*ls*fudge2
    args.size_max = 0.12*ls*fudge2
    args.color = std.vec(1.0, 1.0, 0.0)
    args.fade_time_min = 1.0
    args.fade_time_max = 1.0
    args.speed_min = 1.0*ls*fudge2
    args.speed_max = 3.0*ls*fudge2
    args.tex = "particle_2"
    args.radius_min = 0.0
    args.radius_max = 0.0
    args.num = 50
    args.use_min_dist = true --No particles too close to viewer.
    ga_particle_explosion(args)

    ga_play_sound("explosion_tube_short")

    local next_level = start_level+1
    local nlp = {}
    nlp = ga_convert_lp(start_level, next_level, sllp).value

    ga_ment_start(
        next_level, nlp,
        "ment_monster_inner_core_minion")
    --ga_ment_init_set_f("__radius", 0.05)
    ga_ment_end()
end
