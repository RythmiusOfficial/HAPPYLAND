function p.use()
    local cur_gun = 0
    local mode = 2
    
    --Making sure can use the weapon mode.
    if( not game_wep_modes.has_wep_mode(cur_gun, mode) ) then
        return
    end
    
    --Damaging the player but adding one ammo.
    local ammo_var =
        "xar.player.gun" .. tostring(cur_gun) .. ".ammo"
    local ammo = ga_get_i(ammo_var)
    local ammo_max = game_wep_modes.get_ammo_max(0)
    local can_use = game_can_use.main(0)
    if can_use and ammo < ammo_max then
        game_top2.damage_player(true, 100)
        ga_set_i(ammo_var, ammo+1)
    else
        return false
    end

    game_play_wep_sound.play(cur_gun, mode)

    return true
end

function p.get_use_period()
    return game_wep_modes.get_fire_period(0,2)
end
