function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Use to remove"
end

function p.__on_use(level, bp)
    ga_play_sound_menu("use")
    game_bent.remove_perm(level, bp)
end
