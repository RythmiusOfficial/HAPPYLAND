function p.__get_mesh() return "bent_armor_1000p" end
function p.__get_mesh2() return "armor_incr_regen" end

function p.payload(level, bp)
    game_upgrades.armor_regen()
    game_bent.remove_perm(level, bp)
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Armor Regeneration"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
