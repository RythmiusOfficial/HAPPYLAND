-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_f(id, "__ttl", 60.0 * 60.0 * 3.0)
    ia_ment_set_builtin_var_f(id, "__radius", 0.75)
    ia_ment_set_builtin_var_s(id, "__mesh", "") --Uses custom render function.
    ia_ment_set_builtin_var_b(id, "__solid_wrt_player", false)
    ia_ment_set_builtin_var_f(id, "__turn_speed", 0.0)
    ia_ment_set_builtin_var_b(id, "__turn_towards_player", false)
    -- ia_ment_set_builtin_var_i(id, "__team_id_source", 0)
    -- ia_ment_set_builtin_var_i(id, "__team_id_target", 2)
    ia_ment_new_var_i(id, "health_max", -1, 60.0)
    ia_ment_new_var_i(id, "health", 100, 60.0)
    ia_ment_new_var_i(id, "health_max_curved", -1, 3600.0)
    ia_ment_new_var_i(id, "health_curved", 1, 3600.0)
    ia_ment_new_static_var_b(id, "emp_immune", true)
end

function p.xar_process_got_hit(args, exceptions)
    ga_print("ment_marker_short.xar_process_got_hit")
    --This ment can only be damaged by plasma.
    source_type_name = ga_ment_get_type(args.source_inst_id)
    if( source_type_name ~= "ment_player_proj_plasma_1" and
        source_type_name ~= "ment_player_proj_plasma_2" )
    then
        exceptions.no_damage = true
    end
    local ret = game_ment_hit.process_final(args, exceptions)
    return ret
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.__get_can_use(inst_id)
    return true
end

--Removing the marker.
function p.__on_use2(inst_id)
    ga_ment_remove(inst_id)
end

function p.__get_use_msg(inst_id)
    return "Use To Remove"
end

function p.__on_use(inst_id)
    ga_ment_remove(inst_id)
    -- ga_ment_remove_now(inst_id)
end

function p.__on_render(inst_id, ment_radius)
    --Rotating (modifying the matrix stack)
    --according to the default "frame" of the ment.
    ga_render_matrix_frame_from_ment(inst_id)
    --
    --Getting the correct mesh name.
    local game_time = ga_get_game_time()
    local game_time_floor = math.floor(game_time)
    local game_time_rem = game_time - game_time_floor
    local mesh = ""
    if( game_time_rem < 0.5 ) then
        mesh = "marker_short_1"
    else
        mesh = "marker_short_2"
    end
    --
    --Scaling.
    --We could be smart and cache these.
    local ment_radius = ga_ment_get_radius(inst_id)
    local mesh_inv_radius = ga_mesh_get_inv_radius(mesh)
    local scale = ment_radius * mesh_inv_radius
    ga_render_matrix_scaled(scale, scale, scale)
    --
    --Actually rendering.
    ga_render_mesh(mesh)
end
