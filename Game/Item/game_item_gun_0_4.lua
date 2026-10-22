function p.use()
    local cur_gun = 0
    local mode = 4
    
    --Making sure can use the weapon mode.
    if( not game_wep_modes.has_wep_mode(cur_gun, mode) ) then
        return
    end
    
    --Making sure we have enough ammo.
    local ammo_var = "xar.player.gun" .. tostring(cur_gun) .. ".ammo"
    local ammo = ga_get_i(ammo_var)
    local req_ammo = game_wep_modes.get_ammo_per_fire(cur_gun, mode)
    if ammo < req_ammo then
        --Not enough ammo to use.
        local starting_shoot = game_inv_exec.is_starting_use()
        local complains = game_wep_modes.should_print_not_enough_ammo(cur_gun, mode)
        if starting_shoot and complains then
            --Need to tell the player an error message.
            game_msg.add("You need " .. tostring(req_ammo) .. " dark holes to use this")
            ga_set_b("xar.inv_exec.starting_shoot", false) --So does not keep printing this. --Could do differently.
        end
        return false --Cannot use the weapon.
    end

    --Taking ammo.
    ga_set_i_by_delta(ammo_var, -req_ammo)

    --Setting the end time of the effect.
    local game_time = ga_get_game_time()
    local effect_duration = 30.0
    --
    local end_time_var = "xar.player.gun0.quasar_drive_end"
    local cur_end_time = ga_get_f(end_time_var)
    local new_end_time = -1
    if( game_time < cur_end_time ) then
        --Need to "stack" the effect.
        new_end_time = cur_end_time + effect_duration
    else
        --Need to apply a fresh effect.
        new_end_time = game_time + effect_duration
    end
    ga_set_f(end_time_var, new_end_time)
    --Note: game_inv_regen.lua will cap the duration to 5 minutes (300 seconds).

    --Sound.
    game_play_wep_sound.play(cur_gun, mode)

    return true
end

function p.get_use_period()
    return game_wep_modes.get_fire_period(0,4)
end
