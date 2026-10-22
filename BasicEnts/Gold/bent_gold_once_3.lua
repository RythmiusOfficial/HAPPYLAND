function p.__get_mesh() return "bent_gold_3" end
function p.__get_mesh2() return "gun_ammo_once" end

function p.payload(level, bp)
    max_value = ga_get_i("xar.player.gold.max")
    old_value = ga_get_i("xar.player.gold.amount")
    new_value = old_value + 3
    if( new_value > max_value ) then new_value = max_value end
    if ( new_value > old_value ) then
        ga_set_i("xar.player.gold.amount", new_value)
        ga_play_sound("pickup_gold_small")
        game_bent.remove_perm(level, bp)
        game_msg.add("You got " .. tostring(new_value - old_value) .. " gold")
    end
end

function p.__get_touch_dist()
    local dist = ga_get_f("xar.normal_bent_touch_dist")
    return dist
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_use_msg(level, bp)
    return "3 Gold (does not respawn)"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
