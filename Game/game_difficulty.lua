-------------------------------------------------

--It is intended that you call this function
--from your Input/Scripts/game_startup.lua file.
--This way, when you start a new game,
--it uses the difficulty that you want without you
--having to set it in the package's menu.
function p.set_difficulty_friendly_api(str)
    local func_name = "game_difficulty.set_difficulty_friendly_api"
    ga_print("Setting xar game difficulty from " .. func_name)
    if      str == "tranquility"        then p.set(-2)
    elseif  str == "normal"             then p.set(-1)
    elseif  str == "gateway"            then p.set(0)
    elseif  str == "quagmire"           then p.set(1)
    elseif  str == "agony"              then p.set(2)
    elseif  str == "caustic_utopia"     then p.set(3)
    elseif  str == "madness"            then p.set(4)
    else
        ga_print("*** Error: bad string passed to " .. func_name)
        ga_exit()
    end
end

-------------------------------------------------

--These cannot be modified, because the end game
--steam achievements depend on these.
function p.num_to_human_readable(num)
    if num == -2 then
        return "tranquility"
    elseif num == -1 then
        return "normal"
    elseif num == 0 then
        return "gateway"
    elseif num == 1 then
        return "quagmire"
    elseif num == 2 then
        return "agony"
    elseif num == 3 then
        return "caustic utopia"
    elseif num == 4 then
        return "madness"
    else
        --Should never happen.
        return "normal"
    end
end

function p.num()
    if ga_get_b("xar.difficulty.easy_2") then
        return -2
    elseif ga_get_b("xar.difficulty.easy_1") then
        return -1
    elseif ga_get_b("xar.difficulty.normal") then
        return 0
    elseif ga_get_b("xar.difficulty.hard_1") then
        return 1
    elseif ga_get_b("xar.difficulty.hard_2") then
        return 2
    elseif ga_get_b("xar.difficulty.hard_3") then
        return 3
    elseif ga_get_b("xar.difficulty.hard_4") then
        return 4
    else
        ga_print("*** Error: unknown game difficulty.")
        return 0
    end
end

function p.easiest_num()
    if ga_get_b("xar.difficulty.easy_2_once") then
        return -2
    elseif ga_get_b("xar.difficulty.easy_1_once") then
        return -1
    elseif ga_get_b("xar.difficulty.normal_once") then
        return 0
    elseif ga_get_b("xar.difficulty.hard_1_once") then
        return 1
    elseif ga_get_b("xar.difficulty.hard_2_once") then
        return 2
    elseif ga_get_b("xar.difficulty.hard_3_once") then
        return 3
    elseif ga_get_b("xar.difficulty.hard_4_once") then
        return 4
    else
        ga_print("*** Error: unknown game difficulty.")
        return 0
    end
end

function p.human_readable()
    local num = p.num()
    local str = p.num_to_human_readable(num)
    local curved = ga_get_b("xar.difficulty.curve.enabled")
    if( curved ) then str = str .. " (curved)"
    else str = str .. " (uncurved)" end
    return str
end

function p.human_readable2()
    local num = p.num()
    return p.num_to_human_readable(num)
end

function p.easiest_human_readable()
    local num = p.easiest_num()
    local str = p.num_to_human_readable(num)
    local curved = ga_get_b("xar.difficulty.curve.enabled")
    if( curved ) then str = str .. " (curved)"
    else str = str .. " (uncurved)" end
    return str
end

function p.num_to_var(num)
    if( num == -2 ) then return "xar.difficulty.easy_2"
    elseif( num == -1 ) then return "xar.difficulty.easy_1"
    elseif( num == 0 ) then return "xar.difficulty.normal"
    elseif( num == 1 ) then return "xar.difficulty.hard_1"
    elseif( num == 2 ) then return "xar.difficulty.hard_2"
    elseif( num == 3 ) then return "xar.difficulty.hard_3"
    elseif( num == 4 ) then return "xar.difficulty.hard_4"
    end
end

function p.set_none()
    for i = -2,4 do
        local var = p.num_to_var(i)
        ga_set_b(var, false)
    end
end

--Setting the game difficulty.
function p.set(new_num)
    ga_print("\n\n\n")

    local old_num = p.num()

    --Just to be safe.
    p.set_none()

    local locked_in = ga_get_b("xar.difficulty.locked_in")
    
    ga_print("game_difficulty.set " .. tostring(new_num))

    --Erasing old difficulty.
    local old_var = p.num_to_var(old_num)
    ga_print("old_var = " .. old_var)
    ga_set_b(old_var, false)
    --Maybe erasing the "once" footprint.
    if( not locked_in ) then
        local old_once_var = old_var .. "_once"
        ga_print("Erasing old var: " .. old_once_var)
        ga_set_b(old_once_var, false)
    end
    --
    --Setting new difficulty.
    local new_var = p.num_to_var(new_num)
    ga_set_b(new_var, true)
    --Setting new once footprint.
    ga_set_b(new_var .. "_once", true)
    --
    ga_print("game_difficulty.set(" .. tostring(new_num) .. ")")
    ga_print("new_var = " .. new_var)
end

function p.set_custom()
    p.set(-1)
    ga_set_b("xar.difficulty.easy_1", false)
    ga_set_b("xar.difficulty.custom", true)
end

function p.icon(num)
    if( num < 0 ) then return "icon_easy_" .. tostring(-num) end
    if( num == 0 ) then return "icon_normal" end
    if( num > 0 ) then return "icon_hard_" .. tostring(num) end
end

function p.icon_once(num)
    if( num == 0 ) then return "icon_normal_once"
    else return p.icon(num) .. "_once"
    end
end

function p.is_hardcore()
    return ga_get_hardcore_mode()
end
