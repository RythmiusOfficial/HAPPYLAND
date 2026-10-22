function p.__get_can_use(level, bp)
    local dist = ga_block_dist_to_viewer(level, bp)
    if( dist < 1.0 ) then return false end
    return true
end

function p.__get_use_msg(level, bp)
    if( not p.__get_can_use(level, bp) ) then return "" end
    return "Sleep (choose a duration)"
end

function p.__on_use()
    ga_play_sound_menu("use")
    ga_window_push("win_sleep")
end
