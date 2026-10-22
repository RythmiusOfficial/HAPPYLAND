function p.__get_mesh() return "bent_sleep" end

function p.__get_can_use(level, bp)
    local dist = ga_block_dist_to_viewer(level, bp)
    if( dist < 1.0 ) then return false end
    return true
end

function p.__get_use_msg(level, bp)
    if( not p.__get_can_use(level, bp) ) then return "" end
    return "Pay 300 to Sleep for an Hour"
end

function p.__on_use()
    ga_play_sound_menu("use")
    win_sleep.payload(60 * 60)
end
