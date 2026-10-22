function p.__get_mesh() return "bent_ammo_gun_5_large" end
function p.__get_mesh2() return "gun_5_incr_damage" end

function p.payload(level, bp)
    game_upgrades.homing_damage()
    game_bent.remove_perm(level, bp)
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Homing Damage"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end

