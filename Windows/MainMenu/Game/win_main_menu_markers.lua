function p.__start(wid)
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
    return "MARKERS"
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    local path = ga_get_window_stack_display_names()
    game_win_top_bar.render_path(wid, path)
    ga_win_set_front_color_default(wid)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.85, "TRACKING MARKER")

    ga_win_set_char_size(wid, 0.015, 0.03)

    local marker_exists = game_tracking_marker.exists()
    if( marker_exists ) then
        local enabled = game_tracking_marker.exists_and_enabled()
        if( enabled ) then     
            local dist = game_tracking_marker.get_dist()
            local dist_str = game_str.make_3_digit_big(dist)
            ga_win_txt_center(wid, 0.5, "YOUR TRACKING MARKER IS " .. dist_str .. " BLOCKS AWAY")
            ga_win_txt_center(wid, 0.4, "PRESS N TO TURN OFF YOUR TRACKING MARKER")
        else
            ga_win_txt_center(wid, 0.5, "YOU HAVE A TRACKING MARKER BUT IT IS TURNED OFF")
            ga_win_txt_center(wid, 0.4, "PRESS Y TO TURN ON YOUR TRACKING MARKER")
        end

    else
        ga_win_txt_center(wid, 0.5, "YOU DO NOT HAVE A TRACKING MARKER")
    end
end

function p.__process_input(wid)
    if( ga_win_key_pressed(wid, "N") ) then
        game_tracking_marker.hide()
        ga_window_pop_all()
        return
    end
    if( ga_win_key_pressed(wid, "Y") ) then
        game_tracking_marker.unhide()
        ga_window_pop_all()
        return
    end
    if ga_win_widget_go_back_button_process_input(wid) then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end
end
