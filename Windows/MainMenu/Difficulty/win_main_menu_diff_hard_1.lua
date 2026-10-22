function p.__start(wid)
    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Go Back (ESC)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg);
end

function p.__get_path_display_name()
    return "QUAGMIRE"
end

function p.__render(wid)
    local color_black = std.vec(0.0, 0.0, 0.0)
    ga_win_set_background(wid, color_black, 0.95)

    local path = ga_get_window_stack_display_names()
    game_win_top_bar.render_path(wid, path)
    ga_win_set_front_color_default(wid)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.85, "QUAGMIRE MODE")

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.2, "DO IT?")
    ga_win_txt_center(wid, 0.15, "Y / N")

    ga_win_set_front_color(wid, std.vec(1.0, 0.0, 0.0))
    ga_win_txt_center(wid, 0.80, "DAMAGE TO ENEMIES: 100%")
    ga_win_txt_center(wid, 0.75, "DAMAGE FROM ENEMIES: 63%") --
    -- ga_win_txt_center(wid, 0.75, "DAMAGE FROM ENEMIES: 75%") --Not accurate.

    ga_win_quad(wid, 0.35, 0.3, 0.65, 0.7, "icon_hard_1")
end

function p.__process_input(wid)
    if ga_win_key_pressed(wid, "Y") then
        --Actually changing the difficulty.
        game_difficulty.set(1)
        ga_play_sound("harp")
        ga_window_pop_all()
        return
    end
    if( ga_win_widget_go_back_button_process_input(wid) or
        ga_win_key_pressed(wid, "N") )
    then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end
end
