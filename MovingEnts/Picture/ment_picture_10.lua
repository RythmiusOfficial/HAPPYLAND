-------------------------------------------------
--            Type Init Function
-------------------------------------------------

--The following is weird:
--When a mesh for a ment is loaded, we scale it so
--the farthest a vertex is from the origin is "1.0".
--Then we scale that mesh by the __radius number.

function p.__type_init(id)
    --Not a typical init.
    ia_ment_set_builtin_var_b(id, "__disable_saving", true)
    ia_ment_set_builtin_var_f(id, "__ttl", 60.0 * 60.0)
    ia_ment_set_builtin_var_i(id, "__extra_max_levels", 3)
    ia_ment_set_builtin_var_f(id, "__radius", 7.1)
    ia_ment_set_builtin_var_b(id, "__solid_wrt_player", false)
    ia_ment_set_builtin_var_f(id, "__turn_speed", 0.0)
    ia_ment_set_builtin_var_b(id, "__mesh_fixed_frame", true)
    ia_ment_set_builtin_var_b(id, "__force_no_lighting", true) --Weird.
    ia_ment_set_builtin_var_b(id, "__turn_towards_player", false)
    ia_ment_set_builtin_var_i(id, "__team_id_source", 0)
    ia_ment_set_builtin_var_i(id, "__team_id_target", 0)
    ia_ment_new_static_var_b(id, "emp_immune", true)
end

function p.__render(inst_id, radius)
    local viewer_level = ga_get_viewer_level()
    local ment_level = ga_ment_get_start_level(inst_id)
    if( viewer_level ~= ment_level ) then return end
    ga_render_ment_typical(inst_id)
end
