-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 2)
    ia_ment_set_builtin_var_f(id, "__radius", 1.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "nuke2")
    ia_ment_set_builtin_var_f(id, "__ttl", 0.1) -- right varname?
    ia_ment_new_static_var_b(id, "identifies", true)
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.__on_update(
    inst_id,
    elapsed_time,
    elapsed_level_time)
--
    --It explodes immediately.
    local level = ga_ment_get_level(inst_id)
    local lp = ga_ment_get_lp(inst_id)
    ment_player_proj_nuke_1.explode(inst_id, level, lp)
    ga_ment_remove(inst_id)
end
