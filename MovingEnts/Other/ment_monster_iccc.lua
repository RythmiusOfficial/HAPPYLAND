-------------------------------------------------
--           Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 3.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterICCC")
    ia_ment_new_var_i(id, "health", 100000000, 60.0) --100 million.
    ia_ment_new_static_var_f(id, "dps", 1.0)
    ia_ment_new_static_var_s(id, "sound_death", "die_i_am_eternal")
    -- ia_ment_new_static_var_s(id, "sound_death", "holy_cow") --Not enough health to warrant this.
    ia_ment_new_static_var_s(id, "sound_hurt", "hurt_very_deep_ahh")
    ia_ment_new_static_var_f(id, "sound_hurt_period", 0.6)
    ia_ment_new_static_var_s(id, "identity_str", "Inner Core Consistency Certificate")
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
