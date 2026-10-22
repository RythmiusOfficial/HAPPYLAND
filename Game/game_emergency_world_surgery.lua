--File: game_emergency_world_surgery.lua

--This should be called every update to "fix"
--the world at the last minute.
function p.main()
    local chunk_id_1 = ga_get_viewer_chunk_id()
    local viewer_level_1 = ga_chunk_id_to_level(chunk_id_1)
    p.fix_chunk(chunk_id_1)

    local viewer_level_2 = viewer_level_1 - 1
    if( viewer_level_2 >= 0 ) then
        local chunk_id_2 = ga_get_viewer_ancestor_chunk_id(viewer_level_2)
        p.fix_chunk(chunk_id_2)
    end
end

--Fixing the kilo chunk that the player is in.
--The argument is the chunk id of that kchunk.
function p.fix_chunk(chunk_id)
    local bt = ga_chunk_id_to_bt(chunk_id)
    if( bt == "XAR_TUTORIAL" ) then
        p.fix_chunk_tutorial(chunk_id)
    end
end

--Modifing the non-emergency waypoint rooms.
--It would be smart to have this function create
--a dynamic variable associated to the tutorial chunk
--that stores whether or not the surgery has already
--been performed.  This would speed things up a bit.
function p.fix_chunk_tutorial(chunk_id)
    local level = ga_chunk_id_to_level(chunk_id)

    --Need to find the path of the emergency wp room inside this tutorial chunk.
    local data1 = ga_search_for_bt_in_chunk(chunk_id, "XAR_TUTORIAL_WP")
    if( data1.is_valid ) then
        local wp_room_lbp = data1.value
        local wp_room_bp = ga_chunk_id_and_lbp_to_bp(chunk_id, wp_room_lbp)
        local found_em_wp_path = ga_bp_to_path(level, wp_room_bp)
        local actual_em_wp_path = ga_get_emergency_waypoint_path()
        if( found_em_wp_path == actual_em_wp_path ) then
            --We are at our actual emergency waypoint.
            --We should do nothing.
            return
        end
    else
        --Must have already dealt with this tutorial chunk.
        return
    end
    --We are NOT at our actual emergency waypoint.
    --We need to make the following block changes:
    -- XAR_TUTORIAL_WP       -> XAR_TUTORIAL_WP_PRE
    -- XAR_TUTORIAL_WP_ABOVE -> XAR_TUTORIAL_WP_ABOVE_PRE
    --Note: there is a faster way to do the first of the following lines.
    ga_search_and_replace_bt_in_chunk_perm(chunk_id, "XAR_TUTORIAL_WP",       "XAR_TUTORIAL_WP_PRE")
    ga_search_and_replace_bt_in_chunk_perm(chunk_id, "XAR_TUTORIAL_WP_ABOVE", "XAR_TUTORIAL_WP_ABOVE_PRE")
    -- ga_search_and_replace_bt_in_chunk_perm(chunk_id, "XAR_TUTORIAL_14",       "XAR_TUTORIAL_14_PRE")
end
