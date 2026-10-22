function p.__get_mesh() return "bent_ammo_gun_2_small" end
function p.__get_mesh2() return "gun_ammo_once" end

function p.has_effect(level, bp)
    local max_value = game_wep_modes.get_ammo_max(2)
    local old_value = ga_get_i("xar.player.gun2.ammo")
    return ( old_value < max_value );
end

function p.payload(level, bp)
    if not game_can_use.main(2) then return end
    local max_value = game_wep_modes.get_ammo_max(2)
    local old_value = ga_get_i("xar.player.gun2.ammo")
    local new_value = old_value + 5
    if( new_value > max_value ) then new_value = max_value end
    if ( new_value > old_value ) then
        ga_set_i("xar.player.gun2.ammo", new_value)
        ga_play_sound("pickup_ammo")
        game_bent.remove_perm(level, bp)
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
    if not game_can_use.main(2) then
        return bent_ammo_gun_2_small.cannot_use_msg()
    end
    local core = "5 Shells (does not respawn)"
    if( p.has_effect(level, bp) ) then return core
    else return "^xff0000" .. core end
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
