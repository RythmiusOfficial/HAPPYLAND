-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60)
    ia_ment_set_builtin_var_f(id, "__radius", 0.5)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterFly")
    ia_ment_new_var_i(id, "health", 250, 60.0)
    ia_ment_new_static_var_f(id, "dps", 1.0)
    ia_ment_new_static_var_s(id, "sound_death", "die_fly")
    ia_ment_new_static_var_s(id, "identity_str", "Fly")
    local aura_radius = ment_monster_gnat.aura_radius
    local gas_period = ment_monster_gnat.gas_period
    local gas_trigger_dist = ment_monster_gnat.gas_trigger_dist
    ia_ment_new_static_var_b(id, "damage_aura_has", true)
    ia_ment_new_static_var_f(id, "damage_aura_duration", 2.0)
    ia_ment_new_static_var_i(id, "damage_aura_damage", 2)
    ia_ment_new_static_var_f(id, "damage_aura_radius", 32.0)
    ia_ment_new_static_var_b(id, "damage_aura_only_same_level", true)
    ia_ment_new_var_f(id, "damage_aura_next_time", 0.0, 60.0)
    ia_ment_set_builtin_var_f(id, "__gas_cloud_period", gas_period)
    ia_ment_set_builtin_var_f(id, "__gas_cloud_radius", aura_radius)
    ia_ment_set_builtin_var_f(id, "__gas_cloud_trigger_dist", gas_trigger_dist)
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
