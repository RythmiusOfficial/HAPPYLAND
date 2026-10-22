--Used by multiple scripts
--(scripts for the railgun weapon).
function p.use_common(mode)
    local cur_gun = 8

    --Making sure can use the weapon mode.
    if( not game_wep_modes.has_wep_mode(cur_gun, mode) ) then
        return false
    end

    if not game_item_gun_1_1.ammo_check_common(cur_gun, mode) then return false end

    --Making sure have enough ammo.
    game_item_gun_1_1.ammo_check_common(cur_gun, mode)

    local radius = game_wep_modes.get_radius(cur_gun,mode)

    --Decoration.
    local viewer_pos = ga_get_viewer_offset()
    local lp = viewer_pos
    local viewer_level = ga_get_viewer_level()
    local ls = 1.0 --Level scale factor
    local col = std.vec(0.0, 0.0, 0.0) --Color
    if( mode == 1 ) then col = std.vec(0.0, 1.0, 0.0) end
    if( mode == 2 ) then col = std.vec(0.0, 1.0, 0.5) end
    --
    local args = {}
    args.level = viewer_level
    args.pos = lp
    args.ttl_min = 10.0*ls
    args.ttl_max = 20.0*ls
    args.size_min = 0.2
    args.size_max = 1.0
    args.color = col
    args.fade_time_min = 10.0
    args.fade_time_max = 10.0
    args.speed_min = 0.5
    args.speed_max = 0.5
    args.tex = "particle_2"
    args.radius_min = 4.0
    args.radius_max = 4.0
    args.num = 200
    args.use_min_dist = false
    ga_particle_explosion(args)
    
    local stun_len = game_wep_modes.get_freeze_length(cur_gun,mode)
    local damage_raw = game_wep_modes.get_curved_damage(cur_gun, mode)
    local allow_powerups = true
    local damage = game_damage.calc_damage_from_player(damage_raw, allow_powerups)

    game_ment_emp.detonate_emp(
        viewer_level, viewer_pos, radius, stun_len, damage)

    local game_time = ga_get_sys_f("game.time.total")

    ga_set_f("xar.emp_end_time", game_time + stun_len)

    if( mode == 2 ) then
        game_top2.damage_player(true, 100) --Raw damage.
    end

    --Spending ammo.
    local ammo_var = "xar.player.gun" .. tostring(cur_gun) .. ".ammo"
    local req_ammo = game_wep_modes.get_ammo_per_fire(cur_gun, mode)
    std.set_bydelta_i(ammo_var, -req_ammo)

    --Sound.
    local last_sound_time = ga_get_f("xar.player.gun8.last_sound_time")
    local sound_period = 5.0
    if( game_time > last_sound_time + sound_period ) then
        ga_set_f("xar.player.gun8.last_sound_time", game_time)
        game_play_wep_sound.play(cur_gun, mode)
    end

    return true
end

function p.use()
    local mode = 1
    return game_item_gun_8_1.use_common(mode)
end

function p.get_use_period()
    return game_wep_modes.get_fire_period(8,1)
end
