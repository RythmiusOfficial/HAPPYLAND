-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 2)
    ia_ment_set_builtin_var_f(id, "__radius", 0.0) --Will set.
    ia_ment_set_builtin_var_s(id, "__mesh", "nuke2_explosion")
    ia_ment_set_builtin_var_b(id, "__force_no_lighting", true) --Weird.
    ia_ment_set_builtin_var_f(id, "__ttl", 1.0)

    --The level in which the rocket was launched.
    ia_ment_new_var_f(id, "launch_level", -1, 60*60)
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.__on_add_to_live_world(inst_id)
    local base_radius = 200.0
    ment_rocket_1_explosion.spawn_helper2(inst_id, base_radius)
end
