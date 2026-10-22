function p.payload(level, bp)
    local old_time = ga_get_f("xar.damage_5x_stacking_time")
    local num_sec = ga_bent_get_param_i(level, bp)
    local new_time = old_time + num_sec
    ga_set_f("xar.damage_5x_stacking_time", new_time)
    ga_play_sound("pickup_powerup")
    ga_hud_msg("Your Damage Is Multiplied by 5!", 5.0)
    game_msg.add("Your damage is multiplied by 5!")
    game_bent.remove_temp(level, bp, 60 * 60) --One hour.
end

function p.__get_touch_dist()
    return ga_get_f("xar.normal_bent_touch_dist")
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_use_msg(level, bp)
    local num_sec = ga_bent_get_param_i(level, bp)
    return "5x damage for " .. tostring(num_sec) .. " seconds"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end
