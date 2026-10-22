function p.__get_mesh() return "bent_ammo_gun_0" end
function p.__get_mesh2() return "gun_0_incr_capacity" end

function p.payload(level, bp)
    game_upgrades.dark_hole_max_ammo()
    game_bent.remove_perm(level, bp)
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Dark Hole Max Ammo"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
