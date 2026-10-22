-------------------------------------------------
--           Customizable options list
--          This can be used by modders
-------------------------------------------------

local op_widget_min_y = 0.15
local op_widget_max_y = 0.75
local op_widget_char_w = 0.03
local op_widget_char_h = 0.06
local op_widget_col = {x=0.0, y=0.5, z=0.5}
function p.set_op_widget_min_y(value) op_widget_min_y = value end
function p.set_op_widget_max_y(value) op_widget_max_y = value end
function p.set_op_widget_char_w(value) op_widget_char_w = value end
function p.set_op_widget_char_h(value) op_widget_char_h = value end
function p.set_op_widget_col(value) op_widget_col = value end

--The option array consists of "option tables".
--Each option table has the following members:
-- 1) name        (the name of the option, but maybe not what is displayed).
-- 2) select_func (reference to the function called when the option is selected).
-- 3) value_str   (what is displayed for the option if value_func is nil).
-- 4) value_func  (if this is not nil, this function returns the string that is displayed).

local op_array = {}

function p.push_option(new_op)
    table.insert(op_array, #op_array+1, new_op)
end

function push_after_option(name, new_op)
    for index, opt in ipairs(op_array) do
        if name:find(opt.name) then
            table.insert(op_array, index+1, new_op)
--          Note: you push "before" if you do not add the +1 to the index.
            return
        end
    end
end

--Brute force ability to change the array:
function p.clear_op_array() op_array = {} end
function p.get_op_array() return op_array end
function p.set_op_array(new_op_array) op_array = new_op_array end

--Debugging.
function p.dump_op_array()
    ga_print("Dumping options array (plumpie): ")
    for _,op in ipairs(op_array) do
        ga_print(" * " .. op.name)
    end
end

-------------------------------------------------
--Initializing the initial op_array locally.
-------------------------------------------------

local op_array_initialized = false

function p.maybe_init_op_array()
    if op_array_initialized then return end
    op_array_initialized = true

    p.force_init_op_array()
end

--Helper function.
--This cannot be used from the outside.
function p.add_op_typical(title, value_func, select_func)
    local op = {}
    op.name = title
    op.select_func = select_func
    op.value_str = ""
    op.value_func = value_func
    p.push_option(op)
end

function p.force_init_op_array()
    p.clear_op_array()
    p.add_op_typical("SHOW HEALTH",     p.value_func_show_health,       p.select_func_show_health)
    p.add_op_typical("SHOW AMMO",       p.value_func_show_ammo,         p.select_func_show_ammo)
    p.add_op_typical("SHOW MARKERS",    p.value_func_show_markers,      p.select_func_show_markers)
    p.add_op_typical("SHOW GOLD",       p.value_func_show_gold,         p.select_func_show_gold)
    p.add_op_typical("SHOW EXPERIENCE", p.value_func_show_experience,   p.select_func_show_experience)
    p.add_op_typical("SHOW ICONS",      p.value_func_show_icons,        p.select_func_show_icons)
end

function p.bool_to_yes_no(x)
    if x then return "YES"
    else return "NO"
    end
end

-------------------------------------------------
-- Creating the small slection list widget
-------------------------------------------------

function p.create_options_widget(wid)
    p.maybe_init_op_array()
    --
    local options = {}
    for _,op in ipairs(op_array) do
        -- ga_print("adding option: " .. op.name)
        local value = op.value_str
        if op.value_func ~= nil then
            value = op.value_func()
        end
        options[#options+1] = value
    end
    ga_win_widget_small_list_start(
        wid,
        op_widget_min_y, op_widget_max_y,
        op_widget_char_w, op_widget_char_h,
        op_widget_col,
        options)
end

-------------------------------------------------
-- Individual functions.
-------------------------------------------------

function p.value_func_show_health()
    local bool = ga_get_b("xar.hud.show_health")
    return "SHOW HEALTH: " .. p.bool_to_yes_no(bool)
end

function p.value_func_show_ammo()
    local bool = ga_get_b("xar.hud.show_ammo")
    return "SHOW AMMO: " .. p.bool_to_yes_no(bool)
end

function p.value_func_show_markers()
    local bool = ga_get_b("xar.hud.show_markers")
    return "SHOW MARKERS: " .. p.bool_to_yes_no(bool)
end

function p.value_func_show_gold()
    local bool = ga_get_b("xar.hud.show_gold")
    return "SHOW GOLD: " .. p.bool_to_yes_no(bool)
end

function p.value_func_show_experience()
    local bool = ga_get_b("xar.hud.show_experience")
    return "SHOW EXPERIENCE: " .. p.bool_to_yes_no(bool)
end

function p.value_func_show_icons()
    local bool = ga_get_b("xar.hud.show_icons")
    return "SHOW ICONS: " .. p.bool_to_yes_no(bool)
end

-------------------------------------------------

function p.select_func_show_health()
    ga_toggle_b("xar.hud.show_health")
end

function p.select_func_show_ammo()
    ga_toggle_b("xar.hud.show_ammo")
end

function p.select_func_show_markers()
    ga_toggle_b("xar.hud.show_markers")
end

function p.select_func_show_gold()
    ga_toggle_b("xar.hud.show_gold")
end

function p.select_func_show_experience()
    ga_toggle_b("xar.hud.show_experience")
end

function p.select_func_show_icons()
    ga_toggle_b("xar.hud.show_icons")
end

-------------------------------------------------
-- Window functions.
-------------------------------------------------

function p.__start(wid)
    p.maybe_init_op_array()
    p.create_options_widget(wid)

    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Go Back (ESC)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg);
end

function p.__end(wid)
    --Nothing to do.
end

function p.__get_path_display_name()
    return "HUD"
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    local path = ga_get_window_stack_display_names()
    game_win_top_bar.render_path(wid, path)
    ga_win_set_front_color_default(wid)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.85, "HUD")
end

function p.__process_input(wid)
    if ga_win_widget_go_back_button_process_input(wid) then
        ga_play_sound("menu_back")
        ga_window_pop()
    end

    --New way.
    local sel = ga_win_widget_small_list_process_input(wid) --0 indexed.
    local sel_str = ga_win_widget_small_list_get_entry(wid, sel)
    if( sel_str ~= "" ) then
        local op = op_array[sel+1]
        if op == nil then return end --Uh oh!
        local func = op.select_func
        if func == nil then return end --Uh oh!
        --Calling the function.
        func()
        p.create_options_widget(wid) --In case the values changed.
        return
    end
end
