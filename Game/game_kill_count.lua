function p.is_trying_to_be_pacifist()
    return ga_get_b("xar.difficulty.trying_to_be_pacifist")
end

function p.get_max_pacifist_kill_count()
    return 99
end

function p.is_pacifist()
    local kill_count = p.get_kill_count()
    if( kill_count < 0 ) then return false end --Uh oh!
    local max = p.get_max_pacifist_kill_count()
    return (kill_count <= max)
end

function p.get_kill_count_var()
    return "xar.stats.kill_count"
end

function p.get_kill_count()
    local var = p.get_kill_count_var()
    if not ga_exists(var) then return -1 end
    return ga_get_i(var)
end

--Should be called when the player kills a monster,
--to register the statistic.
function p.add_frag()
    local var = p.get_kill_count_var()
    if not ga_exists(var) then return end --Uh oh!
    --
    local kill_count = ga_get_i(var)
    kill_count = kill_count + 1
    ga_set_i(var, kill_count)
end
