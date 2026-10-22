-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 1.5) --Good?
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterRocketSpiderBaby")
    ia_ment_new_var_i(id, "health", 10000, 60.0)
    ia_ment_new_static_var_f(id, "dps", 30.0)
    ia_ment_new_static_var_s(id, "sound_hurt", "hurt_spider")
    ia_ment_new_static_var_f(id, "sound_hurt_period", 0.8)
    ia_ment_new_static_var_s(id, "sound_death", "die_spider")
    ia_ment_new_static_var_s(id, "die_drop_bent", "bent_upgrade_gun_4_proj_speed")
    ia_ment_new_static_var_s(id, "die_drop_box_txt", "Rocket Velocity Upgrade")
    ia_ment_new_static_var_b(id, "die_drop_box_allow", true)
    ia_ment_new_static_var_i(id, "die_drop_extra_levels", 1)
    ia_ment_new_static_var_s(id, "identity_str", "Baby Spider")
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_f(id, "shoot_period", 1.0)
    ia_ment_new_static_var_b(id, "shoot_period_lvlinv", true)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_spider_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 10000.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 1.0)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 30)
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
