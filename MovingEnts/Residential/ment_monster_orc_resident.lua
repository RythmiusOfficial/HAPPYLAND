-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 3.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterOrc")
    ia_ment_new_var_i(id, "health", 5000, 60.0)
    ia_ment_new_var_b(id, "residency", true, 60.0)
    ia_ment_new_static_var_f(id, "dps", 20.0)
    ia_ment_new_static_var_s(id, "sound_hurt", "hurt_orc")
    ia_ment_new_static_var_f(id, "sound_hurt_period", 0.7)
    ia_ment_new_static_var_s(id, "sound_death", "die_orc")
    ia_ment_new_static_var_s(id, "die_drop_bent", "bent_gold_5")
    ia_ment_new_static_var_s(id, "identity_str", "Orc")
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_f(id, "shoot_period", 5.0)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_gnoll_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 160.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 2.5)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 100)
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

function p.__on_telefragged(inst_id)
    ga_hud_msg("You killed a RESIDENT...", 5)
    local r_kills = ga_get_i("resident_kills")
    local r_new_kills = r_kills + 1
    ga_set_i("resident_kills", r_new_kills)
end
