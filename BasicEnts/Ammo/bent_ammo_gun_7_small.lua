function p.has_effect(level, bp)
    local max_value = game_wep_modes.get_ammo_max(7)
    local old_value = ga_get_i("xar.player.gun7.ammo")
    return ( old_value < max_value );
end

function p.payload(level, bp)
    if not game_can_use.main(7) then return end
    local max_value = game_wep_modes.get_ammo_max(7)
    local old_value = ga_get_i("xar.player.gun7.ammo")
    local new_value = old_value + 10
    if( new_value > max_value ) then new_value = max_value end
    if ( new_value > old_value ) then
        ga_set_i("xar.player.gun7.ammo", new_value)
        ga_play_sound("pickup_ammo")
        game_bent.remove_temp(level, bp, 60 * 60)
        local num_got = new_value - old_value
        if num_got == 1 then
            game_msg.add("You got 1 rail")
        else
            game_msg.add("You got " .. tostring(new_value - old_value) .. " rails")
        end
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
    if not game_can_use.main(7) then
        return bent_ammo_gun_2_small.cannot_use_msg()
    end
    local core = "10 Rails"
    if( p.has_effect(level, bp) ) then return core
    else return "^xff0000" .. core end
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
