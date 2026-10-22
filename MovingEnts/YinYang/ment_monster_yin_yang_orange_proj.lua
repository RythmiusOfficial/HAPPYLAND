-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster_proj(id)
    ia_ment_set_builtin_var_i(id, "__extra_max_levels", 5)
    ia_ment_set_builtin_var_f(id, "__radius", 0.01)
    ia_ment_set_builtin_var_s(id, "__mesh", "")
    ia_ment_set_builtin_var_b(id, "__homing", true)
    ia_ment_set_builtin_var_f(id, "__homing_speed", 1000000.0)
    ia_ment_new_var_i(id, "damage", 10, 3600.0)
    ia_ment_new_static_var_b(id, "counts_for_pacifist", false)
    --Maybe make it trully emp immune.
    ia_ment_new_static_var_b(id, "alt_attack_icon_use_parent_name", true)
    ia_ment_new_static_var_b(id, "attack_icon_use_parent_for_dir", true)
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.__on_alarm(inst_id, alarm_name)
    game_ment_alarms.monster_proj(inst_id, alarm_name)
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
    -- return ret.terminal_hit

    local target_type = ga_ment_get_type(target_inst_id)
    local target_team_id = ga_ment_get_static_i(target_type, "__team_id_target")
    if( target_team_id ~= 1 ) then return false end
    p.set_darken_effect()
    return true
end

--Making all blocks in the world pitch black.
function p.set_darken_effect()
    ga_set_b("xar.visual_effect.block_blind.got_a_hit", true)
end
