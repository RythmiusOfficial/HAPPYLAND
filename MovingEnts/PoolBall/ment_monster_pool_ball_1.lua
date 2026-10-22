-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.pool_ball_init_common(id, speed)
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_f(id, "shoot_period", 1.0)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_marine_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 0.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 1.0)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 1)
    ia_ment_new_static_var_s(id, "shoot_alt_attack_icon", "icon_skull")
    --
    ia_ment_set_builtin_var_b(id, "__homing", true) --Weird.
    ia_ment_set_builtin_var_f(id, "__homing_speed", speed)
    ia_ment_set_builtin_var_b(id, "__homing_player_pathing", true)
    ia_ment_set_builtin_var_b(id, "__collides", false)
    ia_ment_set_builtin_var_b(id, "__point_block_correct", true)
    --
    ia_ment_new_static_var_b(id, "damage_aura_has", true)
    ia_ment_new_static_var_b(id, "damage_aura_suicide_bomb", true)
    ia_ment_new_static_var_f(id, "damage_aura_duration", 0.1)
    ia_ment_new_static_var_i(id, "damage_aura_damage", 10000000)
    ia_ment_new_static_var_f(id, "damage_aura_radius", 10.0)
    ia_ment_new_var_f(id, "damage_aura_next_time", 0.0, 60.0)
end

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 3.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterPoolBall1")
    ia_ment_new_var_i(id, "health", 1000000000, 60.0)
    ia_ment_new_static_var_f(id, "dps", 10.0)
    ia_ment_new_static_var_s(id, "sound_hurt", "hurt_deep_ahh")
    ia_ment_new_static_var_f(id, "sound_hurt_period", 0.5)
    ia_ment_new_static_var_s(id, "sound_death", "holy_cow")
    ia_ment_new_static_var_b(id, "emp_immune", true)
    ia_ment_new_var_b(id, "emp_immune_true", false, 60*5)
    ia_ment_new_static_var_b(id, "freeze_immune_true", true)
    ia_ment_new_static_var_s(id, "identity_str", "One Ball")
    ia_ment_new_static_var_b(id, "shoots", false)
    local speed = 2
    ment_monster_pool_ball_1.pool_ball_init_common(id, speed)
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
