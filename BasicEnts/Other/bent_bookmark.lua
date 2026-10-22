-------------------------------------------------
--              Xar Respawn Point
-------------------------------------------------
-- This is the xar version of the "respawn point"
-- that is found in the base package.

-- function p.__get_mesh() return "bent_bookmark" end

function p.has_current_bookmark()
    return ga_get_b("xar.world_pos.bookmark.has")
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Bookmark"
end

function p.__on_use(level, bp)
    if( p.has_current_bookmark() ) then
        ga_window_push("win_bookmark2")
    else
        ga_window_push("win_bookmark")
    end
end

function p.__on_use2(level, bp)
    if( p.has_current_bookmark() ) then
        game_msg.add("You already have a current bookmark")
        game_msg.add("Left click to deal with this")
        ga_play_sound("error")
    else
        local chunk_id = ga_bp_to_parent_chunk_id(level, bp)
        local lbp = ga_bp_to_lbp(bp)
    game_bookmark_tele.start_tele_from_bookmark(chunk_id, lbp)
    end
end

function p.__on_render(level, bp)
    local mesh_name = "bent_bookmark"
    if( p.has_current_bookmark() ) then
        mesh_name = "bent_bookmark_gray"
    end
    --
    --Creating the classic "pulsating" look.
    local cur_time = ga_get_game_time()
    scale = 1.0 + math.cos(6.0 * cur_time) * 0.1
    ga_render_matrix_scaled(scale, scale, scale);
    --
    ga_render_mesh(mesh_name)
end
