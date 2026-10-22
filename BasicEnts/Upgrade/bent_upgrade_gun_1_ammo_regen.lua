function p.__get_mesh() return "bent_ammo_gun_1" end
function p.__get_mesh2() return "gun_1_incr_ammo_regen" end

function p.payload(level, bp)
    game_upgrades.plasma_regen()
    game_bent.remove_perm(level, bp)
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Plasma Ammo Regeneration"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
