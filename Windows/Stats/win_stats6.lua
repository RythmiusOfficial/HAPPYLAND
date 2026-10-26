function p.__start(wid)
    local go_back_button_y = 0.02
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Return To Game (ESC)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg)

    game_win_top_bar.create_stats_buttons(wid, 6)
    p.create_tab_buttons(wid)
end

p.num_pages = 1

function p.create_tab_buttons(wid)
    local num_buttons = p.num_pages
    local delta_x = 1.0 / num_buttons
    local x = 0.0
    local y = 0.94
    local w = 0.0075
    local h = 0.02
    ga_win_widget_button_start(wid, 101, x, y, w, h, "HAPPY")

    for i = 1,num_buttons do
        local center_x = (i - 1 + 0.5) * delta_x
        ga_win_widget_button_center_x_at(wid, 100 + i, center_x)
        ga_win_widget_button_set_color(wid, 100 + i, std.vec(0.0, 1.0, 1.0))
    end
end

function p.draw_trophy(wid, grid, row, col, name)
    have_trophy = ga_get_b("game.trophy." .. name)
    debug = false
    --debug = true --DEBUGGING!!!
    if have_trophy or debug then
        tex_name = "trophy_" .. name
    else
        tex_name = "trophy_do_not_have"
    end
    --
    big_width = grid.max_x - grid.min_x
    big_height = grid.max_y - grid.min_y
    delta_x = big_width / (grid.num_x - 1)
    delta_y = big_height / (grid.num_y - 1)
    x = grid.min_x + (delta_x * col)
    y = grid.max_y - (delta_y * row)
    quad_min_x = x - (grid.trophy_width / 2)
    quad_max_x = x + (grid.trophy_width / 2)
    quad_min_y = y - (grid.trophy_height / 2)
    quad_max_y = y + (grid.trophy_height / 2)
    ga_win_quad(
        wid, 
        quad_min_x,
        quad_min_y,
        quad_max_x,
        quad_max_y,
        tex_name);
end

function p.__render(wid)
    ga_init_i("temp.xar.stats5.win_num", 1)

    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    game_win_top_bar.create_stats_buttons_bot_line(wid)
    
    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.88, "TROPHIES")

    ga_win_set_char_size(wid, 0.01, 0.02)
    ga_win_txt_center(wid, 0.84, "USE LEFT / RIGHT ARROWS")

    ga_win_set_char_size(wid, 0.02, 0.04)

    type_y = 0.76

    grid = {
        min_x = 0.25,
        max_x = 0.75,
        num_x = 4,
        min_y = 0.16,
        max_y = 0.66,
        num_y = 4,
        trophy_width = 0.13,
        trophy_height = 0.16}

    win_num = ga_get_i("temp.xar.stats5.win_num")
    if win_num == 1 then
        ga_win_txt_center(wid, type_y, "HAPPY LAND TROPHIES")
        p.draw_trophy(wid, grid, 0,0, "treasure_flower_orange")
        p.draw_trophy(wid, grid, 0,1, "platters")
    end
end

function p.__process_input(wid)
    if ga_win_widget_go_back_button_process_input(wid) then
        ga_window_pop()
        return
    end

    local click_sel = game_win_top_bar.buttons_process_input_helper(wid)

    if( click_sel == "TOP" or
        ga_win_key_pressed(wid, "F1") )
    then
        --Opening the xar menu.
        ga_window_pop()
        ga_window_push("main_menu")
        return
    end
    if( click_sel == "UPGRADES" or
        ga_win_key_pressed(wid, "F2") )
    then
        ga_window_pop()
        ga_window_push("win_stats2")
        return
    end
    if( click_sel == "WEP STATS" or
        ga_win_key_pressed(wid, "F3") )
    then
        ga_window_pop()
        ga_window_push("win_stats3")
        return
    end
    if( click_sel == "LEVEL UP" or
        ga_win_key_pressed(wid, "F4") )
    then
        ga_window_pop()
        ga_window_push("win_stats4")
        return
    end
    if( click_sel == "DIFF" or
        ga_win_key_pressed(wid, "F5") )
    then
        ga_window_pop()
        ga_window_push("win_stats5")
        return
    end
    -- if( click_sel == "TROPHIES" or
    --     ga_win_key_pressed(wid, "F6") )
    -- then
    --     ga_window_pop()
    --     ga_window_push("win_stats6")
    --     return
    -- end
    if( click_sel == "WEP MODES" or
        ga_win_key_pressed(wid, "F7") )
    then
        ga_window_pop()
        ga_window_push("win_stats7")
        return
    end

    num = ga_get_i("temp.xar.stats5.win_num")
    if click_sel == "HAPPY"        then num = 1 end
    if ( ( ga_win_mouse_wheel_down(wid) or ga_win_key_pressed(wid, "LEFT")  ) and num > 1 ) then num = num - 1 end
    if ( ( ga_win_mouse_wheel_up(wid)   or ga_win_key_pressed(wid, "RIGHT") ) and num < p.num_pages ) then num = num + 1 end
    ga_set_i("temp.xar.stats5.win_num", num)

    --Setting the tab colors correctly.
    color_green = std.vec(0.0, 1.0, 0.0)
    color_cyan = std.vec(0.0, 1.0, 1.0)
    for i = 1,p.num_pages do
        local color = color_cyan
        if( i == num ) then color = color_green end
        ga_win_widget_button_set_color(wid, 100+i, color)
    end
end
