--Used by multiple scripts
--(scripts for the laser weapon).
function p.use_common(mode)
    ga_print("game_item_gun_3_1.use_common: mode = " .. tostring(mode))

    local cur_gun = 3

    --Making sure can use the weapon mode.
    if( not game_wep_modes.has_wep_mode(cur_gun, mode) ) then
        return false
    end

    --Making sure have enough ammo.
    if not game_item_gun_1_1.ammo_check_common(cur_gun, mode) then return false end

    -- if (not primary) and (not starting_shoot) then return false end
    local ent_type = ""
    if mode == 1 then ent_type = "ment_player_proj_laser_1" end
    if mode == 2 then ent_type = "ment_player_proj_laser_2" end
    if mode == 3 then ent_type = "ment_player_proj_laser_3" end
    if mode == 4 then ent_type = "ment_player_proj_laser_4" end

    local viewer_pos = ga_get_viewer_offset()
    local look = ga_get_sys_v("game.player.camera.look")
    local extend_len = 1.0
    local pos = std.vec_add(viewer_pos, std.vec_scale(look,extend_len))

    local viewer_level = ga_get_viewer_level()
    ga_ment_start(viewer_level, pos, ent_type)

    local speed = game_wep_modes.get_vel(cur_gun, mode)
    local dir = look --Accurate shot.
    local vel = std.vec_scale(dir, speed)
    ga_ment_init_set_v("__vel", vel)
    
    local damage = game_wep_modes.get_curved_damage(cur_gun, mode)
    ga_ment_init_set_i("damage", damage)

    ga_ment_end()

    if mode == 4 then
        game_top2.damage_player(true, 50) --Raw damage.
    end

    -- --Spending ammo.
    local ammo_var = "xar.player.gun" .. tostring(cur_gun) .. ".ammo"
    local req_ammo = game_wep_modes.get_ammo_per_fire(cur_gun, mode)
    std.set_bydelta_i(ammo_var, -req_ammo)

    --Sound.
    game_play_wep_sound.play(cur_gun, mode)

    return true
end

function p.use()
    local mode = 1
    return game_item_gun_3_1.use_common(mode)
end

function p.get_use_period()
    return game_wep_modes.get_fire_period(3,1)
end
