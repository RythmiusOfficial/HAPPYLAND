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
    return "NORMAL"
end

function p.__render(wid)
    local color_block = std.vec(0.0, 0.0, 0.0)
    ga_win_set_background(wid, color_block, 0.95)

    local path = ga_get_window_stack_display_names()
    game_win_top_bar.render_path(wid, path)
    ga_win_set_front_color_default(wid)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.85, "GATEWAY MODE")

    ga_win_set_char_size(wid, 0.015, 0.03)
    ga_win_txt_center(wid, 0.8, "GATEWAY MODE IS HARDER THAN NORMAL MODE. ")
    ga_win_txt_center(wid, 0.75, "IT IS AN INTRODUCTION TO THE HARDER DIFFICULTIES.")
    ga_win_txt_center(wid, 0.70, "DAMAGE TO ENEMIES: 150%")
    ga_win_txt_center(wid, 0.65, "DAMAGE FROM ENEMIES: 49%")
    -- ga_win_txt_center(wid, 0.65, "DAMAGE FROM ENEMIES: 62%") --Not accurate.
    -- ga_win_txt_center(wid, 0.60, "THAT THERE ARE CLUES FOR AFTER THE FINAL BOSS.")
    -- ga_win_txt_center(wid, 0.55, "YOU CAN CHANGE THE DIFFICULTY MODE AT ANY TIME")

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.06, "Go Back (ESC)")

    ga_win_set_front_color(wid, std.vec(1.0, 1.0, 0.0))
    ga_win_set_char_size(wid, 0.015, 0.03)
    ga_win_txt_center(wid, 0.40, "GATEWAY MODE IS A GREAT CHALLENGE")

    ga_win_set_char_size(wid, 0.015, 0.03)
    local cur_diff = game_difficulty.human_readable()
    if( cur_diff == "normal" ) then
        ga_win_set_front_color(wid, std.vec(1.0, 0.0, 0.0))
        ga_win_txt_center(wid, 0.25, "YOU ARE ALREADY IN NORMAL MODE")
    else
        ga_win_txt_center(wid, 0.30, "MAKE THE SWITCH?")
        ga_win_txt_center(wid, 0.25, "Y / N")
    end
end

function p.__process_input(wid)
    local cur_diff = game_difficulty.human_readable()
    if( cur_diff ~= "normal" ) then
        if ga_win_key_pressed(wid, "Y") then
            --Actually changing the difficulty.
            game_difficulty.set(0)
            ga_play_sound("pickup_gold")
            ga_window_pop_all()
            return
        end
        if ga_win_key_pressed(wid, "N") then
            ga_play_sound("menu_back")
            ga_window_pop()
            return
        end
    end
    if( ga_win_widget_go_back_button_process_input(wid) ) then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end
end
