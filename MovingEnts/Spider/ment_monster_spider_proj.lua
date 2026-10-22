-------------------------------------------------
--            Type Init Function
-------------------------------------------------

--This projectile has a 2 second individual delay.

function p.__type_init(id)
    game_ment_type_init.monster_proj(id)
    ia_ment_set_builtin_var_f(id, "__radius", 0.01)
    ia_ment_set_builtin_var_s(id, "__mesh", "")
    ia_ment_set_builtin_var_b(id, "__homing", true)
    ia_ment_set_builtin_var_f(id, "__homing_speed", 10000.0)
    -- ia_ment_set_builtin_var_f(id, "__homing_speed", 1000.0)
    ia_ment_new_var_i(id, "damage", 10, 3600.0)
    ia_ment_new_var_b(id, "individual_delay_has", true, 60.0)
    ia_ment_new_static_var_b(id, "counts_for_pacifist", false)
    --Maybe make it trully emp immune.
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
    return ret.terminal_hit
end
