function p.__get_mesh() return "shield_large" end --Antiquated name.
function p.__get_mesh2() return "shield_incr_ballance" end --Antiquated name.

function p.payload(level, bp)
    ga_srand(ga_block_seed_pos(level, bp))
    local i = ga_randi(0,1)
    if (i == 0) then bent_upgrade_health_cap.get(level, bp) end
    if (i == 1) then bent_upgrade_health_regen.get(level, bp) end
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Random Health Upgrade"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end
