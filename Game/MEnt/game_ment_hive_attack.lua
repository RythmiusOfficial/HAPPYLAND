function p.get_frac()
    local meter = p.get_meter() --Negative.
    local frac = (5.0 + meter) / 5.0
    if( frac < 0.0 ) then frac = 0.0 end
    if( frac > 1.0 ) then frac = 1.0 end
    return frac
end

function p.get_meter()
    return ga_get_f("xar.player.hive_attack.meter")
end

--If this amount of time passes since an attack,
--the attack meter is rest.
function p.get_reset_period()
    return 3.0
end

--Helper function.
function p.reset_meter()
    ga_set_f("xar.player.hive_attack.meter", 0.0)
end

function p.reg_attack()
    local cur_time = ga_get_game_time()
    local last_attack = ga_get_f("xar.player.hive_attack.last_time")
    local diff = cur_time - last_attack
    if( diff <= p.get_reset_period() ) then
        --Advancing the meter.
        --Making the meter more neagtive.
        local old_meter = ga_get_f("xar.player.hive_attack.meter")
        local new_meter = old_meter - diff
        ga_set_f("xar.player.hive_attack.meter", new_meter)
    else
        --Need to reset the attack meter.
        p.reset_meter()
    end
    --Updating the last attack time.
    ga_set_f("xar.player.hive_attack.last_time", cur_time)
end

function p.update()
    local cur_time = ga_get_game_time()
    local last_attack = ga_get_f("xar.player.hive_attack.last_time")
    local diff = cur_time - last_attack
    if( diff > p.get_reset_period() ) then
        p.reset_meter()
    end
end
