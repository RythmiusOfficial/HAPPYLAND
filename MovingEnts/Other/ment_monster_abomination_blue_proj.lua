-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster_proj(id)
    ia_ment_set_builtin_var_f(id, "__radius", 0.5)
    ia_ment_set_builtin_var_s(id, "__mesh", "plasma1")
    ia_ment_new_var_i(id, "health", 1000000, 60.0)
    ia_ment_new_static_var_f(id, "dps", 1.0) --CHANGE!!!
    ia_ment_set_builtin_var_i(id, "__team_id_source", 2)
    ia_ment_set_builtin_var_i(id, "__team_id_target", 2)
    ia_ment_new_var_i(id, "blood_die_override", 10, 60.0 * 60.0)
    ia_ment_new_static_var_s(id, "identity_str", "Blue Abomination Missile")
    ia_ment_new_static_var_b(id, "freeze_immune", true)
    ia_ment_new_static_var_b(id, "counts_for_pacifist", false)
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.__on_update(inst_id, et, elt)
    --On the ment's starting level.
    local dist_to_player = ga_ment_get_var_special_dist_to_viewer(inst_id)

    local trigger_radius = 1.0
    if dist_to_player < trigger_radius then
        p.explode(inst_id)
    end
end

function p.__on_block_hit(
    inst_id,
    level, bp, lp,
    normal_side, normal)

    ga_play_sound("explosion_tube_dud")
    p.explode(inst_id)
    return true
end

--Helper function.
function p.explode(inst_id)
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local cur_level = ga_ment_get_i(inst_id, "__level")
    local lp = ga_ment_get_lp(inst_id)

    local dist_to_player = ga_ment_get_var_special_dist_to_viewer(inst_id)
    local explode_radius = 10.0
    if dist_to_player < explode_radius then
        game_top2.damage_player(false, 2500)
        -- game_top2.damage_player(false, 1000)
    end
    
    local ls = ga_level_scale_factor(start_level, cur_level).value

    ga_play_sound("explosion_tube_long")

    local fudge2 = 1.0
    if( start_level == cur_level ) then fudge2 = 2.0 end

    local args = {}
    args.level = cur_level
    args.pos = lp
    args.ttl_min = 0.1*ls
    args.ttl_max = 0.5*ls
    args.size_min = 0.4*ls*fudge2
    args.size_max = 1.0*ls*fudge2
    args.color = std.vec(0.0, 0.0, 1.0)
    args.fade_time_min = 1.0
    args.fade_time_max = 1.0
    args.speed_min = 1.0*ls*fudge2
    args.speed_max = 20.0*ls*fudge2
    args.tex = "particle_2"
    args.radius_min = 1.0
    args.radius_max = 1.0
    args.num = 200
    args.use_min_dist = true --No particles too close to viewer.
    ga_particle_explosion(args)

    --Removing the ment.
    ga_ment_remove(inst_id)
end
