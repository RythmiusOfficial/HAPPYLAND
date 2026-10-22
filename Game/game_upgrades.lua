function p.armor_regen()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.armor.regen_level", delta)
    ga_hud_msg("Armor Regeneration Increased!!!", 5.0)
    game_msg.add("Armor regeneration increased!!!")
    ga_play_sound("pickup_upgrade")
end

function p.spice()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.health.regen_level", delta)
    std.set_bydelta_i("xar.player.health.extra_regen_level", 1)
    ga_hud_msg(">100% Health Regeneration Increased!!", 5.0)
    game_msg.add(">100% health regeneration increased!!")
    ga_play_sound("pickup_upgrade")
end

function p.health_max()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.health.level", delta)
    ga_hud_msg("Max Health Increased!", 5.0)
    game_msg.add("Max health increased!")
    ga_play_sound("pickup_upgrade")
end

function p.health_regen()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.health.regen_level", delta)
    ga_hud_msg("Health Regeneration Increased!", 5.0)
    game_msg.add("Health regeneration increased!")
    ga_play_sound("pickup_upgrade")
end

function p.plasma_regen()
    game_maybe_ammo.plasma()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun1.ammo_regen_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Plasma Regeneration Increased!", 5.0)
    game_msg.add("Plasma regeneration increased!")
end

function p.plasma_max_ammo()
    game_maybe_ammo.plasma()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun1.ammo_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Plasma Max Ammo Increased!", 5.0)
    game_msg.add("Plasma max ammo increased!")
end

function p.plasma_damage()
    game_maybe_ammo.plasma()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun1.damage_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Plasma Damage Increased!", 5.0)
    game_msg.add("Plasma damage increased!")
end

function p.plasma_fire_rate()
    game_maybe_ammo.plasma()
    local lev = ga_get_i("xar.player.gun1.fire_period_level")
    local max_lev = game_wep_modes.get_fire_period_level_max(1)
    if (lev >= max_lev) then
        local i = ga_randi(0,2)
        if (i == 0) then p.plasma_max_ammo() end
        if (i == 1) then p.plasma_regen() end
        if (i == 2) then p.plasma_damage() end
    else
        local delta = 1
        if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
        std.set_bydelta_i("xar.player.gun1.fire_period_level", delta)
        ga_play_sound("fanfare")
        ga_hud_msg("Plasma Fire Rate Increased!", 5.0)
        game_msg.add("Plasma fire rate increased!")
    end
end

function p.plasma_proj_speed()
    game_maybe_ammo.plasma()
    local lev = ga_get_i("xar.player.gun1.speed_level")
    local max_lev = game_wep_modes.get_vel_level_max(1)
    if (lev >= max_lev) then
        local i = ga_randi(0,2)
        if (i == 0) then p.plasma_max_ammo() end
        if (i == 1) then p.plasma_regen() end
        if (i == 2) then p.plasma_damage() end
    else
        local delta = 1
        if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
        std.set_bydelta_i("xar.player.gun1.speed_level", delta)
        ga_play_sound("pickup_upgrade")
        ga_hud_msg("Plasma Projectile Speed Increased!", 5.0)
        game_msg.add("Plasma projectile speed Increased!")
    end
end

function p.cannon_max_ammo()
    game_maybe_ammo.cannon()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun2.ammo_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Cannon Max Ammo Increased!", 5.0)
    game_msg.add("Cannon max ammo increased!")
end

function p.cannon_fire_rate()
    game_maybe_ammo.cannon()
    local lev = ga_get_i("xar.player.gun2.fire_period_level")
    local max_lev = game_wep_modes.get_fire_period_level_max(2)
    if (lev >= max_lev) then
        local i = ga_randi(0,1)
        if (i == 0) then p.cannon_max_ammo() end
        if (i == 1) then p.cannon_damage() end
    else
        local delta = 1
        if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
        std.set_bydelta_i("xar.player.gun2.fire_period_level", delta)
        ga_play_sound("pickup_upgrade")
        ga_hud_msg("Cannon Fire Rate Increased!", 5.0)
        game_msg.add("Cannon fire rate increased!")
    end
end

function p.cannon_damage()
    game_maybe_ammo.cannon()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun2.damage_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Cannon Damage Increased!", 5.0)
    game_msg.add("Cannon damage increased!")
end

function p.cannon_proj_speed()
    game_maybe_ammo.cannon()
    local lev = ga_get_i("xar.player.gun2.speed_level")
    local max_lev = game_wep_modes.get_vel_level_max(2)
    if (lev >= max_lev) then
        local i = ga_randi(0,1)
        if (i == 0) then p.cannon_max_ammo() end
        if (i == 1) then p.cannon_damage() end
    else
        local delta = 1
        if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
        std.set_bydelta_i("xar.player.gun2.speed_level", delta)
        ga_play_sound("pickup_upgrade")
        ga_hud_msg("Cannon Projectile Speed Increased!", 5.0)
        game_msg.add("Cannon projectile speed increased!")
    end
end

function p.cannon_num()
    game_maybe_ammo.cannon()
    -- upgrade_gun_2_ammo_cap.maybe_ammo()
    local lev = ga_get_i("xar.player.gun2.num_level")
    local max_lev = game_wep_modes.get_num_level_max(2)
    if (lev >= max_lev) then
        local i = ga_randi(0,1)
        if (i == 0) then p.cannon_max_ammo() end
        if (i == 1) then p.cannon_damage() end
    else
        local delta = 1
        if ga_get_b("xar.difficulty.easy_2") then delta = 2 end

        std.set_bydelta_i("xar.player.gun2.num_level", delta)
        ga_play_sound("pickup_upgrade")
        ga_hud_msg("Cannon Num Shots Increased!", 5.0)
        game_msg.add("Cannon num shots increased!")
    end
end

function p.laser_max_ammo()
    game_maybe_ammo.laser()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun3.ammo_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Laser Max Ammo Increased!", 5.0)
    game_msg.add("Laser max ammo increased!")
end

function p.laser_damage()
    game_maybe_ammo.laser()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun3.damage_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Laser Damage Increased!", 5.0)
    game_msg.add("Laser damage increased!")
end

function p.laser_freeze_time()
    game_maybe_ammo.laser()
    local lev = ga_get_i("xar.player.gun3.freeze_time_level")
    local max_lev = game_wep_modes.get_freeze_length_level_max(3)
    if (lev >= max_lev) then
        local i = ga_randi(1,3)
        if i == 1 then p.laser_max_ammo() --Good.
        else p.laser_damage() end
    else
        local delta = 1
        if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
        std.set_bydelta_i("xar.player.gun3.freeze_time_level", delta)
        ga_play_sound("pickup_upgrade")
        ga_hud_msg("Laser Freeze Time Increased!", 5.0)
        game_msg.add("Laser Freeze Time increased!")
    end
end

function p.laser_super()
    game_maybe_ammo.laser()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun3.num_level", delta)
    ga_play_sound("fanfare")
    ga_hud_msg("Laser Damage Factor Increased!", 5.0)
    game_msg.add("Laser Damage Factor increased!")
end

function p.rocket_max_ammo()
    game_maybe_ammo.rocket()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun4.ammo_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Rocket Max Ammo Increased!", 5.0)
    game_msg.add("Rocket max ammo increased!")
end

function p.rocket_damage()
    game_maybe_ammo.rocket()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun4.damage_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Rocket Damage Increased!", 5.0)
    game_msg.add("Rocket damage increased!")
end

function p.rocket_fire_rate()
    game_maybe_ammo.rocket()
    local lev = ga_get_i("xar.player.gun4.fire_period_level")
    local max_lev = game_wep_modes.get_fire_period_level_max(4)
    if (lev >= max_lev) then
        local i = ga_randi(0,2)
        if (i == 0) then p.rocket_max_ammo() end
        if (i == 1) then p.rocket_damage() end
        if (i == 2) then p.rocket_proj_speed() end
    else
        local delta = 1
        if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
        std.set_bydelta_i("xar.player.gun4.fire_period_level", delta)
        ga_play_sound("fanfare")
        ga_hud_msg("Rocket Fire Rate Increased!", 5.0)
        game_msg.add("Rocket fire rate increased!")
    end
end

function p.rocket_proj_speed()
    game_maybe_ammo.rocket()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun4.speed_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Rocket Projectile Speed Increased!", 5.0)
    game_msg.add("Rocket projectile speed increased!")
end

function p.rocket_radius()
    game_maybe_ammo.rocket()
    local lev = ga_get_i("xar.player.gun4.radius_level")
    local max_lev = game_wep_modes.get_radius_level_max(4)
    if (lev >= max_lev) then
        local i = ga_randi(0,2)
        if (i == 0) then p.rocket_max_ammo() end
        if (i == 1) then p.rocket_damage() end
        if (i == 2) then p.rocket_proj_speed() end
    else
        local delta = 1
        if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
        std.set_bydelta_i("xar.player.gun4.radius_level", delta)
        ga_play_sound("pickup_upgrade")
        ga_hud_msg("Rocket Radius Increased!", 5.0)
        game_msg.add("Rocket explosion radius increased!")
    end
end

function p.homing_max_ammo()
    game_maybe_ammo.homing()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun5.ammo_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Homing Max Ammo Increased!", 5.0)
    game_msg.add("Homing max ammo increased!")
end

function p.homing_damage()
    game_maybe_ammo.homing()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun5.damage_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Homing Damage Increased!", 5.0)
    game_msg.add("Homing damage increased!")
end

function p.homing_fire_rate()
    game_maybe_ammo.homing()
    local lev = ga_get_i("xar.player.gun5.fire_period_level")
    local max_lev = game_wep_modes.get_fire_period_level_max(5)
    if (lev >= max_lev) then
        local i = ga_randi(0,1)
        if (i == 0) then p.homing_max_ammo() end
        if (i == 1) then p.homing_damage() end
    else
        local delta = 1
        if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
        std.set_bydelta_i("xar.player.gun5.fire_period_level", delta)
        ga_play_sound("pickup_upgrade")
        ga_hud_msg("Homing Fire Rate Increased!", 5.0)
        game_msg.add("Homing fire rate increased!")
    end
end

function p.homing_proj_speed()
    game_maybe_ammo.homing()
    local lev = ga_get_i("xar.player.gun5.fire_period_level")
    local max_lev = game_wep_modes.get_vel_level_max(5)
    if (lev >= max_lev) then
        local i = ga_randi(0,1)
        if (i == 0) then p.homing_max_ammo() end
        if (i == 1) then p.homing_damage() end
    else
        local delta = 1
        if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
        std.set_bydelta_i("xar.player.gun5.speed_level", delta)
        ga_play_sound("pickup_upgrade")
        ga_hud_msg("Homing Projectile Speed Increased!", 5.0)
        game_msg.add("Homing projectile speed increased!")
    end
end

function p.minigun_max_ammo()
    game_maybe_ammo.minigun()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun6.ammo_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Minigun Max Ammo Increased!", 5.0)
    game_msg.add("Minigun max ammo increased!")
end

function p.minigun_damage()
    game_maybe_ammo.minigun()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun6.damage_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Minigun Damage Increased!", 5.0)
    game_msg.add("Minigun damage increased!")
end

function p.minigun_fire_rate()
    game_maybe_ammo.minigun()
    local lev = ga_get_i("xar.player.gun6.fire_period_level")
    local max_lev = game_wep_modes.get_fire_period_level_max(6)
    if (lev >= max_lev) then
        local i = ga_randi(0,1)
        if (i == 0) then p.minigun_max_ammo() end
        if (i == 1) then p.minigun_damage() end
    else
        local delta = 1
        if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
        std.set_bydelta_i("xar.player.gun6.fire_period_level", delta)
        ga_play_sound("pickup_upgrade")
        ga_hud_msg("Minigun Fire Rate Increased!", 5.0)
        game_msg.add("Minigun fire rate increased!")
    end
end

function p.minigun_proj_speed()
    game_maybe_ammo.minigun()
    local lev = ga_get_i("xar.player.gun6.speed_level")
    local max_lev = game_wep_modes.get_vel_level_max(6)
    if (lev >= max_lev) then
        p.minigun_damage()
        local i = ga_randi(0,1)
        -- if (i == 0) then p.minigun_max_ammo() end
        -- if (i == 1) then p.minigun_damage() end
    else
        game_maybe_ammo.minigun()
        local delta = 1
        if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
        std.set_bydelta_i("xar.player.gun6.speed_level", delta)
        ga_play_sound("pickup_upgrade")
        ga_hud_msg("Minigun Projectile Speed Increased!", 5.0)
        game_msg.add("Minigun projectile speed increased!")
    end
end

--Should there even be a max level?
function p.minigun_super()
    game_maybe_ammo.minigun()
    local lev = ga_get_i("xar.player.gun6.num_level")
    local max_lev = game_wep_modes.get_special_num_level_max(6)
    if (lev >= max_lev) then
        local i = ga_randi(0,1)
        if (i == 0) then p.minigun_max_ammo() end
        if (i == 1) then p.minigun_damage() end
    else
        game_maybe_ammo.minigun()
        local delta = 1
        if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
        std.set_bydelta_i("xar.player.gun6.num_level", delta)
        ga_play_sound("fanfare")
        ga_hud_msg("Minigun Damage Factor Increased!!!", 5.0)
        game_msg.add("Minigun Damage Factor increased!!!")
    end
end

function p.railgun_max_ammo()
    game_maybe_ammo.railgun()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun7.ammo_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Railgun Max Ammo Increased!", 5.0)
    game_msg.add("Railgun max ammo increased!")
end

function p.railgun_damage()
    game_maybe_ammo.railgun()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun7.damage_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Railgun Damage Increased!", 5.0)
    game_msg.add("Railgun damage increased!")
end

function p.railgun_fire_rate()
    game_maybe_ammo.railgun()
    local lev = ga_get_i("xar.player.gun7.fire_period_level")
    local max_lev = game_wep_modes.get_fire_period_level_max(7)
    if (lev >= max_lev) then
        local i = ga_randi(0,2)
        if i == 1 then p.railgun_max_ammo()
        else p.railgun_damage() end
    else
        local delta = 1
        if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
        std.set_bydelta_i("xar.player.gun7.fire_period_level", delta)
        ga_play_sound("pickup_upgrade")
        ga_hud_msg("Railgun Fire Rate Increased!", 5.0)
        game_msg.add("Railgun fire rate increased!")
    end
end

function p.emp_max_ammo()
    game_maybe_ammo.emp()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun8.ammo_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("EMP Max Ammo Increased!", 5.0)
    game_msg.add("EMP max ammo increased!")
end

function p.emp_damage()
    game_maybe_ammo.emp()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun8.damage_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("EMP Damage Increased!", 5.0)
    game_msg.add("EMP damage increased!")
end

function p.emp_radius()
    game_maybe_ammo.emp()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun8.radius_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("EMP Radius Increased!", 5.0)
    game_msg.add("EMP radius increased!")
end

function p.emp_freeze_time()
    game_maybe_ammo.emp()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun8.freeze_time_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("EMP Freeze Time Increased!", 5.0)
    game_msg.add("EMP freeze time increased!")
end

function p.nuke_max_ammo()
    game_maybe_ammo.nuke()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun9.ammo_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Nuke Max Ammo Increased!", 5.0)
    game_msg.add("Nuke max ammo increased!")
end

function p.nuke_damage()
    game_maybe_ammo.nuke()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun9.damage_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Nuke Damage Increased!", 5.0)
    game_msg.add("Nuke damage increased!")
end

function p.nuke_proj_speed()
    game_maybe_ammo.nuke()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun9.speed_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Nuke Projectile Speed Increased!", 5.0)
    game_msg.add("Nuke projectile speed increased!")
end

function p.nuke_radius()
    game_maybe_ammo.nuke()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun9.radius_level", delta)
    ga_play_sound("pickup_upgrade")
    ga_hud_msg("Nuke Radius Increased!", 5.0)
    game_msg.add("Nuke explosion radius increased!")
end

function p.dark_hole_max_ammo()
    game_maybe_ammo.dark_hole()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun0.ammo_level", delta)
    ga_hud_msg("Dark Hole Max Ammo Increased!", 5.0)
    game_msg.add("Dark hole max ammo increased!")
    ga_play_sound("pickup_upgrade")
end

function p.dark_hole_damage()
    game_maybe_ammo.dark_hole()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun0.damage_level", delta)
    ga_hud_msg("Dark Hole Damage Increased!", 5.0)
    game_msg.add("Dark hole damage increased!")
    ga_play_sound("pickup_upgrade")
end

function p.dark_hole_proj_speed()
    game_maybe_ammo.dark_hole()
    local delta = 1
    if ga_get_b("xar.difficulty.easy_2") then delta = 2 end
    std.set_bydelta_i("xar.player.gun0.speed_level", delta)
    ga_hud_msg("Dark Hole Projectile Speed Increased!", 5.0)
    game_msg.add("Dark hole projectile speed increased!")
    ga_play_sound("pickup_upgrade")
end
