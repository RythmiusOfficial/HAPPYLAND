function p.__get_mesh() return "bent_ammo_gun_4_large" end
function p.__get_mesh2() return "gun_4_incr_proj_speed" end

function p.payload(level, bp)
    game_upgrades.rocket_proj_speed()
    game_bent.remove_perm(level, bp)
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Rocket Projectile Speed"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
