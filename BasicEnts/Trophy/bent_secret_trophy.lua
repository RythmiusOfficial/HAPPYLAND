function p.__get_mesh()
    return "secret_trophy"
end

function p.payload(level, bp)
    local trophy_name = ga_bent_get_param_s(level, bp)
    game_secret_trophy.check_secret_trophy(trophy_name)
    game_trophy.pickup_secret_trophy(trophy_name)
    game_bent.remove_perm(level, bp)
end

function p.__get_touch_dist()
    local dist = ga_get_f("xar.normal_bent_touch_dist")
    return dist
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Secret Trophy"
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
