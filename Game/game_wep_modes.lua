--Weapons and modes.

--When we add a new weapon mode, sometimes it changes the
--numbers of old weapon modes, causing the player to have
--more than 3 modes selected for a weapon.
--When this happens, we reset which modes they have
--to the default configuration.
function p.correct_has_vars()
    for wep = 0,9 do
        local max_mode = p.get_max_mode(wep)
        local count = 0
        for mode = 1,max_mode do
            local var_str = "xar.player.gun" .. tostring(wep)
                .. ".mode" .. tostring(mode) .. ".equipped"
            if ga_get_b(var_str) then count = count + 1 end
        end
        if count > 2 then
            p.correct_has_vars_helper(wep)
        end
    end
end

--The default configuration.
function p.correct_has_vars_helper(wep)
    --The other weapons are already stable.
    if wep == 3 then
        ga_set_b("xar.player.gun3.mode1.has",       true) --Ice Laser
        ga_set_b("xar.player.gun3.mode1.equipped",  true)
        ga_set_b("xar.player.gun3.mode2.has",       false)
        ga_set_b("xar.player.gun3.mode2.equipped",  false)
        ga_set_b("xar.player.gun3.mode3.has",       false)
        ga_set_b("xar.player.gun3.mode3.equipped",  false)
        ga_set_b("xar.player.gun3.mode4.has",       true) --Laser Disco
        ga_set_b("xar.player.gun3.mode4.equipped",  true)
        ga_set_s("xar.player.equipped.3.primary",   "item_gun_3_1")
        ga_set_s("xar.player.equipped.3.secondary", "item_gun_3_4")
    end
end

--Returns true iff the player is able to used
--the specified weapon mode.  Some weapon modes
--are available at the beginning of the game.
--Others have to be unlocked.
function p.has_wep_mode(wep, mode)
    local var = "xar.player.gun"
        .. tostring(wep)
        .. ".mode"
        .. tostring(mode)
        .. ".has"
    local has = ga_get_b(var)
    return has
end

--Will refresh the global vars
--that start with "xar.player.equipped." .. tostring(wep)
function p.refresh_equip_strs(wep)
    ga_debug_push("game_wep_modes.refresh_equip_strs")

    wep = wep % 10

    local var_primary =
        "xar.player.equipped."
        .. tostring(wep) .. ".primary"
    local var_secondary =
        "xar.player.equipped."
        .. tostring(wep) .. ".secondary"
    local max_mode = p.get_max_mode(wep)
    local got_primary = false
    for mode = 1,max_mode do
        local cur_equipped_var =
            "xar.player.gun" .. tostring(wep)
            .. ".mode" .. tostring(mode) .. ".equipped"
        local cur_equipped = ga_get_b(cur_equipped_var)
        if( cur_equipped ) then
            local item_name =
                "item_gun_"
                .. tostring(wep)
                .. "_"
                .. tostring(mode)
            if( got_primary ) then
                ga_set_s(var_secondary, item_name)
            else
                --Setting the primary.
                ga_set_s(var_primary, item_name)
                got_primary = true
            end
        end
    end

    ga_debug_pop("game_wep_modes.refresh_equip_strs")
end

function p.wrap_wep(wep)
    if wep == 10 then return 0 end
    return wep
end

function p.get_wep_name(wep)
    if wep == 1 then return "Plasma" end
    if wep == 2 then return "Cannon" end
    if wep == 3 then return "Laser" end
    if wep == 4 then return "Rocket" end
    if wep == 5 then return "Homing Rocket" end
    if wep == 6 then return "Minigun" end
    if wep == 7 then return "Railgun" end
    if wep == 8 then return "EMP" end
    if wep == 9 then return "Nuke" end
    if wep == 0 then return "Dark Hole" end
    return "ERROR"
end

function p.get_wep_mode_name(wep, mode)
    if wep == 1 then
        if mode == 1 then return "Basic High DPA" end
        if mode == 2 then return "Rapid Fire" end
        if mode == 3 then return "Plasma Shotgun" end
        if mode == 4 then return "Hyper Rapid Fire" end
        if mode == 5 then return "Lightning Rifle" end
        if mode == 6 then return "Flare" end
    end
    if wep == 2 then
        if mode == 1 then return "Blunderbuss" end
        if mode == 2 then return "Tommy Gun" end
        if mode == 3 then return "Chaining Cannon Ball" end
    end
    if wep == 3 then
        if mode == 1 then return "Ice Laser" end
        if mode == 2 then return "Cold Beam" end
        if mode == 3 then return "Freeze Ray" end
        if mode == 4 then return "Laser Disco" end
    end
    if wep == 4 then
        if mode == 1 then return "Basic Rocket" end
        if mode == 2 then return "High Velocity Rocket" end
        if mode == 3 then return "Big Radius Rocket" end
        if mode == 4 then return "Kinetic Rocket" end
        if mode == 5 then return "Progressive Rocket" end
    end
    if wep == 5 then
        if mode == 1 then return "Single Shot" end
        if mode == 2 then return "Cluster Shot" end
    end
    if wep == 6 then
        if mode == 1 then return "Rapid Fire" end
        if mode == 2 then return "Poison Dart" end
    end
    if wep == 7 then
        if mode == 1 then return "Classic Railgun" end
        if mode == 2 then return "Rapid Railgun" end
        if mode == 3 then return "Vampire Railgun" end
        if mode == 4 then return "Super Vampire Railgun" end
    end
    if wep == 8 then
        if mode == 1 then return "EMP" end
        if mode == 2 then return "EMP With Damage" end
    end
    if wep == 9 then
        if mode == 1 then return "High Damage" end
        if mode == 2 then return "High Velocity and Radius" end
        if mode == 3 then return "Nuclear Pulse Propulsion" end
    end
    if wep == 0 then
        if mode == 1 then return "Dark Hole Launcher" end
        if mode == 2 then return "Exchange Health for Hole" end
        if mode == 3 then return "Black Hole Drive" end
        if mode == 4 then return "Quasar Drive" end
    end
    return "NOT YET DONE!!!"
end

function p.wep_mode_name_to_num(wep, name)
    local wrapped_wep = p.wrap_wep(wep)
    local num_modes = p.get_max_mode(wep)
    for i = 1,num_modes do
        local existing_name = p.get_wep_mode_name(wrapped_wep,i)
        if name == existing_name then
            return i
        end
    end
    return -1 --Error.
end

function p.get_max_mode(wep)
    wep = wep % 10
    --
    if wep == 1 then return 6 end
    if wep == 2 then return 3 end
    if wep == 3 then return 4 end
    if wep == 4 then return 5 end
    --more!!! (add gun 5 one day when it has > 2 modes).
    --more!!! (add gun 6 one day when it has > 2 modes).
    if wep == 7 then return 4 end
    --more!!! (add gun 8 one day when it has > 2 modes).
    if wep == 9 then return 3 end
    if wep == 0 then return 4 end
    return 2
end

--For debugging.
function p.give_all_modes()
    for wep = 0,9 do
        local max_mode = p.get_max_mode(wep)
        for mode = 1,max_mode do
            p.give_mode(wep,mode)
        end
    end
end

function p.give_mode(wep, mode)
    local use_to_have = p.get_has(wep, mode)
    if not use_to_have then
        ga_play_sound("fanfare")
    end
    local var_str = "xar.player.gun" .. tostring(wep)
        .. ".mode" .. tostring(mode) .. ".has"
    ga_set_b(var_str, true)
    --
    local wep_str = p.get_wep_name(wep)
        .. ": " .. p.get_wep_mode_name(wep,mode)
    if use_to_have then
        ga_hud_msg("You already have this weapon mode", 5.0)
    else
        ga_hud_msg("New weapon mode: " .. wep_str, 5.0)
    end
end

function p.get_has(wep, mode)
    local var_str = "xar.player.gun" .. tostring(wep)
        .. ".mode" .. tostring(mode) .. ".has"
    return ga_get_b(var_str)
end

function p.get_equipped(wep, mode)
    local wrapped_wep = p.wrap_wep(wep)
    local var_str = "xar.player.gun" .. tostring(wrapped_wep)
        .. ".mode" .. tostring(mode) .. ".equipped"
    return ga_get_b(var_str)
end

function p.get_primary_mode(wep)
    local mode = 1
    while true do
        if p.get_equipped(wep,mode) then return mode end
        mode = mode + 1
        if mode >= 100 then break end
    end
    ga_print("*** Error: no equipped modes in get_primary_mode for gun " .. tostring(wep))
    ga_exit()
end

function p.get_secondary_mode(wep)
    local primary_mode = p.get_primary_mode(wep)
    local mode = primary_mode + 1
    while true do
        if p.get_equipped(wep,mode) then return mode end
        mode = mode + 1
        if mode >= 100 then break end
    end
    ga_print("*** Error: no equipped modes in get_secondary_mode for gun " .. tostring(wep))
    ga_exit()
end

--A helper function.
function p.equip_mode_raw(wep, mode)
    ga_debug_push("game_wep_modes.equip_mode_raw")
    --
    local wrapped_wep = p.wrap_wep(wep)
    local var_str = "xar.player.gun" .. tostring(wrapped_wep)
        .. ".mode" .. tostring(mode) .. ".equipped"
    ga_set_b(var_str, true)
    --
    p.refresh_equip_strs(wep)
    --
    ga_debug_pop("game_wep_modes.equip_mode_raw")
end

--A helper function.
function p.unequip_mode_raw(wep, mode)
    local wrapped_wep = p.wrap_wep(wep)
    local var_str = "xar.player.gun" .. tostring(wrapped_wep)
        .. ".mode" .. tostring(mode) .. ".equipped"
    ga_set_b(var_str, false)
end

function p.equip_mode(wep, mode)
    local wrapped_wep = wep
    if wrapped_wep == 10 then wrapped_wep = 0 end
    local last_mode = ga_get_i("xar.player.gun"
        .. tostring(wrapped_wep) .. ".last_mode")
    local last_last_mode = ga_get_i("xar.player.gun"
        .. tostring(wrapped_wep) .. ".last_last_mode")

    if( mode == last_mode ) then return end

    for i = 1, p.get_max_mode(wep) do
        p.unequip_mode_raw(wep, i)
    end
    p.equip_mode_raw(wep, last_mode)
    p.equip_mode_raw(wep, mode)
    --
    ga_set_i("xar.player.gun" .. tostring(wrapped_wep) .. ".last_mode", mode)
    ga_set_i("xar.player.gun" .. tostring(wrapped_wep) .. ".last_last_mode", last_mode)
end

function p.get_ammo_max(wep)
    local var_str = "xar.player.gun" .. tostring(wep) .. ".ammo_level"
    local lev = ga_get_i(var_str)

    if wep == 1 then
        return 40 + lev*10
    end
    if wep == 2 then
        return 100 + lev*5
    end
    if wep == 3 then
        return 32 + lev*8
    end
    if wep == 4 then
        return 20 + lev*4 --Making it better.
        -- return 10 + lev*3
    end
    if wep == 5 then
        return 200 + lev*10 --Making cap better.
    end
    if wep == 6 then
        return 48 + lev*12
    end
    if wep == 7 then
        return 48 + lev*12
    end
    if wep == 8 then
        return 2 + lev
    end
    if wep == 9 then
        return 1 + lev
    end
    if wep == 0 then
        return 1 + lev
    end
    return 0
end

function p.get_fire_period_level_max(wep)
    if wep == 1 then return 16 end
    if wep == 2 then return 12 end
    if wep == 3 then return -1 end
    if wep == 4 then return 16 end
    if wep == 5 then return 56 end
    if wep == 6 then return 26 end
    if wep == 7 then return 14 end
    if wep == 8 then return -1 end
    if wep == 9 then return -1 end
    if wep == 0 then return -1 end
end

function p.get_vel_level_max(wep)
    if wep == 1 then return 46 end
    if wep == 2 then return 11 end
    if wep == 3 then return -1 end
    if wep == 4 then return -1 end
    if wep == 5 then return 46 end
    if wep == 6 then return 100 end
    if wep == 7 then return -1 end
    if wep == 8 then return -1 end
    if wep == 9 then return -1 end
    if wep == 0 then return -1 end
end

function p.get_num_level_max(wep)
    if wep == 2 then return 8 end
    return -1
end

function p.get_special_num_level_max(wep)
    if wep == 6 then return 10 end
    return -1
end

function p.get_freeze_length_level_max(wep)
    if wep == 3 then return 36 end
    return -1
end

function p.get_radius_level_max(wep)
    if wep == 4 then return 28 end
    return -1
end

function p.get_ammo_regen_period(wep)
    if wep ~= 1 then
        ga_print("*** Error: game_wep_modes.get_ammo_regen_period")
        ga_print("called on a non plamsa weapon")
        ga_exit()
    end

    --Plasma regenertes 1/2 per second, which goes up by 1/8 per second
    --for each regen upgrade you have.
    local lev = ga_get_i("xar.player.gun1.ammo_regen_level")
    return 1.0 / (0.5 + 0.125 * lev)
end

--Ammo per fire (required ammo, or req ammo).
function p.get_ammo_per_fire(wep, mode)
    if wep == 1 then
        if mode == 2 then return 8 end
        if mode == 3 then return 100 end
        if mode == 4 then return 8*6 end --But only 4x damage as mode 2.
        if mode == 5 then return 200 end
        if mode == 6 then return 50 end --Ok???
    end
    if wep == 2 then
        if mode == 2 then return 3 end
    end
    if wep == 3 then
        if mode == 2 then return 2 end
        if mode == 3 then return 2 end
        if mode == 4 then return 8 end
    end
    if wep == 4 then
        if mode == 2 then return 3 end
        if mode == 3 then return 2 end
        if mode == 5 then return 3 end
    end
    if wep == 5 then
        if mode == 1 then return 20 end
        if mode == 2 then return 10 end
    end
    if wep == 7 then
        if mode == 2 then return 2 end
    end
    if wep == 0 then
        if mode == 2 then return 0 end
        if mode == 3 then return 20 end --Woah.
        if mode == 4 then return 60 end --Holy cow!!!
    end
    return 1
end

--Returns true iff should print "not enough ammo"
--when trying to shoot and there is not enough ammo.
function p.should_print_not_enough_ammo(wep, mode)
    wep = wep % 10
    if wep == 1 then
        if mode == 3 then return true end
        if mode == 5 then return true end
        if mode == 6 then return true end
    end
    if wep == 0 then
        if mode == 3 then return true end
        if mode == 4 then return true end
    end
    return false
end

function p.get_fire_period(wep, mode)
    local var_str = "xar.player.gun" .. tostring(wep) .. ".fire_period_level"
    if wep == 1 then
        if mode == 3 then return 1.5 end
        if mode == 5 then return 1.5 end
        if mode == 6 then return 0.25 end --Ok???
        local lev = ga_get_i(var_str)
        local fire_period = 1.0 / (4.0 + lev)
        return fire_period
    end
    if wep == 2 then
        local lev = ga_get_i(var_str)
        local fire_period = 1.0 / (1.0 + 0.25*lev)
        if mode == 2 then return fire_period*0.5 end
        return fire_period
    end
    if wep == 3 then
        return 0.25
    end
    if wep == 4 then
        local lev = ga_get_i(var_str)
        local fire_period = 1.0 / (1.0 + 0.25*lev)
        if mode == 1 then return fire_period end
        if mode == 2 then return fire_period end
        if mode == 3 then return fire_period end
        if mode == 4 then return fire_period end
        if mode == 5 then return fire_period end
    end
    if wep == 5 then
        local lev = ga_get_i(var_str)
        local fire_period = 1.0 / (3.0 + 0.125*lev)
        if mode == 1 then return 1.0 end
        -- if mode == 1 then return fire_period end
        if mode == 2 then return fire_period*2 end
    end
    if wep == 6 then
        local lev = ga_get_i(var_str)
        local primary_fire_period = 1.0 / (4.0 + lev)
        if mode == 1 then return primary_fire_period end
        if mode == 2 then return 0.25 end
    end
    if wep == 7 then
        local lev = ga_get_i(var_str)
        local primary_fire_period = 1.0 / (0.5 + 0.25 * lev)
        if mode == 2 then return primary_fire_period * 0.25 end
        return primary_fire_period
    end
    if wep == 8 then
        return 1.0
    end
    if wep == 9 then
        if mode == 1 then return 1.0 end
        if mode == 2 then return 0.75 end
        if mode == 3 then return 0.75 end
    end
    if wep == 0 then
        if mode == 1 then return 2.0 end
        if mode == 2 then return 0.25 end
        if mode == 3 then return 1.0 end
        if mode == 4 then return 1.0 end
    end
    ga_print("*** Error: wep " .. tostring(wep) .. " not yet handeled by game_wep_modes.get_fire_period")
    ga_exit()
end

--Velocity.
function p.get_vel(wep, mode)
    local var_str = "xar.player.gun" .. tostring(wep) .. ".speed_level"
    if wep == 1 then
        local lev = ga_get_i(var_str)
        local vel = 4 + lev
        if mode == 2 then vel = vel * 2 end
        if mode == 3 then vel = vel * 2 end
        if mode == 4 then vel = vel * 3 end
        if mode == 5 then return 300000000.0 end --Speed of light bitch.
        if mode == 6 then return 10000 end --Ok?
        return math.floor(vel)
    end
    if wep == 2 then
        local lev = ga_get_i(var_str)
        local vel = 8 + 2*lev
        if mode == 2 then vel = vel * 20 end
        if mode == 3 then vel = vel * 2 end
        --more!!!
        return vel
    end
    if wep == 3 then
        if mode == 1 then return 100000 end --One hundred thousand.
        if mode == 2 then return 1000000 end --One million.
        if mode == 3 then return 10000000 end --Ten million.
        if mode == 4 then return 100000 end --One hundred thousand.
        return 
    end
    if wep == 4 then
        local lev = ga_get_i(var_str)
        -- local vel = 8 + 2*lev
        local vel = 24 + 2*lev --Makeing the baseline 3 times as good.
        if mode == 2 then vel = vel * 8 end
        if mode == 3 then vel = math.max( math.floor(vel/4), 1 ) end
        if mode == 4 then vel = math.max( math.floor(vel/8), 1 ) end
        if mode == 5 then vel = math.max( math.floor(vel/32), 1 ) end
        return vel
    end
    if wep == 5 then
        local lev = ga_get_i(var_str)
        if mode == 1 then return 30 end --Ok?
        local vel = 4 + lev
        --more!!!
        return vel
    end
    if wep == 6 then
        local lev = ga_get_i(var_str)
        if mode == 1 then return 1000 end
        if mode == 2 then return 16 + 4*lev end
        --more!!!
    end
    if wep == 7 then
        if mode == 1 then return 10000 end --Ten thousand.
        if mode == 2 then return 10000 end --Ten thousand.
        if mode == 3 then return 1000000 end --One million.
        if mode == 4 then return 1000000 end --One million.
    end
    if wep == 8 then
        return 0
    end
    if wep == 9 then
        local lev = ga_get_i(var_str)
        -- local vel = 4 + lev
        local vel = 12 + lev --Makeing the baseline 3 times as good.
        if mode == 1 then return vel end
        if mode == 2 then return vel * 3 end
        if mode == 3 then return 0 end
    end
    if wep == 0 then
        local lev = ga_get_i(var_str)
        local vel = 32 + 8*lev
        if mode == 1 then return vel end
        if mode == 2 then return 0 end
    end
    ga_print("*** Error: wep " .. tostring(wep) .. " not yet handeled by game_wep_modes.get_vel")
    ga_exit()
end

function p.get_spread(wep, mode)
    if wep == 1 then
        if mode == 3 then return 0.3 end
        if mode == 4 then return 0.2 end
        return 0.0
    end
    if wep == 2 then
        -- if mode == 1 then return 0.6 end --DEBUGGING!!!
        if mode == 1 then return 0.08 end
        if mode == 2 then return 0.08 end
        if mode == 3 then return 0.0 end
        --more!!!
    end
    if wep == 6 then
        if mode == 1 then return 0.1 end
    end
    if wep == 7 then
        if mode == 2 then return 0.1 end
    end
    return 0.0
end

--Damage when the projectile hits an enemy
--(not counting explosion damage).
function p.get_curved_damage_helper(wep, mode)
    local var_str = "xar.player.gun" .. tostring(wep) .. ".damage_level"
    local lev = ga_get_i(var_str)
    if wep == 1 then
        local curved_shot_damage = p.get_curved_shot_damage(1,mode)
        local num_shots = p.get_num_shoot(1,mode)
        return curved_shot_damage * num_shots
    end
    if wep == 2 then
        if mode == 1 then
            local curved_shot_damage = p.get_curved_shot_damage(2,1)
            local num_shots = p.get_num_shoot(2,1)
            return curved_shot_damage * num_shots
        end
        if mode == 2 then
            local primary_damage = p.get_curved_damage(2,1)
            return primary_damage * 3
        end
        if mode == 3 then
            local primary_damage = p.get_curved_damage(2,1)
            return primary_damage * 0.5
        end
    end
    if wep == 3 then
        if mode == 1 then
            local special_lev = ga_get_i("xar.player.gun3.num_level")
            -- (8+2*lev) * (special_lev+1) --now factor out a 2.
            local factor = (4 + lev) * (special_lev + 1)
            return game_difficulty_curve.curve_player_damage2(factor, 2)
        end
        local primary_damage = p.get_curved_damage(3,1)
        if mode == 2 then return primary_damage * 4 end
        if mode == 3 then return primary_damage * 6 end
        if mode == 4 then
            return primary_damage * 4 * 8
        end
    end
    if wep == 4 then
        local primary_damage = game_difficulty_curve.curve_player_damage2(4+lev, 8)
        if mode == 1 then return primary_damage end
        if mode == 2 then return primary_damage * 2 end --But requires 3 ammo.
        if mode == 3 then return primary_damage * 2 end --But requires 2 ammo.
        if mode == 4 then return primary_damage * 4 end --Previously was 8.
        if mode == 5 then return primary_damage * 6 * 3 end --Previously was 12 (and 3 shots).
        --more!!!
    end
    if wep == 5 then
        if mode == 1 then
            --Making damage better.
            --Primary damage.
            return game_difficulty_curve.curve_player_damage2(4+lev,8)
        end
        if mode == 2 then
            local curved_shot_damage = p.get_curved_shot_damage(5,2)
            local num_shots = p.get_num_shoot(5,2)
            return curved_shot_damage * num_shots
        end
    end
    if wep == 6 then
        if mode == 1 then
            local special_lev = ga_get_i("xar.player.gun6.num_level")
            -- local damage = 8 * (4 + lev) * (special_lev+1)
            return game_difficulty_curve.curve_player_damage2(
                (4+lev) * (1+special_lev), 8)
        end
        if mode == 2 then
            return 1 --Damage is via a poison effect.
        end
    end
    if wep == 7 then
        local primary_damage = game_difficulty_curve.curve_player_damage2(4+lev, 32)
        if mode == 1 then return primary_damage end
        if mode == 2 then return primary_damage*2 end
        if mode == 3 then return math.floor(primary_damage/2) end
        if mode == 4 then return primary_damage end
    end
    if wep == 8 then
        local main_damage = game_difficulty_curve.curve_player_damage2(4+lev, 8)
        if mode == 1 then return 0 end
        if mode == 2 then return main_damage end
    end
    if wep == 9 then
        local primary_damage = game_difficulty_curve.curve_player_damage2(4+lev, 1000)
        if mode == 1 then return primary_damage end
        if mode == 2 then return math.floor(primary_damage/2) end
        if mode == 3 then return primary_damage end
    end
    if wep == 0 then
        --Note: because of charges, this is more complex.
        -- Curve each damage level seperately in game_inv_exec,
        -- then multiply by 10.
        return 80 + 20 * lev
    end
    --more!!!
    ga_print("*** Error: wep " .. tostring(wep) .. " mode "
        .. tostring(mode) .. " not yet handeled by game_wep_modes.get_curved_damage")
    ga_exit()
end

function p.get_curved_damage(wep, mode)
    return math.floor( p.get_curved_damage_helper(wep, mode)  )
end

--For weapons that shot mutliple shots when fired once.
function p.get_curved_shot_damage_helper(wep,mode)
    if wep == 1 then
        local damage_lev = ga_get_i("xar.player.gun1.damage_level")
        local curved_primary_damage = game_difficulty_curve.curve_player_damage2(4+damage_lev, 1)
        if mode == 1 then return curved_primary_damage end
        if mode == 2 then return curved_primary_damage*4 end
        if mode == 3 then return curved_primary_damage*5 end --5 is 100 divided by 20 shots.
        if mode == 4 then return curved_primary_damage*4 end --But shoots 4 of them.
        if mode == 5 then return curved_primary_damage*25 end
        if mode == 6 then return 0 end
    end
    if wep == 2 then
        local damage_lev = ga_get_i("xar.player.gun2.damage_level")
        if mode == 1 then return game_difficulty_curve.curve_player_damage2(2+damage_lev, 1) end
        if mode == 2 then return p.get_curved_damage(2,2) end
        if mode == 3 then return p.get_curved_damage(2,3) end
    end
    if wep == 3 then
        --Adding April 29, 2024.
        local primary_damage = p.get_curved_damage(3,1)
        --The primary shoots 8 shots, each shot does 4 times the
        --damage as the primary.
        if mode == 1 then return primary_damage end
        if mode == 2 then return primary_damage*4 end
    end
    if wep == 5 then
        if mode == 2 then
            local primary_damage = p.get_curved_damage(5,1)
            return math.floor( primary_damage/2 )
        end
    end
    ga_print("*** Error: wep " .. tostring(wep) .. " not yet handeled by game_wep_modes.get_curved_shot_damage")
    ga_exit()
end

function p.get_curved_shot_damage(wep,mode)
    return math.floor( p.get_curved_shot_damage_helper(wep,mode) )
end

function p.get_curved_expl_damage(wep,mode)
    --No exceptions to this rule yet.
    return p.get_curved_damage(wep,mode)
end

--NOT: NOT QUITE RIGHT: WE SHOULD MODIFY PLAYER'S OUT DAMAGE
--OF THE CONTANT AND EXPLOSION WITH win_stats3.calc_dmg_from_player,
--THEN RETURN THE SUM!!!
function p.get_curved_direct_hit_from_player(wep,mod)
    local contant_damage = game_damage.calc_damage_from_player( p.get_curved_damage(wep,mod) )
    local expl_damage = game_damage.calc_damage_from_player( p.get_curved_expl_damage(wep,mod) )
    return contant_damage + expl_damage
end

--For weapons that shoot multiple shots when fired once.
function p.get_num_shoot(wep, mode)
    if wep == 1 then
        if mode == 3 then return 20 end
        if mode == 4 then return 4 end
        return 1
    end
    if wep == 2 then
        local lev = ga_get_i("xar.player.gun2.num_level")
        if mode == 1 then return 4 + lev end
        if mode == 2 then return 1 end
        if mode == 3 then return 1 end
    end
    if wep == 5 then
        if mode == 2 then return 20 end --Although each shot does half normal damage.
    end
    ga_print("*** Error: wep " .. tostring(wep) .. " not yet handeled by game_wep_modes.get_num_shoot")
    ga_exit()
end

--For weapons that have a freeze effect.
function p.get_freeze_length(wep, mode)
    if wep == 3 then
        local lev = ga_get_i("xar.player.gun3.freeze_time_level")
        local base = 2 + 0.5*lev
        if mode == 1 then return base end
        if mode == 2 then return base * 2.5 end --More efficient.
        if mode == 3 then return base * 2 end
        if mode == 4 then return 0 end
    end
    if wep == 8 then
        local lev = ga_get_i("xar.player.gun8.freeze_time_level")
        local main_len = 4 + lev
        if mode == 1 then return main_len end
        if mode == 2 then return main_len end
    end
    ga_print("*** Error: wep " .. tostring(wep) .. " not yet handeled by game_wep_modes.get_freeze_length")
    ga_exit()
end

function p.get_radius(wep, mode)
    local var_str = "xar.player.gun" .. tostring(wep) .. ".radius_level"
    if wep == 4 then
        local lev = ga_get_i(var_str)
        local base = 4 + lev
        if mode == 1 then return base end
        if mode == 2 then return base end
        if mode == 3 then return base*2 end
        if mode == 4 then return 0 end
        if mode == 5 then return 0 end
    end
    if wep == 8 then
        local lev = ga_get_i(var_str)
        local main_radius = 16 + 4*lev
        if mode == 1 then return main_radius end
        if mode == 2 then return main_radius end
    end
    if wep == 9 then
        local lev = ga_get_i(var_str)
        local main_radius = 16 + 4*lev
        if mode == 1 then return main_radius end
        if mode == 2 then return main_radius * 2 end
        if mode == 3 then return main_radius end
    end
    ga_print("*** Error: wep " .. tostring(wep) .. " not yet handeled by game_wep_modes.get_radius")
    ga_exit()
end

function p.get_poison_len(wep, mode)
    if wep == 6 then
        if mode == 2 then return 10 end
    end
    ga_print("*** Error: wep " .. tostring(wep) .. " not yet handeled by game_wep_modes.get_poison_len")
    ga_exit()
end

function p.get_poison_total_damage(wep, mode)
    if wep == 6 then
        if mode == 2 then
             --20 times damage as one primary shot.
            local primary_curved_damage = p.get_curved_damage(6,1)
            return primary_curved_damage * 20 * 1
        end
    end
end

function p.get_health_bonus(wep, mode)
    if wep == 7 then
        if mode == 3 then
            local raw_damage = p.get_curved_damage(7,3)
            return raw_damage / 4.0
        end
        if mode == 4 then
            local raw_damage = p.get_curved_damage(7,4)
            return raw_damage / 8.0
        end
    end
    return 0.0
end

--Only used for stats windows.
--Takes calc_dmg_from_player into account.
function p.get_dps(wep, mode)
    --Exceptions.
    if wep == 6 then
        if mode == 2 then
            local poison_total_damage = p.get_poison_total_damage(6,2)
            local poison_len = p.get_poison_len(6,2)
            return poison_total_damage / poison_len
        end
    end
    --
    local fire_period = p.get_fire_period(wep, mode)
    local fire_rate = 1.0 / fire_period
    local raw_damage = p.get_curved_damage(wep, mode)
    local damage = game_damage.calc_damage_from_player(raw_damage)
    local dps = fire_rate * damage
    return dps
end

function p.get_dpa(wep, mode)
    local ammo_per_fire = p.get_ammo_per_fire(wep, mode)
    local raw_damage = p.get_curved_damage(wep, mode)
    local damage = game_damage.calc_damage_from_player(raw_damage)
    local dpa = damage / ammo_per_fire
    return dpa
end
