-------------------------------------------------
--             Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_f(id, "__ttl", 60.0 * 60.0 * 10000) --Will be set.
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 0) --Right?
    ia_ment_set_builtin_var_i(id, "__extra_max_levels", 5) --Right?
    ia_ment_set_builtin_var_f(id, "__radius", 1.0) --Will be set.
    ia_ment_set_builtin_var_s(id, "__mesh", "")
    -- ia_ment_set_builtin_var_s(id, "__mesh", "MonsterBloodBoy") --Debugging.
    ia_ment_set_builtin_var_b(id, "__solid_wrt_player", false)
    ia_ment_set_builtin_var_f(id, "__turn_speed", 0.0)
    ia_ment_set_builtin_var_b(id, "__turn_towards_player", false)
    ia_ment_set_builtin_var_b(id, "__solid_wrt_player", false)
    ia_ment_set_builtin_var_b(id, "__collides", false)
    ia_ment_set_builtin_var_i(id, "__team_id_source", 1)
    ia_ment_set_builtin_var_i(id, "__team_id_target", 0)
    ia_ment_new_var_f(id, "emp_start_time", -1.0, 60.0 * 60.0 * 10000) --Will be set.
    ia_ment_new_var_i(id, "damage", 1, 60.0 * 60.0 * 10000) --Will be set.
    ia_ment_new_var_i(id, "effect_level", -1, 60.0 * 60.0 * 10000) --Will be set.
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------
