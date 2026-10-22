function p.has_effect(level, bp)
    local max_value = 5*ga_get_i("xar.player.health.max")
    local old_value = ga_get_i("xar.player.health.amount")
    return ( old_value < max_value );
end

function p.__get_touch_dist()
    return ga_get_f("xar.normal_bent_touch_dist")
end

function p.__on_touch(level, bp)
    local one_hundred_p = ga_get_i("xar.player.health.max")
    local max_value = 5*one_hundred_p
    local old_value = ga_get_i("xar.player.health.amount")
    local new_value = old_value + one_hundred_p
    if( new_value > max_value ) then new_value = max_value end
    if ( new_value > old_value ) then
        ga_set_i("xar.player.health.amount", new_value)
        ga_play_sound("pickup_health_mega")
        game_bent.remove_temp(level, bp, 60 * 60)
        game_msg.add("You got an extra 100% health")
    end
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    local core = "Extra 100% health"
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
