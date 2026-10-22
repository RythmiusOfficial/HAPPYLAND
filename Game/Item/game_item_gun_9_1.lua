--Used by multiple scripts
--(scripts for the laser weapon).
function p.use_common(mode)
    local cur_gun = 9

    --Making sure can use the weapon mode.
    if( not game_wep_modes.has_wep_mode(cur_gun, mode) ) then
        return false
    end

    --Making sure have enough ammo.
    if not game_item_gun_1_1.ammo_check_common(cur_gun, mode) then return false end

    local ent_type = ""
    if mode == 1 then ent_type = "ment_player_proj_nuke_1" end
    if mode == 2 then ent_type = "ment_player_proj_nuke_2" end
    if mode == 3 then ent_type = "ment_player_proj_nuke_3" end

    local viewer_pos = ga_get_viewer_offset()
    local look = ga_get_sys_v("game.player.camera.look")
    local extend_len = 1.0
    local pos = std.vec_add(viewer_pos, std.vec_scale(look,extend_len))

    --Kickback.
    local kf = 1.5 --Kickback factor.
    if( mode == 3 ) then kf = -2.0 end --Kick forward!!
    game_movement.add_impulse(-look.x * kf, -look.y * kf, -look.z * kf)

    local viewer_level = ga_get_viewer_level()
    ga_ment_start(viewer_level, pos, ent_type)

    local speed = game_wep_modes.get_vel(cur_gun, mode)
    local dir = look --Accurate.
    local vel = std.vec_scale(look, speed)
    ga_ment_init_set_v("__vel", vel)

    --Hit damage is 0 (only an explosion does damage,
    --and that code knows how to calculate it).
    ga_ment_init_set_i("damage", 0)

    ga_ment_end()

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
    return game_item_gun_9_1.use_common(mode)
end

function p.get_use_period()
    return game_wep_modes.get_fire_period(9,1)
end
