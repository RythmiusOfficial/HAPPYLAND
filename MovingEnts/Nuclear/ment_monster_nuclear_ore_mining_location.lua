-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 4.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterNuclearOreMiningLocation")
    ia_ment_new_var_i(id, "health", 200000, 60.0)
    ia_ment_new_static_var_f(id, "dps", 125)
    ia_ment_new_static_var_s(id, "sound_hurt", "hurt_wobble1")
    ia_ment_new_static_var_f(id, "sound_hurt_period", 0.5)
    ia_ment_new_static_var_s(id, "sound_death", "die_tank2")
    ia_ment_new_static_var_s(id, "die_drop_bent", "bent_upgrade_gun_9_radius")
    ia_ment_new_static_var_s(id, "die_drop_box_txt", "Nuke Radius Upgrade")
    ia_ment_new_static_var_b(id, "die_drop_box_allow", true)
    ia_ment_new_static_var_i(id, "die_drop_extra_levels", 1)
    ia_ment_new_static_var_s(id, "identity_str", "Nuclear Ore Miner")
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_f(id, "shoot_period", 8.0)
    ia_ment_new_static_var_b(id, "shoot_period_lvlinv", true)
    ia_ment_new_static_var_b(id, "shoot_only_different_level", true)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_nuclear_ore_mining_location_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 100.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 60.0)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 1000)
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
