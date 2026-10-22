function p.payload(level, bp)
    local max_value = ga_get_i("xar.player.gold.max")
    local old_value = ga_get_i("xar.player.gold.amount")
    local new_value = old_value + 1000
    if( new_value > max_value ) then new_value = max_value end
    if ( new_value > old_value ) then
        ga_set_i("xar.player.gold.amount", new_value)
        ga_play_sound("pickup_gold_large")
        game_bent.remove_temp(level, bp, 60 * 60)
        game_msg.add("You got " .. tostring(new_value - old_value) .. " gold")
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
    return "1000 Gold"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
