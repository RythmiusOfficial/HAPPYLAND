-------------------------------------------------
--            Type Init Function
-------------------------------------------------

--See ment_rocket_1_explosion for how this works.

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 2)
    ia_ment_set_builtin_var_f(id, "__radius", 0.0) --Will set.
    ia_ment_set_builtin_var_s(id, "__mesh", "rocket3_explosion")
    ia_ment_set_builtin_var_b(id, "__force_no_lighting", true) --Weird.
    ia_ment_set_builtin_var_f(id, "__ttl", 1.0)
    ia_ment_new_var_f(id, "launch_level", -1, 60*60)
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.__on_add_to_live_world(inst_id)
    local mode = 3
    ment_rocket_1_explosion.spawn_helper1(inst_id, mode)
end
