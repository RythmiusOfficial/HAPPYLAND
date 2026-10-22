-------------------------------------------------
--            Type Init Function
-------------------------------------------------

--MAKE A MORE GENERAL PICTURE MENT!!!

function p.__type_init(id)
    --Not a typical init.
    ia_ment_set_builtin_var_b(id, "__disable_saving", true)
    ia_ment_set_builtin_var_f(id, "__ttl", 60.0 * 60.0)
    ia_ment_set_builtin_var_i(id, "__extra_max_levels", 3)
    -- ia_ment_set_builtin_var_s(id, "__mesh", "picture_m_to_omega")
    ia_ment_set_builtin_var_f(id, "__radius", 3.0)
    ia_ment_set_builtin_var_b(id, "__solid_wrt_player", false)
    ia_ment_set_builtin_var_f(id, "__turn_speed", 0.0)
    ia_ment_set_builtin_var_b(id, "__mesh_fixed_frame", true)
    ia_ment_set_builtin_var_b(id, "__force_no_lighting", true)
    ia_ment_set_builtin_var_b(id, "__turn_towards_player", false)
    ia_ment_set_builtin_var_i(id, "__team_id_source", 0)
    ia_ment_set_builtin_var_i(id, "__team_id_target", 2)
    --ia_ment_new_var_i("health", 1000, 60.0)
end

function p.__render(inst_id, radius)
    --Could be more general.
    -- local viewer_level = ga_get_viewer_level()
    -- local ment_level = ga_ment_get_level(inst_id)
    -- if( viewer_level ~= ment_level ) then return end
    ga_render_ment_typical(inst_id)
end
