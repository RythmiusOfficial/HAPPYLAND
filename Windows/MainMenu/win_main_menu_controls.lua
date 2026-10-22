function p.__start(wid)
    local go_back_button_y = 0.02
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
    return "CONTROLS"
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    local path = ga_get_window_stack_display_names()
    game_win_top_bar.render_path(wid, path)
    ga_win_set_front_color_default(wid)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.90, "DEFAULT CONTROLS")

    ga_win_set_char_size(wid, 0.01, 0.02)
    -- ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.85, "TO CHANGE THE CONTROLS, GO TO")
    ga_win_txt_center(wid, 0.82, "MAIN MENU -> OPTIONS -> CONTROLS")
    ga_win_txt_center(wid, 0.79, "-> INPUT BINDINGS -> CONTROLS")

    ga_win_quad(wid, 0.25, 0.1, 0.75, 0.75, "picture_tut_controls")
end

function p.__process_input(wid)
    if ga_win_widget_go_back_button_process_input(wid) then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end
end
