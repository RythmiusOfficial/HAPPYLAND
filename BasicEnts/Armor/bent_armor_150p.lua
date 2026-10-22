function p.has_effect(level, bp)
    local max_value = 1.5 * ga_get_i("xar.player.health.max")
    local old_armor = ga_get_i("xar.player.armor.amount")
    return ( old_armor < max_value );
end

function p.__get_touch_dist()
    local dist = ga_get_f("xar.normal_bent_touch_dist")
    return dist
end

function p.__on_touch(level, bp)
    local max_value = math.floor( 1.5 * ga_get_i("xar.player.health.max") )
    local old_value = ga_get_i("xar.player.armor.amount")
    if ( old_value < max_value ) then
        ga_set_i("xar.player.armor.amount", max_value)
        ga_play_sound("pickup_armor")
        game_bent.remove_temp(level, bp, 60 * 60)
        game_msg.add("You got silver armor (150%)")
    end
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    local core = "150% Armor"
    if( p.has_effect(level, bp) ) then return "^xffff00" .. core
    else return "^xff0000" .. core end
end

function p.__on_use(level, bp)
    ga_play_sound("xar_error")
    game_msg.add("You must touch this item")
end
