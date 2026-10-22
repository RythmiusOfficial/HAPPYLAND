function p.has_effect(level, bp)
    local max_health = ga_get_i("xar.player.health.max")
    local old_health = ga_get_i("xar.player.health.amount")
    local old_armor = ga_get_i("xar.player.armor.amount")
    if ( old_health < 2*max_health ) then return true end
    if ( old_armor < 2*max_health ) then return true end
    return false
end

function p.__get_touch_dist()
    return ga_get_f("xar.normal_bent_touch_dist")
end

function p.payload(level, bp)
    local max_value = ga_get_i("xar.player.health.max")
    local old_health = ga_get_i("xar.player.health.amount")
    local old_armor = ga_get_i("xar.player.armor.amount")
    local picking_up = false
    if( old_health < 2*max_value ) then
        ga_set_i("xar.player.health.amount", 2*max_value)
        picking_up = true
    end
    if( old_armor < 2*max_value ) then
        ga_set_i("xar.player.armor.amount", 2*max_value)
        picking_up = true
    end
    if picking_up then
        ga_play_sound("pickup_armor")
        game_bent.remove_temp(level, bp, 60 * 60)
        game_msg.add("Health and armor both up to 200%")
    end
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    local core = "To 200% Health + Armor"
    if( p.has_effect(level, bp) ) then return "^xffff00" .. core
    else return "^xff0000" .. core end
end

function p.__on_use(level, bp)
    ga_play_sound("xar_error")
    game_msg.add("You must touch this item")
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end
