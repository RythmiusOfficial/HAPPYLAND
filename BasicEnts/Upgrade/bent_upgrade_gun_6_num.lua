function p.__get_mesh() return "bent_ammo_gun_6_large" end
function p.__get_mesh2() return "gun_6_incr_num" end

function p.payload(level, bp)
    ga_srand(ga_block_seed_pos(level, bp))
    game_upgrades.minigun_super()
    game_bent.remove_perm(level, bp)
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Minigun Special Damage Modifier"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end