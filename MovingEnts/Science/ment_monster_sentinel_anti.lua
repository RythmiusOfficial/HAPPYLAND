-------------------------------------------------
--       Other.
-------------------------------------------------

function p.xar_get_level_mod_damage_in(delta)
    if( delta == 0 ) then return 0.01 end
    return 1.0
end

-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 2.0) --Good?
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterSentinelAnti")
    ia_ment_new_var_i(id, "health", 100000, 60.0)
    ia_ment_new_static_var_f(id, "xp_mod", 2)
    ia_ment_new_static_var_f(id, "dps", 100.0)
    ia_ment_new_static_var_s(id, "sound_hurt", "hurt_machine_on")
    ia_ment_new_static_var_f(id, "sound_hurt_period", 0.7)
    ia_ment_new_static_var_s(id, "sound_death", "die_club_dryer_short")
    ia_ment_new_static_var_s(id, "die_drop_bent", "bent_upgrade_gun_8_time")
    ia_ment_new_static_var_s(id, "die_drop_box_txt", "EMP Freeze Time Upgrade")
    ia_ment_new_static_var_b(id, "die_drop_box_allow", true)
    ia_ment_new_static_var_i(id, "die_drop_extra_levels", 1)
    ia_ment_new_static_var_s(id, "identity_str", "Anti Sentinel")
    ia_ment_new_static_var_b(id, "shoots", false)
    -- ia_ment_new_static_var_f(id, "shoot_period", 1.0)
    -- ia_ment_new_static_var_b(id, "shoot_period_lvlinv", true)
    -- ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_spider_proj")
    -- ia_ment_new_static_var_f(id, "shoot_proj_speed", 10000.0)
    -- ia_ment_new_static_var_f(id, "shoot_proj_ttl", 1.0)
    -- ia_ment_new_static_var_i(id, "shoot_proj_damage", 1)
    --
    ia_ment_set_builtin_var_b(id, "__homing", true)
    ia_ment_set_builtin_var_f(id, "__homing_speed", 24.0)
    ia_ment_set_builtin_var_f(id, "__homing_min_dist", 0.0)
    ia_ment_set_builtin_var_b(id, "__homing_only_diff_level", true)
    ia_ment_set_builtin_var_b(id, "__collides", false)
    ia_ment_set_builtin_var_b(id, "__point_block_correct", true)
    ia_ment_set_builtin_var_b(id, "__ment_correct", true)
    --
    ia_ment_new_var_b(id, "picture_aura_has", true, 60.0)
    ia_ment_new_static_var_s(id, "picture_aura_picture", "crossbones")
    ia_ment_new_static_var_f(id, "picture_aura_radius", 32)
    ia_ment_new_static_var_b(id, "picture_aura_only_diff_level", true)
    ia_ment_new_var_f(id, "picture_aura_next_time", 0.0, 60.0)
    --
    ia_ment_new_static_var_b(id, "damage_aura_has", true)
    ia_ment_new_static_var_b(id, "damage_aura_suicide_bomb", true)
    ia_ment_new_static_var_f(id, "damage_aura_duration", 1.0)
    ia_ment_new_static_var_i(id, "damage_aura_damage", 1000)
    ia_ment_new_static_var_f(id, "damage_aura_radius", 4.0)
    ia_ment_new_var_f(id, "damage_aura_next_time", 0.0, 60.0)
    --MORE!!!
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
