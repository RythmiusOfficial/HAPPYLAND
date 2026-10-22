function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Change Game Difficulty"
end

function p.__on_use(level, bp)
    ga_play_sound_menu("use")
    ga_window_push("win_diff_change")
end
