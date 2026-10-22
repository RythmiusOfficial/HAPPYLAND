function p.__get_mesh() return "bent_ammo_gun_8" end
function p.__get_mesh2() return "gun_8_incr_damage" end

function p.payload(level, bp)
    game_upgrades.emp_damage()
    game_bent.remove_perm(level, bp)
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "EMP Damage"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
