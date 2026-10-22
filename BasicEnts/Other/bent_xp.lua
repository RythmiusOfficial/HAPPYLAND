function p.get_num(level, bp)
    return ga_bent_get_param_i(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    local num = p.get_num(level, bp)
    return "Get " .. tostring(num) .. " Experience Points"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end

function p.payload(level, bp)
    local num = p.get_num(level, bp)
    local allow_powerup = false
    game_xp.add(num, allow_powerup)
    game_bent.remove_perm(level, bp)
    ga_play_sound("pickup_upgrade")
end
