-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 4.0) --Ok?
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterSliverMajor")
    ia_ment_new_var_i(id, "health", 30000000, 60.0)
    ia_ment_new_static_var_f(id, "dps", 10000.0)
    ia_ment_new_static_var_f(id, "xp_mod", 2)
    ia_ment_new_static_var_s(id, "sound_hurt", "hurt_sliver")
    ia_ment_new_static_var_f(id, "sound_hurt_period", 0.7)
    ia_ment_new_static_var_s(id, "sound_death", "die_sliver")
    ia_ment_new_static_var_b(id, "emp_immune", true) --Emp, but not freeze immune.
    ia_ment_new_static_var_s(id, "die_drop_bent", "bent_gold_200")
    ia_ment_new_static_var_s(id, "identity_str", "Major Sliver")
    --
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_f(id, "shoot_period", 1.0)
    ia_ment_new_static_var_b(id, "shoot_period_lvlinv", true)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_vulcan_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 1000000.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 1.0)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 10000)
    ia_ment_new_var_b(id, "hive_attack", true, 60.0)
    local hive_delay = ment_monster_sliver_minor.hive_delay()
    ia_ment_new_var_f(id, "hive_attack_delay", hive_delay, 60.0)
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.__on_add_to_live_world(inst_id)
    game_ment_add_to_live.monster(inst_id)
end

function p.__on_alarm(inst_id, alarm_name)
    game_ment_alarms.monster(inst_id, alarm_name)
end
