function p.update()
    local game_time = ga_get_game_time()
    local elapsed_time = ga_get_sys_f("game.time.elapsed") --Elapsed "game" time.

    --Safety.
    if( elapsed_time < 0.0 ) then
        elapsed_time = 0.0
    end
    if( elapsed_time > 10.0 ) then
        elapsed_time = 10.0
    end

    --Capping gold at one million (brute force).
    local max_gold = 1000000;
    p.clip_i("xar.player.gold.amount", 0, max_gold)

    --Setting ammo to zero for guns the player cannot use (brute force).
    for wep = 0,9 do
        local can_use = game_can_use.main(wep)
        if not can_use then
            local var = "xar.player.gun" .. tostring(wep) .. ".ammo"
            ga_set_i(var, 0)
        end
    end

    --XP from last second.
    --Maybe make a helper function for this kind of thing.
    local last_xp_update_time = ga_get_f("xar.experience.last_time") --Actual time.
    if game_time < last_xp_update_time - 10.0 then
        --For safety.  (In case go back in time).
        last_xp_update_time = game_time
        ga_set_f("xar.experience.last_time", last_xp_update_time)
    end
    if game_time > last_xp_update_time + 1.0 then
        ga_set_f("xar.experience.last_time", game_time)
        local xp_this_second = ga_get_i("xar.experience.this_second")
        ga_set_i("xar.experience.last_second", xp_this_second)
        ga_set_i("xar.experience.this_second", 0)
    end

    local health_regen_period       = ga_get_f("xar.player.health.regen")
    local health_extra_regen_period = ga_get_f("xar.player.health.extra_regen")
    local shield_regen_period       = health_regen_period * 0.5 --Double speed.
    local armor_regen_period        = ga_get_f("xar.player.armor.regen")

    local shield_max        = ga_get_i("xar.player.shield.max")
    local health_max        = ga_get_i("xar.player.health.max")
    local health_max_double = health_max * 2
    local armor_max         = health_max * 10

    --Shield regen.
    p.regen_i_pump_add(
        shield_regen_period,            --Period to add 1.
        "xar.player.shield.counter",    --What gets pumped (subtracted from).
        "xar.player.shield.amount",     --What we add 1 to.
        elapsed_time)
    p.clip_i("xar.player.shield.amount", 0, shield_max)

    --Health regen.
    if( ga_get_i("xar.player.health.amount") >= health_max ) then
        if( ga_get_i("xar.player.health.amount") <= health_max_double and
            health_extra_regen_period > 0 )
        then
            --Regenerating to 200% health.
            p.regen_i_pump_add(
                health_extra_regen_period,      --Period to add 1.
                "xar.player.health.counter",    --What gets pumped (subtracted from).
                "xar.player.health.amount",     --What we add 1 to.
                elapsed_time)
            --We should and can clip here, because the health
            --was <= health_max_double before the pumping.
            p.clip_i("xar.player.health.amount", 0, health_max_double)
        end
    else
        --Regenerating to 100% health.
        p.regen_i_pump_add(
            health_regen_period,            --Period to add 1.
            "xar.player.health.counter",    --What gets pumped (subtracted from).
            "xar.player.health.amount",     --What we add 1 to.
            elapsed_time)
        --We will NOT clip, for safety.
    end

    --Losing health because too much.
    if ga_get_i("xar.player.health.amount") > health_max_double then
        local health_loss_rate = 1.0 --We lose 1 health per second.
        p.regen_i_pump_subtract(
            health_loss_rate,                     --Period to subtract 1.
            "xar.player.health.too_much_counter", --What gets pumped (subtracted from).
            "xar.player.health.amount",           --What we subtract 1 from.
            elapsed_time)
        p.clip_i_non_neg("xar.player.health.amount") --Probably do not need.
    end

    --Armor regen.
    if( armor_regen_period > 0 ) then
        --The armor can be up to 1000% percent,
        --but it can only REGEN up to 200%.
        local armor_before = ga_get_i("xar.player.armor.amount")
        if( armor_before < health_max_double ) then
            p.regen_i_pump_add(
                armor_regen_period,         --Period to regenerate 1.
                "xar.player.armor.counter", --What gets pumped (subtracted from).
                "xar.player.armor.amount",  --What we add to.
                elapsed_time)
            p.clip_i("xar.player.armor.amount", 0, health_max_double) --Maxing out at 200% armor.
            --Note: Maxing out at armor_max (1000% armor) is too good.
        end
    end

    --Plasma regen.
    p.regen_i_pump_add(
        game_wep_modes.get_ammo_regen_period(1), --Period to regenerate 1.
        "xar.player.gun1.counter",               --What gets pumped (subtracted from).
        "xar.player.gun1.ammo",                  --What we add to.
        elapsed_time)
    local max_ammo = game_wep_modes.get_ammo_max(1)
    p.clip_i("xar.player.gun1.ammo", 0, max_ammo)

    --Making float variables count down.
    p.drain("xar.key_time.yellow",          elapsed_time)
    p.drain("xar.key_time.blue",            elapsed_time)
    p.drain("xar.key_time.green",           elapsed_time)
    p.drain("xar.key_time.universe",        elapsed_time)
    p.drain("xar.key_time.laser_genesis",   elapsed_time)
    p.drain("xar.key_time.dans_house",      elapsed_time)
    p.drain("xar.xp_5x_stacking_time",      elapsed_time)
    p.drain("xar.damage_5x_stacking_time",  elapsed_time)
    p.drain("xar.invun_stacking_time",      elapsed_time)
    p.drain("xar.messages.slot1.ttl",       elapsed_time)
    p.drain("xar.messages.slot2.ttl",       elapsed_time)
    p.drain("xar.messages.slot3.ttl",       elapsed_time)
    p.drain("xar.messages.slot4.ttl",       elapsed_time)
    p.drain("xar.messages.slot5.ttl",       elapsed_time)

    --Maybe clearing the green key combo.
    if( ga_get_f("xar.key_time.green") <= 0.0 ) then
        local var = "xar.key_time.green_combo"
        if ga_exists(var) then
            ga_set_s(var, "")
        end
    end

    --Put somewhere else.
    game_block_blind.process_update()

    --Could put elsewhere.
    p.cap_black_hole_and_quasar_drive_times()
end

-------------------------------------------------------------------------------
--                              Helper functions
-------------------------------------------------------------------------------

function p.drain(var_name, elapsed_time)
    local value = ga_get_f(var_name)
    if value > 0.0 then
        ga_set_f_by_delta(var_name, -elapsed_time)
    end
end

function p.clip_i(var_name, min_value, max_value)
    local value = ga_get_i(var_name)
    if( value < min_value ) then value = min_value end
    if( value > max_value ) then value = max_value end
    ga_set_i(var_name, value)
end

function p.clip_i_non_neg(var_name)
    local value = ga_get_i(var_name)
    if( value >= 0 ) then return end
    ga_set_i(var_name, 0.0)
end

function p.clip_f_non_neg(var_name)
    local value = ga_get_f(var_name)
    if( value >= 0 ) then return end
    ga_set_f(var_name, 0.0)
end

function p.regen_i_pump_add(
    regen_period,
    time_accum_var,
    total_var,
    elapsed_time)
--
    p.regen_i_pump_helper(
        regen_period,
        time_accum_var,
        total_var,
        elapsed_time,
        1) --Adding 1 each pump.
end

function p.regen_i_pump_subtract(
    regen_period,
    time_accum_var,
    total_var,
    elapsed_time)
--
    p.regen_i_pump_helper(
        regen_period,
        time_accum_var,
        total_var,
        elapsed_time,
        -1) --Subtracting 1 each pump.
end

--Regenerating a variable at a certain rate.
--We increase the counter by total_var.
--If the time_accum is above the regen_period,
--then we decrease the time_accum by regen_period and
--increase the total by the integer delta.
function p.regen_i_pump_helper(
    regen_period,
    time_accum_var,
    total_var,
    elapsed_time,
    delta)
--
    if( regen_period <= 0 ) then
        ga_print("*** Warning: regen_period is <= 0 in game_inv_regen.regen_i_pump_helper")
        ga_print("             regen_period = " .. tostring(regen_period))
        ga_print("             time_accum_var = " .. time_accum_var)
        ga_print("             total_var = " .. total_var)
        return
    end
    p.clip_f_non_neg(time_accum_var) --To be safe.
    ga_set_f_by_delta(time_accum_var, elapsed_time) --Increasing accum.
    local num_tries = 100
    while ga_get_f(time_accum_var) >= regen_period do
        ga_set_i_by_delta(total_var, delta) --Adding delta to the total.
        ga_set_f_by_delta(time_accum_var, -regen_period)
        num_tries = num_tries - 1
        if( num_tries <= 0 ) then
            ga_print("*** Warning: too many tries in game_inv_regen.regen_i_pump_helper")
            return
        end
    end
end

function p.cap_black_hole_and_quasar_drive_times()
    local max_duration = 300 --5 minutes.
    local game_time = ga_get_game_time()

    local var = "xar.player.gun0.black_hole_drive_end"
    local end_time = ga_get_f(var)
    if( end_time > game_time + max_duration ) then
        ga_set_f(var, game_time + max_duration)
    end

    local var = "xar.player.gun0.quasar_drive_end"
    local end_time = ga_get_f(var)
    if( end_time > game_time + max_duration ) then
        ga_set_f(var, game_time + max_duration)
    end
end
