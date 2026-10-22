--Adding to the player "out dps" counter.
function p.add(damage)    
    local damage_int = math.floor(damage)
    local old_in_dps = ga_get_sys_i("stats.out_dps_count")
    ga_set_sys_i("stats.out_dps_count", old_in_dps + damage_int)
end
