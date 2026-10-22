function p.use()
    local cur_gun = 5
    local mode = 1

    --Making sure can use the weapon mode.
    if( not game_wep_modes.has_wep_mode(cur_gun, mode) ) then
        return false
    end

    if not game_item_gun_1_1.ammo_check_common(cur_gun, mode) then return false end

    local ent_type = "ment_player_proj_homing_1"

    local viewer_pos = ga_get_viewer_offset()
    local look = ga_get_sys_v("game.player.camera.look")
    local extend_len = 1.0
    local pos = std.vec_add(viewer_pos, std.vec_scale(look,extend_len))

    local damage = game_wep_modes.get_curved_damage(cur_gun, mode)

    local viewer_level = ga_get_viewer_level()
    ga_ment_start(viewer_level, pos, ent_type)

    local speed = game_wep_modes.get_vel(cur_gun, mode)
    ga_ment_init_set_f("__homing_speed", speed)
    
    --Not being used.
    local vel = std.vec_scale(look, speed)
    ga_ment_init_set_v("__vel", vel)
    
    ga_ment_init_set_i("damage", damage)
    ga_ment_end()

    --Spending ammo.
    local ammo_var = "xar.player.gun" .. tostring(cur_gun) .. ".ammo"
    local req_ammo = game_wep_modes.get_ammo_per_fire(cur_gun, mode)
    std.set_bydelta_i(ammo_var, -req_ammo)

    game_play_wep_sound.play(cur_gun, mode)

    return true
end

function p.get_use_period()
    return game_wep_modes.get_fire_period(5,1)
end
