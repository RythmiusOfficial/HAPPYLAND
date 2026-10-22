-------------------------------------------------
--              Damage AND Health
-------------------------------------------------

function p.xar_get_level_mod_damage_in(delta)
    return ment_monster_menace.xar_get_level_mod_damage_in(delta)
    -- if (delta == 1) then return 0.25 end
    -- if (delta == 2) then return 0.0625 end
    -- return 1.0
end

-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 3.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterArchMenaceMale")
    ia_ment_new_var_i(id, "health", 10000, 60.0)
    ia_ment_new_static_var_f(id, "dps", 20.0)
    ia_ment_new_static_var_s(id, "sound_hurt", "hurt_menace")
    ia_ment_new_static_var_f(id, "sound_hurt_period", 1.0)
    ia_ment_new_static_var_s(id, "sound_death", "die_menace")
    ia_ment_new_static_var_s(id, "identity_str", "Arch Menace Male")
    --
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_f(id, "shoot_period", 1.0)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_menace_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 0.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 1.0)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 20)
    ia_ment_new_var_b(id, "hive_attack", true, 60.0)
    local hive_delay = ment_monster_menace.hive_delay()
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
