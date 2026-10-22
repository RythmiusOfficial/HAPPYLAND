function p.__get_mesh() return "bent_ammo_gun_1" end
function p.__get_mesh2() return "gun_ammo_once" end

function p.has_effect(level, bp)
    local max_value = game_wep_modes.get_ammo_max(1)
    local old_value = ga_get_i("xar.player.gun1.ammo")
    return ( old_value < max_value );
end

function p.payload(level, bp)
    local max_value = game_wep_modes.get_ammo_max(1)
    local old_value = ga_get_i("xar.player.gun1.ammo")
    if( old_value < max_value ) then
        ga_set_i("xar.player.gun1.ammo", max_value)
        ga_play_sound("pickup_ammo")
        game_bent.remove_perm(level, bp)
        game_msg.add("Plasma gun recharged")
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
    local core = "Plasma (does not respawn)"
    if( p.has_effect(level, bp) ) then return core
    else return "^xff0000" .. core end
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
