function p.__get_mesh()
    return "weapon_mode"
end

function p.payload(level, bp)
    game_wep_modes.give_mode(7,2)
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
    return "Weapon Mod: Rapid Railgun"
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
