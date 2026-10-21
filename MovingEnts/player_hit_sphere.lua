--This moving entity is special.
--It is automatically moved by the engine to be where the player is.
--The main package should define their own player_hit_sphere entity.

-------------------------------------------------
--              Damage AND Health
-------------------------------------------------

function p.get_getting_hit_type() return "player" end
function p.get_hitting_type() return "" end

-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    ia_ment_set_builtin_var_b(id, "__disable_saving", true)
    ia_ment_set_builtin_var_f(id, "__ttl", -1.0)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 1234567)
    ia_ment_set_builtin_var_i(id, "__extra_max_levels", 1234567)
    ia_ment_set_builtin_var_f(id, "__radius", 1.0)
    ia_ment_set_builtin_var_b(id, "__radius_lvlinv", true) --Unusual.
    ia_ment_set_builtin_var_s(id, "__mesh", "") --Invisible.
    ia_ment_set_builtin_var_b(id, "__solid_wrt_player", false)
    ia_ment_set_builtin_var_b(id, "__collides", false)
    ia_ment_set_builtin_var_i(id, "__team_id_source", 0)
    ia_ment_set_builtin_var_i(id, "__team_id_target", 1)
end
