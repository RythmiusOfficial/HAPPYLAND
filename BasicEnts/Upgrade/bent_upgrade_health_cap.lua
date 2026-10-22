function p.__get_mesh() return "bent_health_100p" end
function p.__get_mesh2() return "health_incr" end

function p.get(level, bp)
    game_upgrades.health_max()
    game_bent.remove_perm(level, bp)
end

function p.payload(level, bp)
    p.get(level, bp)
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Max Health Upgrade"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
