function p.has_effect(level, bp)
    local max_value = ga_get_i("xar.player.shield.max")
    local old_value = ga_get_i("xar.player.shield.amount")
    return ( old_value < max_value )
end

function p.payload(level, bp)
    local max_value = ga_get_i("xar.player.shield.max")
    local old_value = ga_get_i("xar.player.shield.amount")
    if( old_value < max_value ) then
        ga_set_i("xar.player.shield.amount", max_value)
        ga_play_sound("pickup_shield")
        game_bent.remove_temp(level, bp, 60 * 60)
        game_msg.add("Your shield is recharged")
    end
end

function p.__get_touch_dist()
    return ga_get_f("xar.normal_bent_touch_dist")
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    local core = "Shield"
    if( p.has_effect(level, bp) ) then return core
    else return "^xff0000" .. core end
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end
