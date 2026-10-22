-------------------------------------------------
--           Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 3.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterInnerCore")
    ia_ment_new_var_i(id, "health", 5000000, 60.0)
    ia_ment_new_static_var_f(id, "dps", 30.0)
    ia_ment_new_static_var_s(id, "sound_death", "die_i_am_eternal")
    ia_ment_new_static_var_s(id, "sound_hurt", "hurt_very_deep_ahh")
    ia_ment_new_static_var_f(id, "sound_hurt_period", 0.6)
    ia_ment_new_static_var_s(id, "identity_str", "Inner Core")
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_f(id, "shoot_period", 1.0)
    ia_ment_new_static_var_b(id, "shoot_period_lvlinv", true)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_vulcan_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 1000000.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 5.0)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 30) --3 seconds to kill player.
    ia_ment_new_static_var_b(id, "damage_aura_has", true)
    ia_ment_new_static_var_f(id, "damage_aura_duration", 1.0)
    ia_ment_new_static_var_i(id, "damage_aura_damage", 1000)
    ia_ment_new_static_var_f(id, "damage_aura_radius", 3.0)
    ia_ment_new_var_f(id, "damage_aura_next_time", 0.0, 60.0)
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

function p.xar_process_got_hit(args, exceptions)
    --This ment is not affected by the player having any
    --powerups, such as an increased damage modifier.
    exceptions.no_damage_powerups = true
    ret = game_ment_hit.process_final(args, exceptions)
    return ret
end

function p.on_die(inst_id)
    game_ment_die.default() --May want to remove.

    xar_ment_helpers.create_ment_drop(
        inst_id, "monster_clockwork_architect_drop1", 1.0)
end
