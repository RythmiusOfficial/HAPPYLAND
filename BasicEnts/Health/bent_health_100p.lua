function p.has_effect(level, bp)
    local max_value = ga_get_i("xar.player.health.max")
    local old_value = ga_get_i("xar.player.health.amount")
    return ( old_value < max_value );
end

function p.__get_touch_dist()
    return ga_get_f("xar.normal_bent_touch_dist")
end

function p.__on_touch(level, bp)
    local max_value = ga_get_i("xar.player.health.max")
    local old_value = ga_get_i("xar.player.health.amount")
    if( old_value < max_value ) then
        ga_set_i("xar.player.health.amount", max_value)
        ga_play_sound("pickup_health_100p")
        game_bent.remove_temp(level, bp, 60 * 60)
        game_msg.add("Your health is now up to 100%")
    end
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    local core = "To 100% Health"
    if( p.has_effect(level, bp) ) then return "^xffff00" .. core
    else return "^xff0000" .. core end
end

function p.__on_use(level, bp)
    ga_play_sound("xar_error")
    game_msg.add("You must touch this item")
end

function p.on_telekinesis(level, bp)
    p.__on_touch(level, bp)
end
