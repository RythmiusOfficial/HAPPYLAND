function p.has_effect(level, bp)
    max_value = game_wep_modes.get_ammo_max(9)
    old_value = ga_get_i("xar.player.gun9.ammo")
    return ( old_value < max_value );
end

function p.payload(level, bp)
    if not game_can_use.main(9) then return end    
    local max_value = game_wep_modes.get_ammo_max(9)
    local old_value = ga_get_i("xar.player.gun9.ammo")
    local new_value = old_value + 1
    if( new_value > max_value ) then new_value = max_value end
    if ( new_value > old_value ) then
        ga_set_i("xar.player.gun9.ammo", new_value)
        ga_play_sound("pickup_ammo")
        game_bent.remove_temp(level, bp, 60 * 60)
        game_msg.add("You got a nuke")
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
    if not game_can_use.main(9) then
        return bent_ammo_gun_2_small.cannot_use_msg()
    end
    local core = "Nuke"
    if( p.has_effect(level, bp) ) then return core
    else return "^xff0000" .. core end
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
