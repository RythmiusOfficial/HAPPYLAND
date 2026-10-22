-------------------------------------------------
--             Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_f(id, "__ttl", 60.0 * 60.0 * 10000)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 1)
    ia_ment_set_builtin_var_i(id, "__extra_max_levels", 1) --Right?
    ia_ment_set_builtin_var_f(id, "__radius", 2.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "") --Uses custom render function.
    ia_ment_set_builtin_var_b(id, "__solid_wrt_player", false)
    ia_ment_set_builtin_var_f(id, "__turn_speed", 0.0)
    ia_ment_set_builtin_var_b(id, "__turn_towards_player", false)
    -- ia_ment_set_builtin_var_i(id, "__team_id_source", 0)
    -- ia_ment_set_builtin_var_i(id, "__team_id_target", 2)
    ia_ment_new_var_i(id, "health_max", -1, 60.0)
    ia_ment_new_var_i(id, "health", 1000, 60.0)
    ia_ment_new_var_i(id, "health_max_curved", -1, 3600.0)
    ia_ment_new_var_i(id, "health_curved", 1, 3600.0)
    ia_ment_new_static_var_b(id, "emp_immune", true)
    ia_ment_new_var_s(id, "msg", "", 60.0 * 60.0 * 10000)
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.__get_can_use(inst_id)
    return true
end

function p.__get_use_msg(inst_id)
    return "Use To Read/Write Message"
end

--Opening the long marker menu.
function p.__on_use(inst_id)
    ga_create_i("temp.xar.marker_long_inst_id")
    ga_set_i("temp.xar.marker_long_inst_id", inst_id)
    local code_id = ga_ment_inst_id_to_code_id(inst_id)
    ga_create_i("temp.xar.marker_long_code_id")
    ga_set_i("temp.xar.marker_long_code_id", code_id)
    ga_window_push("win_marker_long")
end

--Removing the marker.
function p.__on_use2(inst_id)
    p.remove(inst_id)
end

function p.remove(inst_id)
    --Maybe removing the tracker marker.
    if game_tracking_marker.exists() then
        local this_code_id = ga_ment_inst_id_to_code_id(inst_id)
        local tracking_code_id = ga_get_i("xar.player.tracking_marker")
        if( this_code_id == tracking_code_id ) then
            --This ment is the tracking marker.
            game_tracking_marker.drop()
        end
    end
    --
    --Removing the moving entity.
    ga_ment_remove(inst_id)
end

function p.xar_process_got_hit(args, exceptions)
    --This ment can only be damaged by plasma.
    source_type_name = ga_ment_get_type(args.source_inst_id)
    if( source_type_name ~= "player_proj_plasma_1" and
        source_type_name ~= "player_proj_plasma_2" )
    then
        exceptions.no_damage = true
    end
    local ret = game_ment_hit.process_final(args, exceptions)
    return ret
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
        mesh = "marker_long_1"
    else
        mesh = "marker_long_2"
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
