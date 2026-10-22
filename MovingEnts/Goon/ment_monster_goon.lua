-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 2.5)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterGoon")
    ia_ment_new_var_i(id, "health", 1000, 60.0)
    ia_ment_new_static_var_f(id, "dps", 4.0)
    ia_ment_new_static_var_s(id, "sound_hurt", "hurt_goon")
    ia_ment_new_static_var_f(id, "sound_hurt_period", 0.7)
    ia_ment_new_static_var_s(id, "sound_death", "die_goon")
    ia_ment_new_static_var_s(id, "die_drop_bent", "bent_ammo_gun_3_large")
    ia_ment_new_static_var_s(id, "identity_str", "Goon")
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_f(id, "shoot_period", 10.0)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_goon_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 0.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 60.0)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 40)
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
