function p.takeall()
    if not ga_get_sys_b("metagame.cheat.enabled") then
        ga_console_print("^1Cheating must be enabled")
        return
    end
    ga_console_print("^2Taking most health and ammo")
    ga_play_sound("cheater")
    for i = 0,9 do
        local ns = tostring(i)
        ga_set_i("xar.player.gun" .. ns .. ".ammo", 0)
    end
    ga_set_i("xar.player.shield.amount", 0)
    ga_set_i("xar.player.health.amount", 1)
    ga_set_i("xar.player.armor.amount", 0)
end

function p.giveall()
    if not ga_get_sys_b("metagame.cheat.enabled") then
        ga_console_print("^1Cheating must be enabled")
        return
    end

    ga_console_print("^2Giving max health and ammo.")
    ga_play_sound("cheater")
    for i = 0,9 do
        local ns = tostring(i)
        local ammo_max = game_wep_modes.get_ammo_max(i)
        ga_set_i("xar.player.gun" .. ns .. ".ammo", ammo_max)
    end
    --ga_set_i("xar.player.gold.amount", 99000)
    local max_health = ga_get_i("xar.player.health.max")
    ga_set_i("xar.player.health.amount", 2*max_health)
    ga_set_i("xar.player.armor.amount", 2*max_health)
end

function p.givegold()
    if not ga_get_sys_b("metagame.cheat.enabled") then
        ga_console_print("^1Cheating must be enabled")
        return
    end

    ga_console_print("^2Your gold is set to 100 thousand.")
    ga_play_sound("cheater")
    
    ga_set_i("xar.player.gold.amount", 100000) --The max is one million.
end

--So can use all basic primary and secondary aspects of weapons.
function p.giveupgrades0()
    if not ga_get_sys_b("metagame.cheat.enabled") then
        ga_console_print("^1Cheating must be enabled")
        return
    end

    ga_console_print("^2Giving upgrades 0.")

    ga_play_sound("cheater")

    --Health.
    ga_set_i("xar.player.health.level", 10)
    ga_set_i("xar.player.health.regen_level", 10)

    --Ammo.
    for i = 0,9 do
        local ns = tostring(i)
        local max = 10
        ga_set_i("xar.player.gun" .. ns .. ".ammo_level", max)
    end

    --Ammo regen.
    ga_set_i("xar.player.gun1.ammo_regen_level", 10)

    --Damage.
    for i = 0,9 do
        local ns = tostring(i)
        ga_set_i("xar.player.gun" .. ns .. ".damage_level", 0)
    end

    --Speed.
    for i = 0,9 do
        if  (i==3) or
            (i==7) or
            (i==8)
        then --Do nothing.
        else
            local ns = tostring(i)
            ga_set_i("xar.player.gun" .. ns .. ".speed_level", 0)
        end
    end

    --Fire period.
    for i = 0,9 do
        if  (i==3) or
            (i==8) or
            (i==9) or
            (i==0)
        then --Do nothing.
        else
            local ns = tostring(i)
            ga_set_i("xar.player.gun" .. ns .. ".fire_period_level", 0)
        end
    end

    --Damage.
    for i = 0,9 do
        local ns = tostring(i)
        ga_set_i("xar.player.gun" .. ns .. ".damage_level", 0)
    end

    --Freeze time.
    ga_set_i("xar.player.gun3.freeze_time_level", 0)

    --Num shots.
    ga_set_i("xar.player.gun2.num_level", 0)

    --Radius.
    ga_set_i("xar.player.gun4.radius_level", 0)
    ga_set_i("xar.player.gun8.radius_level", 0)
    ga_set_i("xar.player.gun9.radius_level", 0)

    --Time.
    ga_set_i("xar.player.gun8.freeze_time_level", 0)

    --Super upgrades.
    ga_set_i("xar.player.gun3.num_level", 0)
    ga_set_i("xar.player.gun6.num_level", 0)
    ga_set_i("xar.player.health.extra_regen_level", 0)
    ga_set_i("xar.player.armor.regen_level", 0)

    game_var_helpers.set_dep_vars()
    game_cheats.giveall()
end

function p.giveupgrades()
    if not ga_get_sys_b("metagame.cheat.enabled") then
        ga_console_print("^1Cheating must be enabled")
        return
    end

    ga_console_print("^2Giving many upgrades.")
    ga_play_sound("cheater")


    --Health.
    ga_set_i("xar.player.health.level", 100)
    ga_set_i("xar.player.health.regen_level", 100)

    --Ammo.
    for i = 0,9 do
        local ns = tostring(i)
        local max = 100
        ga_set_i("xar.player.gun" .. ns .. ".ammo_level", max)
    end

    --Ammo regen.
    ga_set_i("xar.player.gun1.ammo_regen_level", 100)

    --Speed.
    for i = 0,9 do
        if  (i==3) or
            (i==7) or
            (i==8)
        then --Do nothing.
        else
            local ns = tostring(i)
            local max = 0
            if (i==4 or i==9 or i==0) then
                max = 100
            else
                max = game_wep_modes.get_vel_level_max(i)
            end
            ga_set_i("xar.player.gun" .. ns .. ".speed_level", max)
        end
    end

    --Fire period.
    for i = 0,9 do
        if  (i==3) or
            (i==8) or
            (i==9) or
            (i==0)
        then --Do nothing.
        else
            local ns = tostring(i)
            local max = game_wep_modes.get_fire_period_level_max(i)
            ga_set_i("xar.player.gun" .. ns .. ".fire_period_level", max)
        end
    end

    --Damage.
    for i = 0,9 do
        local ns = tostring(i)
        local max = 100
        ga_set_i("xar.player.gun" .. ns .. ".damage_level", max)
    end

    --Freeze time.
    ga_set_i("xar.player.gun3.freeze_time_level",
        game_wep_modes.get_freeze_length_level_max(3))

    --Num shots.
    ga_set_i("xar.player.gun2.num_level",
        game_wep_modes.get_num_level_max(2))

    --Radius.
    ga_set_i("xar.player.gun4.radius_level",
        game_wep_modes.get_radius_level_max(4))
    ga_set_i("xar.player.gun8.radius_level", 100)
    ga_set_i("xar.player.gun9.radius_level", 100)

    --Time.
    ga_set_i("xar.player.gun8.freeze_time_level", 100)

    --Super upgrades.
    ga_set_i("xar.player.gun3.num_level", 0)
    ga_set_i("xar.player.gun6.num_level", 0)
    ga_set_i("xar.player.health.extra_regen_level", 10)
    ga_set_i("xar.player.armor.regen_level", 0)

    game_var_helpers.set_dep_vars()
    game_cheats.giveall()
end

--This comes from a particular 20 hour play of the game.
function p.giveupgrades2()
    if not ga_get_sys_b("metagame.cheat.enabled") then
        ga_console_print("^1Cheating must be enabled")
        return
    end

    ga_console_print("^2Giving many upgrades 2.")

    ga_play_sound("cheater")

    --Health.
    ga_set_i("xar.player.health.level", 1000)
    ga_set_i("xar.player.health.regen_level", 1000)

    --Ammo.
    for i = 0,9 do
        local ns = tostring(i)
        local max = 1000
        ga_set_i("xar.player.gun" .. ns .. ".ammo_level", max)
    end

    --Ammo regen.
    ga_set_i("xar.player.gun1.ammo_regen_level", 1000)

    --Speed.
    for i = 0,9 do
        if  (i==3) or
            (i==7) or
            (i==8)
        then --Do nothing.
        else
            local ns = tostring(i)
            local max = 0
            if (i==4 or i==9 or i==0) then
                max = 100
            else
                max = game_wep_modes.get_vel_level_max(i)
            end
            ga_set_i("xar.player.gun" .. ns .. ".speed_level", max)
        end
    end

    --Fire period.
    for i = 0,9 do
        if  (i==3) or
            (i==8) or
            (i==9) or
            (i==0)
        then --Do nothing.
        else
            local ns = tostring(i)
            local max = game_wep_modes.get_fire_period_level_max(i)
            ga_set_i("xar.player.gun" .. ns .. ".fire_period_level", max)
        end
    end

    --Damage.
    for i = 0,9 do
        local ns = tostring(i)
        local max = 1000
        ga_set_i("xar.player.gun" .. ns .. ".damage_level", max)
    end

    --Freeze time.
    ga_set_i("xar.player.gun3.freeze_time_level",
        game_wep_modes.get_freeze_length_level_max(3))
    ga_set_i("xar.player.gun8.freeze_time_level", 200)

    --Num shots.
    ga_set_i("xar.player.gun2.num_level",
        game_wep_modes.get_num_level_max(2))

    --Radius.
    ga_set_i("xar.player.gun4.radius_level",
        game_wep_modes.get_radius_level_max(4))
    ga_set_i("xar.player.gun8.radius_level", 200)
    ga_set_i("xar.player.gun9.radius_level", 30)

    --Super upgrades.
    ga_set_i("xar.player.gun3.num_level", 9)
    ga_set_i("xar.player.gun6.num_level", 4)
    ga_set_i("xar.player.health.extra_regen_level", 50)
    ga_set_i("xar.player.armor.regen_level", 7)

    game_var_helpers.set_dep_vars()
    game_cheats.giveall()
end

function p.give_all_weapon_modes()
    if not ga_get_sys_b("metagame.cheat.enabled") then
        ga_console_print("^1Cheating must be enabled")
        return
    end

    game_wep_modes.give_all_modes()
end

function p.freemarkers()
    if not ga_get_sys_b("metagame.cheat.enabled") then
        ga_console_print("^1Cheating must be enabled")
        return
    end

    if ga_get_b("xar.cheat.free_markers") then
        ga_set_b("xar.cheat.free_markers", false)
        ga_console_print("Dropping markers now costs gold.")
    else
        ga_set_b("xar.cheat.free_markers", true)
        ga_console_print("^2Dropping markers is now free.")
    end
end

function p.topofworld()
    if not ga_get_sys_b("metagame.cheat.enabled") then
        ga_console_print("^1Cheating must be enabled")
        return
    end
    --And I know it's hard when you're falling down
    --And it's a long way up when you hit the ground
    --Get up now, get up, get up now.
    ga_tele("EMPTY_PATH", std.vec(2.0, 2.0, 2.0))
end

function p.pink_tele()
    if not ga_get_sys_b("metagame.cheat.enabled") then
        ga_console_print("^1Cheating must be enabled")
        return
    end

    --Old way (removed from API).
    -- ga_tele_pink()

    --New way.
    local chunk_id = ga_get_viewer_chunk_id()
    game_base_tele_pink.tele(chunk_id)
end

function p.blue_tele()
    if not ga_get_sys_b("metagame.cheat.enabled") then
        ga_console_print("^1Cheating must be enabled")
        return
    end
    
    -- Old way (removed from API).
    -- ga_tele_blue()

    --New way.
    local chunk_id = ga_get_viewer_chunk_id()
    game_base_tele_blue.start_tele(chunk_id)
end
