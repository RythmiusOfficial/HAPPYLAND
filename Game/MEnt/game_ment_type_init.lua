function p.helper_default_shooting(id)
    ia_ment_new_static_var_b(id, "shoots", false)
    ia_ment_new_static_var_f(id, "shoot_period", 1.0)
    ia_ment_new_static_var_b(id, "shoot_period_lvlinv", false)
    ia_ment_new_static_var_b(id, "shoot_only_different_level", false)
    ia_ment_new_static_var_f(id, "shoot_radius", 1000.0)
    ia_ment_new_var_f(id, "shoot_time", 0.0, 60.0)
    --
    ia_ment_new_static_var_s(id, "shoot_proj_type", "INVALID")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 10.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 10.0)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 1)
    ia_ment_new_var_i(id, "shoot_proj_inst_id", -1, 60.0)
    ia_ment_set_var_saving(id, "shoot_proj_inst_id", false)
    ia_ment_new_var_b(id, "shoot_proj_allow_multiple", false, 60.0 * 60.0)
    --
    ia_ment_new_static_var_s(id, "shoot_alt_attack_icon", "")
end

function p.helper_default_shooting_secondary(id)
    ia_ment_new_static_var_b(id, "secondary_shoots", false)
    ia_ment_new_static_var_f(id, "secondary_shoot_period", 1.0)
    ia_ment_new_static_var_b(id, "secondary_shoot_period_lvlinv", false)
    ia_ment_new_static_var_b(id, "secondary_shoot_only_different_level", false)
    ia_ment_new_static_var_f(id, "secondary_shoot_radius", 1000.0)
    ia_ment_new_static_var_f(id, "secondary_accuracy", 0.0)
    ia_ment_new_var_f(id, "secondary_shoot_time", 0.0, 60.0)
    ia_ment_set_var_saving(id, "secondary_shoot_time", false)
    --
    ia_ment_new_static_var_s(id, "secondary_shoot_proj_type", "INVALID")
    ia_ment_new_static_var_f(id, "secondary_shoot_proj_speed", 10.0)
    ia_ment_new_static_var_f(id, "secondary_shoot_proj_ttl", 10.0)
    ia_ment_new_static_var_i(id, "secondary_shoot_proj_damage", 1)
    ia_ment_new_var_i(id, "secondary_shoot_proj_inst_id", -1, 60.0)
    ia_ment_set_var_saving(id, "secondary_shoot_proj_inst_id", false)
    --
    ia_ment_new_static_var_s(id, "secondary_shoot_alt_attack_icon", "")
end

--Should be called within the type init function
--of a typical Xar monster.
function p.monster(id)
    ia_ment_set_builtin_var_f(id, "__ttl", -1.0)
    ia_ment_set_builtin_var_b(id, "__solid_wrt_player", true)
    ia_ment_set_builtin_var_f(id, "__turn_speed", 0.5)
    ia_ment_set_builtin_var_b(id, "__turn_towards_player", true)
    ia_ment_set_builtin_var_i(id, "__team_id_source", 0)
    ia_ment_set_builtin_var_i(id, "__team_id_target", 2)
    ia_ment_set_builtin_var_i(id, "__extra_max_levels", 3)
    ia_ment_new_var_i(id, "health_max", -1, 60.0)
    ia_ment_new_var_i(id, "health", 1, 60.0) --Important that it is positive!
    ia_ment_new_var_i(id, "health_max_curved", -1, 3600.0)
    ia_ment_new_var_i(id, "health_curved", 1, 3600.0)
    ia_ment_new_var_b(id, "emp_stunned", false, 36000.0)
    ia_ment_new_var_f(id, "emp_stun_endtime", 0.0, 3600.0)
    ia_ment_new_var_b(id, "frozen", false, 36000.0)
    ia_ment_new_var_f(id, "freeze_endtime", 0.0, 3600.0)
    ia_ment_new_var_b(id, "poisoned", false, 36000.0)
    ia_ment_new_var_f(id, "poison_dps", 0.0, 36000.0)
    ia_ment_new_var_f(id, "poison_endtime", 0.0, 36000.0)
    ia_ment_new_var_f(id, "poison_lasthit", 0.0, 36000.0)
    ia_ment_new_var_f(id, "last_sound_hurt", -1.0, 60.0)
    ia_ment_set_var_saving(id, "last_sound_hurt", false)
    game_ment_homing_nerf.ment_monster_type_init_helper(id)
    --
    --Must create the bool var individual_delay_has
    --and set it to true to use these (in the proj type).
    ia_ment_new_var_f(id, "individual_delay_last_time", -1.0, 60.0)
    ia_ment_new_var_f(id, "individual_delay_total_time", -1.0, 60.0)
    --
    p.helper_default_shooting(id)
    --
    --Registering callbacks for when vars are changed.
    ia_ment_set_var_changed_cb(id, "health",        "game_ment_health.health_var_changed_cb")
    ia_ment_set_var_changed_cb(id, "health_curved", "game_ment_health.health_var_changed_cb")
end

function p.monster_proj(id)
    ia_ment_set_builtin_var_f(id, "__ttl", 60.0)
    ia_ment_set_builtin_var_b(id, "__solid_wrt_player", false)
    ia_ment_set_builtin_var_f(id, "__turn_speed", 0.0)
    ia_ment_set_builtin_var_b(id, "__turn_towards_player", false)
    ia_ment_set_builtin_var_i(id, "__team_id_source", 2)
    ia_ment_set_builtin_var_i(id, "__team_id_target", 0)
    ia_ment_set_builtin_var_i(id, "__extra_max_levels", 3) --Right.
    ia_ment_new_var_i(id, "health_max", 1, 60.0)
    ia_ment_new_var_i(id, "health", 1, 60.0)
    ia_ment_new_var_i(id, "health_max_curved", -1, 3600.0)
    ia_ment_new_var_i(id, "health_curved", 1, 3600.0)
    ia_ment_new_var_i(id, "parent_inst_id", -1, 36000.0) --Make this built in?
    ia_ment_new_var_i(id, "damage", 0, 3600.0)
    --
    --Just adding this May 21, 2024.
    ia_ment_new_var_b(id, "emp_stunned", false, 36000.0)
    ia_ment_new_var_f(id, "emp_stun_endtime", 0.0, 3600.0)
    ia_ment_new_var_b(id, "frozen", false, 36000.0)
    ia_ment_new_var_f(id, "freeze_endtime", 0.0, 3600.0)
    ia_ment_new_var_b(id, "poisoned", false, 36000.0)
    ia_ment_new_var_f(id, "poison_dps", 0.0, 36000.0)
    ia_ment_new_var_f(id, "poison_endtime", 0.0, 36000.0)
    ia_ment_new_var_f(id, "poison_lasthit", 0.0, 36000.0)
    --
    ia_ment_new_static_var_s(id, "alt_attack_icon", "")
    ia_ment_new_static_var_b(id, "is_proj", true)
    ia_ment_new_var_b(id, "hive_attack", false, 60.0)
    ia_ment_new_var_f(id, "hive_attack_delay", 2.0, 60.0)
    --
    p.helper_default_shooting(id)
    --
    --Registering callbacks for when vars are changed.
    ia_ment_set_var_changed_cb(id, "health",        "game_ment_health.health_var_changed_cb")
    ia_ment_set_var_changed_cb(id, "health_curved", "game_ment_health.health_var_changed_cb")
end

function p.monster_drop(id)
    ia_ment_set_builtin_var_f(id, "__ttl", -1.0)
    ia_ment_set_builtin_var_b(id, "__solid_wrt_player", true)
    ia_ment_set_builtin_var_f(id, "__turn_speed", 0.5)
    ia_ment_set_builtin_var_b(id, "__turn_towards_player", true)
    ia_ment_set_builtin_var_i(id, "__team_id_source", 0)
    ia_ment_set_builtin_var_i(id, "__team_id_target", 0)
    p.helper_default_shooting(id)
end

function p.player_proj(id)
    ia_ment_set_builtin_var_f(id, "__ttl", 60.0)
    ia_ment_set_builtin_var_b(id, "__solid_wrt_player", false)
    ia_ment_set_builtin_var_b(id, "__turn_towards_player", false)
    ia_ment_set_builtin_var_i(id, "__team_id_source", 1)
    ia_ment_set_builtin_var_i(id, "__team_id_target", 0)
    ia_ment_new_var_i(id, "parent_inst_id", -1, 36000.0) --Make this built in?
    ia_ment_new_var_i(id, "ignore_ment_inst_id", -1, 36000.0)
    ia_ment_new_var_i(id, "damage", 0, 3600.0)
    p.helper_default_shooting(id)
end
