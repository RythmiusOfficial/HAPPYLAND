-------------------------------------------------
--                    API
-------------------------------------------------

--Typically the user will hold down a mouse button, which should cause
--the p.start_use function here to be called.  This will register that
--a weapon is being used, via setting the global var "xar.inv_exec.cur_wep" etc.
--When the mouse is released, the p.end_use function should be called.
--While the mouse is down, the p.update() function should be called every frame.
--This will result in many "rapid fire" shots being taken
--(but note that actually some weapons are not rapid fire).
--In addition, the p.update() function calls each item's update function,
--for each of the 20 equipped items.
--
--See also item_gun_1_1.lua for more documentation.

--There can be at most one item that the user is "holding the shoot button for".
--That is, p.start_use has been called by p.end_use has not been called yet.
--This returns that item string (or the empty string if the user is not
--holding the use inventory item key).
--This is used to fix the Dark hole charging bug for example.
--
--We might want to rename xar.inv_exec.starting_shoot to
--temp.xar.inv_exec.starting_shoot (making it temporary).
--This way when you save and load, it does not
--remember that you are holding shoot.
--To do this, we would not list it in the globals.txt file
--and we would need to create it in Lua.
function p.get_cur_starting_shoot_item()
    p.emergency_fix_equipped_item_names()
    if( not ga_get_b("xar.inv_exec.starting_shoot") ) then return "" end
    local cur_wep = ga_get_i("xar.inv_exec.cur_wep")
    local primary = ga_get_b("xar.inv_exec.primary")
    if( cur_wep < 0 ) then return "" end
    if( cur_wep > 9 ) then return "" end
    return p.get_item_str(cur_wep, primary)
end

--Could be called when the user presses a mouse button, for example.
function p.start_use(gun, primary)
    p.emergency_fix_equipped_item_names()
    if( game_genesis.enabled() ) then
        if( ga_get_b("xar.cheat.inf2.enabled") ) then
            --Hackish, but then again it is an Easter egg.
            ga_set_i("xar.inv_exec.cur_wep", 1)
            ga_set_b("xar.inv_exec.primary", primary)
            ga_set_b("xar.inv_exec.starting_shoot", true)
        end
        return
    end
    ga_set_i("xar.inv_exec.cur_wep", gun)
    ga_set_b("xar.inv_exec.primary", primary)
    ga_set_b("xar.inv_exec.starting_shoot", true)

    local item_str = p.get_item_str(gun, primary)

    local mod_name = item_str
    local func_name = "use_start"
    if( _G[mod_name] and
        _G[mod_name][func_name] )
    then
        --Calling the use_start function.
        _G[mod_name][func_name]()
    else
        --There is no use_start function.
        --This is perfectly normal.
    end
end

--Could be called when the user releases a mouse button, for example.
function p.end_use()
    p.emergency_fix_equipped_item_names()
    local cur_wep = ga_get_i("xar.inv_exec.cur_wep")
    local primary = ga_get_b("xar.inv_exec.primary")

    if( cur_wep >= 0 ) then
        local item_str = p.get_item_str(cur_wep, primary)

        local mod_name = item_str
        local func_name = "use_end"
        if( _G[mod_name] and
            _G[mod_name][func_name] )
        then
            --Calling the use_end function.
            _G[mod_name][func_name]()
        else
            --There is no use_end function.
            --This is perfectly normal.
        end
    end

    ga_set_i("xar.inv_exec.cur_wep", -1)
end

function p.update()
    p.emergency_fix_equipped_item_names()

    --Updates for all equipped items,
    --not just the one being used.
    p.update_background()

    local cur_gun = ga_get_i("xar.inv_exec.cur_wep")
    local primary = ga_get_b("xar.inv_exec.primary")

    if cur_gun == -1 then return end

    local fire_period = p.get_use_period(cur_gun, primary)
    if( ga_get_b("xar.cheat.inf2.enabled") ) then fire_period = 0.01 end --Let the games begin.

    local rapid_fire = p.get_is_rapid_fire(cur_gun, primary)

    local starting_shoot = ga_get_b("xar.inv_exec.starting_shoot")
    local last_fire_time = ga_get_f("xar.inv_exec.last_fire_time")
    local game_time = ga_get_sys_f("game.time.total")

    --Safety (worrying about time travel).
    if( last_fire_time > game_time + 1.0 ) then
        last_fire_time = game_time
        ga_set_f("xar.inv_exec.last_fire_time", last_fire_time)
    end

    if starting_shoot then
        --Trying to make the initial shot.
        if game_time - last_fire_time > fire_period then
            local shot = p.try_shoot(cur_gun, primary, starting_shoot)
            if shot then
                ga_set_b("xar.inv_exec.starting_shoot", false)
                ga_set_f("xar.inv_exec.last_fire_time", game_time) --Not perfect.
            end
        end
    elseif rapid_fire then
        --Tying to perform a rapid fire subsequent shot.
        while true do
            local delta = game_time - last_fire_time
            if delta <= fire_period then break end
            --Can shoot!
            local shot = p.try_shoot(cur_gun, primary, starting_shoot)
            if shot then
                local new_fire_time = last_fire_time + fire_period
                ga_set_f("xar.inv_exec.last_fire_time", new_fire_time)
                last_fire_time = new_fire_time
            else
                return
            end
        end
    end
end

function p.is_starting_use()
    return ga_get_b("xar.inv_exec.starting_shoot")
end

-------------------------------------------------
--              Helper functions
-------------------------------------------------

function p.get_item_var(gun, primary)
    local item_var =
        "xar.player.equipped."
        .. tostring(gun)
        .. "." .. (primary and "primary" or "secondary")
    return item_var
end

function p.get_item_str(gun, primary)
    local item_var = p.get_item_var(gun, primary)
    return ga_get_s(item_var)
end

--Note: item scripts must start with "game_"
function p.set_item_str(gun, primary, new_str)
    local item_var = p.get_item_var(gun, primary)
    return ga_set_s(item_var, new_str)
end

function p.get_use_period(gun, primary)
    local item_str = p.get_item_str(gun, primary)

    local mod_name = item_str
    local func_name = "get_use_period"
    if( _G[mod_name] and
        _G[mod_name][func_name] )
    then
        return _G[mod_name][func_name]()
    else
        ga_print("*** Error: \"get_use_period\" function not found for Lua script: " .. item_str)
        return 1.0 --Uh oh!
    end
end

function p.get_is_rapid_fire(gun, primary)
    local item_str = p.get_item_str(gun, primary)

    --New way.
    local mod_name = item_str
    local func_name = "get_is_rapid_fire"
    if( _G[mod_name] and
        _G[mod_name][func_name] )
    then
        return _G[mod_name][func_name]()
    else
        --This is perfectly normal.
        --Since no "get_is_rapid_fire" function was found,
        --we assume the item is of rapid fire type.
        return true
    end
end

--Returns true iff a "shot" was successful.
function p.try_shoot(cur_gun, primary, starting_shoot)
    if( ga_get_b("xar.cheat.inf2.enabled") ) then
        --Infinifrag 2 Easter egg.
        game_inf2.try_shoot(cur_gun)
        return true
    end

    --New way.
    local item_var =
        "xar.player.equipped."
        .. tostring(cur_gun)
        .. "." .. (primary and "primary" or "secondary")
    local item_str = ga_get_s(item_var)

    --Calling the "use" function of the item Lua script.
    local mod_name = item_str
    local func_name = "use"
    if( _G[mod_name] and
        _G[mod_name][func_name] )
    then
        return _G[mod_name][func_name]()
    else
        ga_print("*** Error: \"use\" function not found for Lua script: " .. item_str)
        return false
    end
end

--This is a little weird.
--We call 20 update functions,
--one for each item (weapon) slot,
--for both the primary and secondary.
function p.update_background()
    for gun = 0,9 do
        for i = 1,2 do
            local primary = true
            if( i == 2 ) then primary = false end
            --
            local item_str = p.get_item_str(gun, primary)
            --
            local mod_name = item_str
            local func_name = "update"
            if( _G[mod_name] and
                _G[mod_name][func_name] )
            then
                --Calling the update function.
                _G[mod_name][func_name]()
            else
                --The item has no update function.
                --This is perfectly normal.
            end
        end
    end
end

-------------------------------------------------
--       Emergency fix equipped item names
-------------------------------------------------
--The more I think about it, the more I think
--all game scripts need to start with the
--"game_" prefix (except "top.lua").

function p.emergency_fix_equipped_item_names()
    for gun = 0,9 do
        for primary_int = 1,2 do
            local primary = (primary_int == 1)
            local old_item_str = p.get_item_str(gun, primary)
            if old_item_str:find('^item_') then
                --Adding the "game_" prefix.
                local new_item_str = "game_" .. old_item_str
                p.set_item_str(gun, primary, new_item_str)
            end
        end
    end
end
