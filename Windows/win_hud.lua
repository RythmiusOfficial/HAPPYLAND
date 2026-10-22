-------------------------------------------------
--Table of function references.
-------------------------------------------------

local hud_table_initialized = false
local hud_table = {}

--Brute force ability to change the array:
function p.clear_hud_table() hud_table = {} end
function p.get_hud_table() return hud_table end
function p.set_hud_table(new_hud_table) hud_table = new_hud_table end

--Each function takes one argument: the wid.
--No two hud elements can have the same priority.
--The priority specifies the order it is rendered.
--Lowever priorities are rendered first.
function p.add_element(priority, func, name)
    local element = {}
    element.func = func
    element.name = name
    hud_table[priority] = element
    -- table.insert(hud_table, priority, element) --Wrong.
end

function p.remove_element(priority)
    table.remove(hud_table, priority)
end

-------------------------------------------------
--Initializing the list.
-------------------------------------------------

function p.maybe_init_table()
    if hud_table_initialized then return end
    hud_table_initialized = true

    p.force_init_hud_table()
end

function p.force_init_hud_table()
    p.clear_hud_table()
    p.add_element(-10, blinker_test.render, "blinker test")
    p.add_element(10, game_hud_render_dark_hole_charge.render_dark_hole_charge, "dark hole charge")
    p.add_element(20, game_hud_render_low_health_border.render_low_health_border, "low health border")
    p.add_element(30, game_hud_render_compass.render_compass, "compass")
    p.add_element(40, game_hud_render_dps.render_dps, "dps")
    p.add_element(50, game_hud_render_identified_ment.render_identified_ment, "identified ment")
    p.add_element(60, game_hud_render_hive_attack_meter.render_hive_attack_meter, "hive attack meter")
    p.add_element(70, game_hud_render_shield.render_shield, "shield")
    p.add_element(80, game_hud_render_health.render_health, "health")
    p.add_element(90, game_hud_render_armor.render_armor, "armor")
    p.add_element(100, game_hud_render_gold.render_gold, "gold")
    p.add_element(110, game_hud_render_markers.render_markers, "markers")
    p.add_element(120, game_hud_render_xp_bar.render_xp_bar, "xp bar")
    p.add_element(130, game_hud_render_icons.render_icons, "icons")
    p.add_element(140, game_hud_render_ammo.render_ammo, "ammo")
    p.add_element(150, game_hud_render_lower_left_msg.render_lower_left_msg, "lower left message")
    p.add_element(160, game_hud_render_flash.render_flash, "flash")
end

-------------------------------------------------
--Window functions.
-------------------------------------------------

--Helper.
function p.txt_col(wid, col)
    ga_win_set_front_color(wid, col)
end

function p.interp_col(col1, col2, frac)
    local col = {x=0, y=0, z=0}
    col.x = (1.0 - frac)*col1.x + frac*col2.x
    col.y = (1.0 - frac)*col1.y + frac*col2.y
    col.z = (1.0 - frac)*col1.z + frac*col2.z
    return col
end

function p.__render(wid)
    if( ga_get_b("xar.hud.disable_hud") ) then return end

    if( ga_get_b("xar.cheat.inf2.enabled") ) then
        --Infinifrag2 Easter egg.
        game_inf2.hud_render(wid)
        return
    end

    ga_debug_push("win_hud.__render main")

    p.maybe_init_table()

    ga_debug_line("initialized table")

    --Calling all functions in the table (in order).
    local sorted_keys = {}
    for k,v in pairs(hud_table) do
        table.insert(sorted_keys, k)
    end
    table.sort(sorted_keys)
    for _,k in pairs(sorted_keys) do
        local v = hud_table[k]
        local func = v.func
        local name = v.name
        --
        local debug_frame = "win_hud.__render: " .. name
        ga_debug_push(debug_frame)
        func(wid)
        ga_debug_pop(debug_frame)
    end

    ga_debug_pop("win_hud.__render main")
end
