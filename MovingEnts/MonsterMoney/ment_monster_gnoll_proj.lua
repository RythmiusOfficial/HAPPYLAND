-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster_proj(id)
    ia_ment_set_builtin_var_f(id, "__radius", 0.3)
    ia_ment_set_builtin_var_s(id, "__mesh", "plasma1")
    ia_ment_set_builtin_var_i(id, "__team_id_source", 2)
    ia_ment_set_builtin_var_i(id, "__team_id_target", 2)
    ia_ment_new_static_var_i(id, "shoot_proj_speed", 50)
    ia_ment_new_static_var_b(id, "counts_for_pacifist", false)
    --
    --Weird vars.
    --The level of the player when the ment was added to the live world.
    ia_ment_new_var_i(id, "starting_player_level", 0, 5*60.0)
    --
    --Debugging.
    -- ia_ment_new_var_s(id, "alt_attack_icon", "icon_yin_yang_warning", 60*60)
    -- ia_ment_new_var_b(id, "display_hit_to_hud", false, 60*60)
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.__on_alarm(inst_id, alarm_name)
    game_ment_alarms.monster_proj(inst_id, alarm_name)
end

function p.__on_add_to_live_world(inst_id)
    local viewer_level = ga_get_viewer_level()
    ga_ment_set_i(inst_id, "starting_player_level", viewer_level)
    -- ga_print("monster_gnoll_proj.__on_add_to_live_world " .. tostring(viewer_level))
end

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

function p.on_closest_helper(inst_id)
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local cur_level = ga_ment_get_i(inst_id, "__level")
    local sllp = ga_ment_get_sllp(inst_id)
    local lp = ga_ment_get_lp(inst_id)

    --ga_play_sound("explosion_tube_short") --Annoying as hell.

    -- local vel = ga_ment_get_var_special_vec_to_viewer(inst_id)
    -- std.normalize(vel)
    -- local proj_speed = ga_ment_get_i(inst_id, "shoot_proj_speed")
    -- std.vec_scale_eq(vel, proj_speed)

    ga_ment_start(
        start_level, sllp,
        "ment_monster_gnoll_proj_proj")
    -- ga_ment_init_set_v("__vel", vel)
    local damage = ga_ment_get_i(inst_id, "damage")
    ga_ment_init_set_i("damage", damage)
    ga_ment_end()
end

function p.__on_closest(inst_id)
    --Will only have effect if the viewer was finer than
    --this ment when this ment was created.
    local start_viewer_level = ga_ment_get_i(inst_id, "starting_player_level")
    local viewer_level = ga_get_viewer_level()
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    if( viewer_level == start_level ) then return end
    if( start_viewer_level <= start_level ) then return end

    p.on_closest_helper(inst_id)
    ga_ment_remove(inst_id)
end
