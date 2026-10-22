function p.payload(level, bp)
    local num_sec = ga_bent_get_param_i(level, bp)
    local combo = ga_bent_get_param_s(level, bp)
    ga_set_f("xar.key_time.green", num_sec)
    ga_set_s("xar.key_time.green_combo", combo)
    ga_play_sound("pickup_powerup")
    game_bent.remove_temp(level, bp, 60) --One minute.
end

function p.__get_touch_dist()
    local dist = ga_get_f("xar.normal_bent_touch_dist")
    return dist
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_use_msg(level, bp)
    local num_sec = ga_bent_get_param_i(level, bp)
    local combo = ga_bent_get_param_s(level, bp)
    return tostring(num_sec) .. " Sec Green Key (with combo " .. combo .. ")"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
