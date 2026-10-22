-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 4.0) --Figure out good size.
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterYinYangOrange")
    ia_ment_new_var_i(id, "health", 1000000000, 60.0) --One billion.
    ia_ment_new_static_var_b(id, "emp_immune", true)
    ia_ment_new_static_var_f(id, "dps", 1000.0)
    ia_ment_new_static_var_s(id, "sound_hurt", "hurt_abomination_blue") --Ok?
    ia_ment_new_static_var_f(id, "sound_hurt_period", 0.95)
    ia_ment_new_static_var_s(id, "sound_death", "die_abomination_blue") --Ok?
    ia_ment_new_static_var_s(id, "identity_str", "Orange Yin Yang")
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_b(id, "shoot_allow_multiple_proj", true) --Forcing it.
    ia_ment_new_static_var_f(id, "shoot_period", 0.9)
    ia_ment_new_static_var_b(id, "shoot_period_lvlinv", true)
    ia_ment_new_static_var_b(id, "shoot_only_different_level", false)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_yin_yang_orange_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 10000000.0) --Does not matter (see proj homing speed).
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 0.4)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 0)
    ia_ment_new_static_var_s(id, "shoot_alt_attack_icon", "icon_yin_yang_warning")
    ia_ment_new_static_var_b(id, "shoot_attack_icon_dir_use_parent", true)
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
