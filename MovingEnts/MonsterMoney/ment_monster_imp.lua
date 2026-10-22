-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 1.25)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterImp")
    ia_ment_new_var_i(id, "health", 32, 60.0)
    ia_ment_new_static_var_f(id, "dps", 1.0)
    ia_ment_new_static_var_s(id, "sound_hurt", "hurt_goblin")
    ia_ment_new_static_var_f(id, "sound_hurt_period", 0.5)
    ia_ment_new_static_var_s(id, "sound_death", "die_goblin")
    ia_ment_new_static_var_s(id, "die_drop_bent", "bent_gold_1")
    ia_ment_new_static_var_s(id, "identity_str", "Imp")
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_f(id, "shoot_period", 5.0)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_goblin_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 160.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 2.5)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 5)
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
