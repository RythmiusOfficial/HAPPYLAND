-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 7.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterMarineMercenary")
    ia_ment_new_var_i(id, "health", 500000, 60.0)
    ia_ment_new_static_var_f(id, "dps", 40.0)
    ia_ment_new_static_var_f(id, "xp_mod", 4) --High!
    ia_ment_new_static_var_s(id, "sound_hurt", "hurt_marine")
    ia_ment_new_static_var_f(id, "sound_hurt_period", 0.5)
    ia_ment_new_static_var_s(id, "sound_death", "die_marine")
    ia_ment_new_static_var_b(id, "emp_immune", true)
    ia_ment_new_static_var_s(id, "die_drop_bent", "bent_ammo_gun_2_huge")
    ia_ment_new_static_var_s(id, "identity_str", "Mercenary")
    --
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_f(id, "shoot_period", 1.0)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_marine_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 0.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 1.0)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 40)
    ia_ment_new_var_b(id, "hive_attack", true, 60.0)
    local hive_delay = ment_monster_marine_light.hive_delay()
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
