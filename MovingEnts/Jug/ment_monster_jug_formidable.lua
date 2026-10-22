-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 7.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterJugFormidable")
    ia_ment_new_var_i(id, "health", 300000, 60.0)
    ia_ment_new_static_var_f(id, "dps", 25.0)
    ia_ment_new_static_var_s(id, "sound_hurt", "hurt_jug")
    ia_ment_new_static_var_f(id, "sound_hurt_period", 0.5)
    ia_ment_new_static_var_s(id, "sound_death", "die_jug")
    ia_ment_new_static_var_s(id, "die_drop_bent", "bent_upgrade_gun_2_fire_speed")
    ia_ment_new_static_var_s(id, "die_drop_box_txt", "Cannon Fire Rate Upgrade")
    ia_ment_new_static_var_b(id, "die_drop_box_allow", true)
    ia_ment_new_static_var_i(id, "die_drop_extra_levels", 0)
    ia_ment_new_static_var_s(id, "identity_str", "Formidable Juggernaut")
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_f(id, "shoot_period", 1.0)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_spider_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 1000.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 1.0)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 25)
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
