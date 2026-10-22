function p.use_start()
    if( ga_get_i("xar.player.gun0.charge") > 0 ) then return end
    local fire_period = p.get_use_period()
    local last_fire_time = ga_get_f("xar.inv_exec.last_fire_time")
    local game_time = ga_get_sys_f("game.time.total")
    if( game_time - last_fire_time <= fire_period ) then
        ga_set_b("xar.inv_exec.starting_shoot", false)
        ga_set_i("xar.player.gun0.charge", 0)
        return
    end
    --
    local ammo = ga_get_i("xar.player.gun0.ammo")
    if( ammo > 0 ) then
        ammo = ammo - 1
        ga_set_i("xar.player.gun0.ammo", ammo)
        ga_set_f("xar.player.gun0.start_shoot_time", game_time)
        ga_set_f("xar.inv_exec.last_fire_time", game_time)
        ga_set_i("xar.player.gun0.charge", 1)
    end
end

--Could add logic to the p.use function so that
--when you hold down primary fire,
--it will wait then start charging up.
--Right now, if you hold down primary fire too early,
--it will NOT start charging.
function p.use()
    --Nothing to do.
end

function p.use_end()
    --Adding this Jan 2022.
    local charge = ga_get_i("xar.player.gun0.charge")
    if( charge == 0 ) then
        return
    end
    ga_set_i("xar.player.gun0.charge", 0)

    --Actually firing.
    local game_time = ga_get_game_time()
    ga_set_f("xar.inv_exec.last_fire_time", game_time)
    ga_print("  setting last fire time to " .. game_time)
    --
    if( charge > 1 ) then
        game_play_wep_sound.play_0_1_loud()
    else
        game_play_wep_sound.play(0,1)
    end
    --
    local damage_natural = game_wep_modes.get_curved_damage(0,1)
    local damage_mod = p.dark_hole_damage_factor(charge)
    local damage_uncurved = damage_natural * damage_mod
    local damage_curved = game_difficulty_curve.curve_player_damage(damage_uncurved) * 10

    --
    --The projectile.
    local viewer_pos = ga_get_viewer_offset()
    local viewer_level = ga_get_viewer_level()
    local look = ga_get_sys_v("game.player.camera.look")
    local extend_len = 1.0
    local pos = std.vec_add(viewer_pos, std.vec_scale(look,extend_len))
    --Kickback.
    -- kf = -0.10 --Kickback factor.
    local kf = 1.0 * (charge-1) --Kickback factor.
    game_movement.add_impulse(-look.x * kf, -look.y * kf, -look.z * kf)
    --
    local speed = game_wep_modes.get_vel(0,1)
    --
    ga_ment_start(viewer_level, pos, "ment_player_proj_dark_hole")
    local vel = std.vec_scale(look, speed)
    ga_ment_init_set_v("__vel", vel)
    ga_ment_init_set_i("damage", damage_curved)
    ga_ment_end()

    ga_set_i("xar.player.gun0.charge", 0)
end

--Helper function.
--Canceling the dark hole charge.
function p.use_cancel()
    ga_set_i("xar.player.gun0.charge", 0)
end

function p.get_use_period()
    return game_wep_modes.get_fire_period(0,1)
end

function p.get_is_rapid_fire()
    return false --Added July 13, 2026.
end

--Called if this item is one of the 20 items equipped.
function p.update()
    local safety_str = game_inv_exec.get_cur_starting_shoot_item()
    if( safety_str ~= "game_item_gun_0_1" ) then
        --We are not "holding the shoot button" for this item.
        p.use_cancel()
        return
    end

    local cur_wep = ga_get_i("xar.inv_exec.cur_wep")
    local primary = ga_get_b("xar.inv_exec.primary")

    if( cur_wep ~= 0 or not primary ) then
        --THIS NEEDS TO BE MORE COMPLEX!!!
        --RESET THE CHARGE IF THE CUR_WEP IS NOT CORRECT
        return
    end

    if( ga_get_i("xar.player.health.amount") <= 0 ) then return end
    if( ga_get_i("xar.player.gun0.charge") == 0 ) then
        --Trying to get the first charge.
        p.use_start()
        return
    end
    local game_time = ga_get_game_time()
    local start_shoot_time = ga_get_f("xar.player.gun0.start_shoot_time")
    local charge = ga_get_i("xar.player.gun0.charge")
    local ammo = ga_get_i("xar.player.gun0.ammo")
    --
    if( charge >= 13 ) then
        ga_print("Killing player because too many dark hole changes")
        ga_kill_player()
        return
    end
    --
    if( game_time > start_shoot_time + charge and
        ammo > 0 )
    then
        charge = charge + 1
        ammo = ammo -1
        -- ga_print("  LOSING AN AMMO!!!")
        raw = true
        game_top2.damage_player(raw, charge * 25)
        ga_set_i("xar.player.gun0.charge", charge)
        ga_set_i("xar.player.gun0.ammo", ammo)
        game_play_wep_sound.play_0_charge()
    end
end

--Helper function.
function p.dark_hole_damage_factor(charge)
    local damage_mod = 0
    if( charge >= 1 ) then damage_mod = damage_mod + 1 end
    if( charge >= 2 ) then damage_mod = damage_mod + 2 end
    if( charge >= 3 ) then damage_mod = damage_mod + 5 end
    if( charge >= 4 ) then damage_mod = damage_mod + 10 end
    if( charge >= 5 ) then damage_mod = damage_mod + 15 end
    if( charge >= 6 ) then damage_mod = damage_mod + 20 end
    if( charge >= 7 ) then damage_mod = damage_mod + 25 end
    if( charge >= 8 ) then damage_mod = damage_mod + 30 end
    if( charge >= 9 ) then damage_mod = damage_mod + 35 end
    if( charge >= 10 ) then damage_mod = damage_mod + 40 end
    if( charge >= 11 ) then damage_mod = damage_mod + 45 end
    if( charge >= 12 ) then damage_mod = damage_mod + 50 end
    return damage_mod
end
