function p.exists()
    local code_id = ga_get_i("xar.player.tracking_marker")
    return (code_id >= 0) --Roaming code ids are negative.
end

function p.exists_and_enabled()
    if( not p.exists() ) then return false end
    if( ga_get_b("xar.player.tracking_marker_hide") ) then return false end
    return true
end

function p.refresh_path()
    local code_id = ga_get_i("xar.player.tracking_marker")
    local last_code_id = ga_get_i("xar.player.tracking_marker_last_id")
    if( code_id == last_code_id ) then
        --Is this safe?
        return
    end
    ga_set_i("xar.player.tracking_marker_last_id", code_id)
    --
    local beacon_inst_id = p.get_beacon_inst_id()
    if( beacon_inst_id < 0 ) then return end --Unable to set path.
    local chunk_id = ga_ment_get_i(beacon_inst_id, "__chunk_id")
    if( chunk_id < 0 ) then return end --Should not happen.
    local level = ga_chunk_id_to_level(chunk_id)
    -- local path1 = ga_chunk_id_to_path(chunk_id)
    -- ga_set_s("xar.player.tracking_marker_path", path1)
    local beacon_lp = ga_ment_get_lp(beacon_inst_id)
    local beacon_bp = std.lp_to_bp(beacon_lp)
    local path2 = ga_bp_to_path(level, beacon_bp)
    ga_set_s("xar.player.tracking_marker_path", path2)
    -- ga_print("  game_tracking_marker.refresh_path:")
    -- ga_print("    path1 = " .. path1)
    -- ga_print("    path2 = " .. path2)
end

function p.recalc_dist_and_dir_from_path()
    local viewer_path_ext = ga_get_viewer_path_ext()
    local beacon_path = ga_get_s("xar.player.tracking_marker_path")
    --
    --One day (maybe if I want to kill a few days to a week)
    --I can write the "smarter" ga_path_diff function,
    --which is more accurate when the two paths are right next to
    --each other, but technically the paths only have a short initial
    --segment in common with each other!!!
    --This (not as smart) version works by 
    --first finding the finiest
    --chunk C that contains path path1 and path2.
    --Then we calcualte the global positions of path1
    --path 2 within C.
    local ret = ga_path_diff(viewer_path_ext, beacon_path)
    --
    if( ret.is_valid ) then
        --Setting dist and dir.
        ga_set_f("xar.player.tracking_marker_dist", math.floor(ret.dist))
        ga_set_v("xar.player.tracking_marker_dir", ret.dir)
    else
        --Aborting.
        ga_set_f("xar.player.tracking_marker_dist", 0.0)
        ga_set_v("xar.player.tracking_marker_dir", std.vec(0.0, 0.0, 0.0))
    end
end

--Returns true iff succeeds.
function p.recalc_dist_and_dir_from_ment()
    --Calculating the dist.
    local viewer_level = ga_get_viewer_level()
    local viewer_lp = ga_get_viewer_offset()
    --
    local beacon_inst_id = p.get_beacon_inst_id()
    local ret1 = p.get_beacon_lp_from_ment(beacon_inst_id, beacon_target_lp)
    if( not ret1.is_valid ) then return false end
    local beacon_target_lp = ret1.value
    --
    local new_dist = std.dist(viewer_lp, beacon_target_lp)
    ga_set_f("xar.player.tracking_marker_dist", new_dist)
    
    --Calculating the dir.
    local viewer_lp = ga_get_viewer_offset()
    local diff = std.vec_sub(beacon_target_lp, viewer_lp)
    std.normalize(diff)
    ga_set_v("xar.player.tracking_marker_dir", diff)

    return true
end

function p.recalc_dist_and_dir()
    -- p.recalc_dist_and_dir_from_path() --Call this if want to debug.

    local beacon_inst_id = p.get_beacon_inst_id()
    if( beacon_inst_id >= 0 ) then
        --Trying to do it the fast way.
        if( p.recalc_dist_and_dir_from_ment() ) then
            --Calculated dist and dir the fast way.
            return
        end
        --It failed.
    end
    --Doing it the slow way.
    p.recalc_dist_and_dir_from_path()
end

function p.refresh_maybe()
    --Should refresh the dir and dist every 0.5 seconds.
    local gt = ga_get_game_time()
    local last_time = ga_get_f("xar.player.tracking_marker_last_time")
    local update_length = 0.5
    if( gt < last_time + update_length and --Normal.
        gt > last_time - update_length )   --Saftey.
    then
        return
    end
    --Refreshing now.
    p.refresh_path()
    p.recalc_dist_and_dir()
    --
    --Should refresh next one second from now.
    ga_set_f("xar.player.tracking_marker_last_time", gt)
end

function p.drop()
    ga_set_i("xar.player.tracking_marker", -1)
end

function p.hide()
    ga_set_b("xar.player.tracking_marker_hide", true);
end

function p.unhide()
    ga_set_b("xar.player.tracking_marker_hide", false);
end

function p.get_beacon_inst_id()
    local beacon_code_id = ga_get_i("xar.player.tracking_marker")
    return ga_ment_code_id_to_inst_id(beacon_code_id)
end

--Sets the level position of the beacon.
--Returns a table with members "is_valid" and "value",
--where is_valid is a bool and value is a vector.
function p.get_beacon_lp_from_ment(beacon_inst_id, result)
    local beacon_level = ga_ment_get_i(beacon_inst_id, "__level")
    local beacon_source_lp = ga_ment_get_lp(beacon_inst_id);
    local viewer_level = ga_get_viewer_level()
    --
    return ga_convert_lp(beacon_level, viewer_level, beacon_source_lp)
end

function p.get_dist()
    if( not p.exists() ) then return end --Saftey.
    p.refresh_maybe()
    return ga_get_f("xar.player.tracking_marker_dist")
end

function p.refresh_attack_display()
    p.refresh_maybe()
    --
    local name = "tracking_beacon"
    local duration = 1.1
    if( not p.exists_and_enabled() ) then
        --Clearing the display icon.
        local tex = ""
        ga_hud_reg_dir_tex(name, tex, std.vec(0.0, 0.0, 1.0), duration)
        return
    end
    local dir = ga_get_v("xar.player.tracking_marker_dir")

    --The debugging way:
    -- local beacon_inst_id = p.get_beacon_inst_id()
    -- local viewer_lp = ga_get_viewer_offset()
    -- local beacon_lp = p.get_beacon_lp(beacon_inst_id)
    -- local dir = std.vec_sub(beacon_lp, viewer_lp)

    local tex = "icon_beacon_alpha"
    ga_hud_reg_dir_tex(name, tex, dir, duration)
end
