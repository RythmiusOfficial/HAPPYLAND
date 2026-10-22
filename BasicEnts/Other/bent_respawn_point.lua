--File: bent_respawn_point.lua

-------------------------------------------------
--              Xar Respawn Point
-------------------------------------------------
-- This is the xar version of the "respawn point"
-- that is found in the base package.

function p.__get_mesh() return "" end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Respawn Point"
end

function p.__on_use(level, bp)
    ga_play_sound_menu("use")
    ga_window_push("win_base_respawn_point") --New way.
end

function p.__on_use2(level, bp)
    game_bookmark_tele.start_tele_from_respawn_point()
end

function p.__on_render(level, bp)
    local vcp = std.bp_to_parent_vcp(bp)
    local chunk_id = ga_vcp_to_chunk_id(level, vcp)
    local path = ga_chunk_id_to_path(chunk_id)
    --
    local respawn_path = ga_get_respawn_path()
    --
    local mesh_name = "bent_base_respawn_inactive"
    if( path == respawn_path ) then
        mesh_name = "bent_base_respawn_active"
    end
    --
    --Creating the classic "pulsating" look.
    local cur_time = ga_get_game_time()
    scale = 1.0 + math.cos(6.0 * cur_time) * 0.1
    ga_render_matrix_scaled(scale, scale, scale);
    --
    ga_render_mesh(mesh_name)
end
