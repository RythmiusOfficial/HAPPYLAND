function p.__get_mesh() return "bent_ammo_gun_8" end
function p.__get_mesh2() return "gun_ammo_once" end

function p.has_effect(level, bp)
    local max_value = game_wep_modes.get_ammo_max(8)
    local old_value = ga_get_i("xar.player.gun8.ammo")
    return ( old_value < max_value );
end

function p.payload(level, bp)
    if not game_can_use.main(8) then return end    
    local max_value = game_wep_modes.get_ammo_max(8)
    local old_value = ga_get_i("xar.player.gun8.ammo")
    local new_value = old_value + 1
    if( new_value > max_value ) then new_value = max_value end
    if ( new_value > old_value ) then
        ga_set_i("xar.player.gun8.ammo", new_value)
        ga_play_sound("pickup_ammo")
        game_bent.remove_perm(level, bp)
        game_msg.add("You got an EMP")
    end
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    if not game_can_use.main(8) then
        return bent_ammo_gun_2_small.cannot_use_msg()
    end
    local core = "EMP (does not respawn)"
    if( p.has_effect(level, bp) ) then return core
    else return "^xff0000" .. core end
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
