function p.__get_mesh() return "bent_ammo_gun_7_large" end
function p.__get_mesh2() return "gun_7_incr_fire_speed" end

function p.payload(level, bp)
    ga_srand(ga_block_seed_pos(level, bp))
    game_upgrades.railgun_fire_rate()
    game_bent.remove_perm(level, bp)
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end


function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Railgun Fire Rate"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
