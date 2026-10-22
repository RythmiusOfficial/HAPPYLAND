function p.already_using()
    return ga_get_b("xar.player.cheat_common_markers") 
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    if p.already_using() then
        return "Already using"
    else
        return "Enable Cheap Common Markers"
    end
end

function p.__on_use(level, bp)
    if p.already_using() then return end
    ga_play_sound_menu("use")
    ga_window_push("win_cheap_common_markers")
end
