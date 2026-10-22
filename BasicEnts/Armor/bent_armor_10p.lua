function p.has_effect(level, bp)
    local max_value = 10*ga_get_i("xar.player.health.max")
    local old_armor = ga_get_i("xar.player.armor.amount")
    return ( old_armor < max_value );
end

function p.payload(level, bp)
    local max_value = 10*ga_get_i("xar.player.health.max")
    local old_value = ga_get_i("xar.player.armor.amount")
    local new_value = old_value + math.floor(max_value / 100) --How to cast?
    if ( new_value > max_value ) then new_value = max_value end
    if ( new_value > old_value ) then
        ga_set_i("xar.player.armor.amount", new_value)
        ga_play_sound("pickup_armor_small")
        game_bent.remove_temp(level, bp, 60 * 60)
        game_msg.add("You got an extra 10% armor")
    end
end

function p.__get_touch_dist()
    local dist = ga_get_f("xar.normal_bent_touch_dist")
    return dist
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    local core = "10% Armor"
    if( p.has_effect(level, bp) ) then return core
    else return "^xff0000" .. core end
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
