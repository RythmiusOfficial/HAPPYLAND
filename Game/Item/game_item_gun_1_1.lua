-------------------------------------------------
--                Documentation
-------------------------------------------------

--Before reading this,
--read the comments at the top of "game_inv_exec.lua".
--
--Which items are equipped are stored as strings in the variables
--xar.player.equipped.X.primary (and .secondary).
--We store in these variables the name of the item script
--(without the ".lua" at the end).
--
--Let us talk about these item scripts now.
--Here are the required API functions:
--  p.use()
--  p.get_use_period()
--Here are the optional API functions:
--  p.use_start()
--  p.use_end()
--  p.get_is_rapid_fire()
--
--Most items are "rapid fire".
--To make an item non rapid fire, define the function
--p.get_is_rapid_fire() in the item script and have it
--return false.
--For a non rapid fire item, when the player uses the item
--(typically by pressing a mouse button), it will cause the
--p.use() function to be called once.
--For a rapid fire item, as long as the player is holding
--down the mouse button, the p.use() function will be
--called periodically.
--The period is specified by the return value of
--p.get_use_period().
--The function p.use() should return if the "use"
--of the item was successful.
--
--Items are allowed to have the functions
--p.use_start() and p.use_end().
--These are called when the mouse button is first
--pressed down and when it is released respectively.

-------------------------------------------------
--                    API
-------------------------------------------------

function p.use()
    local mode = 1
    return game_item_gun_1_1.use_common(mode)
end

function p.get_use_period()
    return game_wep_modes.get_fire_period(1,1)
end

-------------------------------------------------
--              Helper Functions
-------------------------------------------------

--General function.
--Returns ture iff there is another ammo to use the gun.
function p.ammo_check_common(cur_gun, mode)
    --Ammo.
    local ammo_var = "xar.player.gun" .. tostring(cur_gun) .. ".ammo"
    local ammo = ga_get_i(ammo_var)

    --Required ammo.
    local req_ammo = game_wep_modes.get_ammo_per_fire(cur_gun, mode)

    -- Seeing if have enough ammo to shoot.
    if ammo < req_ammo then
        --Not enough ammo to use.
        local starting_shoot = game_inv_exec.is_starting_use()
        local complains = game_wep_modes.should_print_not_enough_ammo(cur_gun, mode)
        if starting_shoot and complains then
            --Need to tell the player an error message.
            game_msg.add("You need " .. tostring(req_ammo) .. " ammo to fire this")
            ga_set_b("xar.inv_exec.starting_shoot", false) --So does not keep printing this. --Could do differently.
        end
        return false --Cannot use the weapon.
    end

    return true --Can use the weapon.
end

--Used by multiple scripts
--(scripts for the plasma weapon).
function p.use_common(mode)
    local cur_gun = 1

    --Making sure can use the weapon mode.
    if( not game_wep_modes.has_wep_mode(cur_gun, mode) ) then
        return false
    end

    --Making sure have enough ammo.
    if not game_item_gun_1_1.ammo_check_common(cur_gun, mode) then return false end

    local num = game_wep_modes.get_num_shoot(cur_gun, mode)

    for i = 1,num do
        local ent_type = ""
        if mode == 1 then ent_type = "ment_player_proj_plasma_1" end
        if mode == 2 then ent_type = "ment_player_proj_plasma_2" end
        if mode == 3 then ent_type = "ment_player_proj_plasma_2" end --May want to change.
        if mode == 4 then ent_type = "ment_player_proj_plasma_2" end --May want to change.
        if mode == 5 then ent_type = "ment_player_proj_plasma_5" end
        if mode == 6 then ent_type = "ment_player_proj_plasma_6" end

        local viewer_pos = ga_get_viewer_offset()
        local look = ga_get_sys_v("game.player.camera.look")
        local extend_len = 1.0
        local pos = std.vec_add(viewer_pos, std.vec_scale(look,extend_len))
        ga_ment_init_set_v("posv", pos)

        local viewer_level = ga_get_viewer_level()
        ga_ment_start(viewer_level, pos, ent_type)

        local speed = game_wep_modes.get_vel(cur_gun, mode)
        local spread = game_wep_modes.get_spread(cur_gun, mode)
        local dir = game_random.rand_weapon_spread(look, spread)
        std.normalize(dir)
        local vel = std.vec_scale(dir, speed)
        ga_ment_init_set_v("__vel", vel)

        local damage = game_wep_modes.get_curved_shot_damage(cur_gun, mode)
        ga_ment_init_set_i("damage", damage)

        ga_ment_end()
    end

    --Spending ammo.
    local ammo_var = "xar.player.gun" .. tostring(cur_gun) .. ".ammo"
    local req_ammo = game_wep_modes.get_ammo_per_fire(cur_gun, mode)
    std.set_bydelta_i(ammo_var, -req_ammo)

    --Sound.
    game_play_wep_sound.play(cur_gun, mode)

    return true
end
