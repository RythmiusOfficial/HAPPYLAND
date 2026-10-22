-------------------------------------------------
--           Customizable options list
--          This can be used by modders
-------------------------------------------------

--So can customize the layout.
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
local add_op_simple = function (name, func)
    local op = {}
    op.name = name
    op.select_func = func
    op.value_str = name
    p.push_option(op)
end

local debug_add_blink_option = function()
    local new_op = {}
    new_op.name = "BLINK TEST"
    new_op.value_str = "will not see"
    new_op.value_func = p.blink_test_value
    push_after_option("RESAPWN", new_op)
end

local debug_add_large_list_test = function()
    local new_op = {}
    new_op.name = "LONG LIST TEST"
    new_op.select_func = p.select_large_list_test
    new_op.value_str = "LONG LIST TEST"
    p.push_option(new_op)
end

function p.force_init_op_array()
    p.clear_op_array()
    add_op_simple("CONTROLS", p.select_controls)
    add_op_simple("RESPAWN", p.select_respawn)
    if not game_genesis.enabled() then
        add_op_simple("DIFFICULTY", p.select_difficulty)
    end
    add_op_simple("GRAPHICS + SOUND", p.select_video_and_sound)
    add_op_simple("GAME", p.select_game)
    --
    --Debugging:
    -- debug_add_blink_option()
    --
    --Debugging:
    -- debug_add_large_list_test()
    --
    -- p.dump_op_array()
end

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
--              Select functions
-------------------------------------------------
--This cannot be local for some reason.

function p.select_controls()
    ga_window_push("win_main_menu_controls")
end

function p.select_respawn()
    ga_window_push("win_main_menu_respawn")
end

function p.select_difficulty()
    ga_window_push("win_main_menu_diff")
end

function p.select_video_and_sound()
    ga_window_push("win_main_menu_video_sound")
end

function p.select_game()
    ga_window_push("win_main_menu_game")
end

--Debugging.
function p.blink_test_value()
    local time = ga_get_sys_f("time.current")
    local time2 = math.floor(time)
    -- local time2 = math.floor(time * 0.5)
    if( time2 % 2 == 0 ) then
        return "BLINK: RED"
    else
        return "BLINK: GREEN"
    end
end

--Debugging
function p.select_large_list_test()
    ga_window_push("win_large_list_test")
end

-------------------------------------------------

function p.__start(wid)
    --Now way.
    p.maybe_init_op_array()

    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    -- local go_back_msg = "Return To Game (ESC)" --Needs to be more complex!
    local go_back_msg = "Go Back (ESC)" --NEED TO CHANGE!!!
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg);

    --Needs to be more complex.
    --Sometimes we can switch to other stats windows,
    --but other times not.
    game_win_top_bar.create_stats_buttons(wid, 1)
end

function p.__end(wid)
    --Nothing to do.
end

function p.__get_path_display_name()
    return "TOP"
end

local last_in_main = true

function p.refresh_buttons(wid)
    local cur_in_main = ga_get_sys_b("menu.in_main")
    if( cur_in_main == last_in_main ) then return end
    last_in_main = cur_in_main

    --Brute force.
    if( cur_in_main ) then
        game_win_top_bar.remove_stats_buttons(wid)
    else
        game_win_top_bar.create_stats_buttons(wid, 1)
    end
end

function p.__render(wid)
    p.refresh_buttons(wid)

    --Trying to call this each time.
    --Not sure what will happen.
    p.create_options_widget(wid)

    local color_black = std.vec(0.0, 0.0, 0.0)
    ga_win_set_background(wid, color_black, 0.95)

    ga_win_set_char_size(wid, 0.04, 0.08)
    ga_win_txt_center(wid, 0.85, "XAR MAIN MENU")
end

function p.__process_input(wid)
    --New way.
    local sel = ga_win_widget_small_list_process_input(wid) --0 indexed.
    local sel_str = ga_win_widget_small_list_get_entry(wid, sel)
    if( sel_str ~= "" ) then
        -- ga_print("Boggie")
        -- ga_print("sel = " .. tostring(sel))
        local op = op_array[sel+1]
        if op == nil then return end --Uh oh!
        -- ga_print("The option exists!")
        local func = op.select_func
        if func == nil then return end --Uh oh!
        --Calling the function.
        -- ga_print("Found a select function!")
        func()
        return
    end

    if( ga_win_key_pressed(wid, "ESC") or
        ga_win_widget_go_back_button_process_input(wid) )
    then
        ga_window_pop_all()
        return
    end

    p.refresh_buttons(wid)

    if( not ga_get_sys_b("menu.in_main") ) then
        local click_sel = game_win_top_bar.buttons_process_input_helper(wid)

        --Maybe going to another game window.
        if( click_sel == "UPGRADES" or
            ga_win_key_pressed(wid, "F2") )
        then
            ga_window_pop_all()
            ga_window_push("win_stats2")
            return
        end
        if( click_sel == "WEP STATS" or
            ga_win_key_pressed(wid, "F3") )
        then
            ga_window_pop_all()
            ga_window_push("win_stats3")
            return
        end
        if( click_sel == "LEVEL UP" or
            ga_win_key_pressed(wid, "F4") )
        then
            ga_window_pop_all()
            ga_window_push("win_stats4")
            return
        end
        if( click_sel == "DIFF" or
            ga_win_key_pressed(wid, "F5") )
        then
            ga_window_pop_all()
            ga_window_push("win_stats5")
            return
        end
        if( click_sel == "TROPHIES" or
            ga_win_key_pressed(wid, "F6") )
        then
            ga_window_pop_all()
            ga_window_push("win_stats6")
            return
        end
        if( click_sel == "WEP MODES" or
            ga_win_key_pressed(wid, "F7") )
        then
            ga_window_pop_all()
            ga_window_push("win_stats7")
            return
        end
    end
end
