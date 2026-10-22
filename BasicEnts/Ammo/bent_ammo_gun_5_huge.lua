function p.has_effect(level, bp)
    local max_value = game_wep_modes.get_ammo_max(5)
    local old_value = ga_get_i("xar.player.gun5.ammo")
    return ( old_value < max_value );
end

function p.ammo(level, bp)
    local default_amount = 2000 --Making it worse.
    local amount = ga_bent_get_param_i(level, bp)
    if (amount == 0) then amount = default_amount end
    return amount
end

function p.payload(level, bp)
    if not game_can_use.main(5) then return end

    local amount = p.ammo(level, bp)

    local max_value = game_wep_modes.get_ammo_max(5)
    local old_value = ga_get_i("xar.player.gun5.ammo")
    local new_value = old_value + amount
    if( new_value > max_value ) then new_value = max_value end
    if ( new_value > old_value ) then
        ga_set_i("xar.player.gun5.ammo", new_value)
        if( amount >= 100 ) then
            ga_play_sound("oh_yeah")
        else
            ga_play_sound("pickup_ammo")
        end
        local msg2 = "You got " .. tostring(new_value - old_value) .. " homing rockets"
        game_msg.add(msg2)
        game_bent.remove_temp(level, bp, 60 * 60)
    end
end

function p.__get_touch_dist()
    return 2.0
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    if not game_can_use.main(5) then
        return bent_ammo_gun_2_small.cannot_use_msg()
    end
    local ammo = p.ammo(level, bp)
    local core = tostring(ammo) .. " Homing Rockets"
    if( p.has_effect(level, bp) ) then return core
    else return "^xff0000" .. core end
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
