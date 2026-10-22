function p.__on_start(wid)
    local go_back_button_y = 0.02
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Return To Game (ESC)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg)

    game_win_top_bar.create_stats_buttons(wid, 6)
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)
    ga_win_txt_center(wid,0.5,"NO TROPHIES... YET!")
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
        ga_main_menu_push("main_menu")
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
end
