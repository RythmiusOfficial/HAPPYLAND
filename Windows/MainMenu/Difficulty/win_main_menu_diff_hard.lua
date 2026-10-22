function p.__start(wid)
    ga_win_widget_text_input_start(wid, 0.5, 0.02, 0.04)

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
    return "HARD"
end

--Helper.
function p.can_use_harder()
    return true
    -- return (ga_get_game_time() < 5 * 60)
end

function p.__render(wid)
    local color_black = std.vec(0.0, 0.0, 0.0)
    ga_win_set_background(wid, color_black, 0.95)

    local path = ga_get_window_stack_display_names()
    game_win_top_bar.render_path(wid, path)
    ga_win_set_front_color_default(wid)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.85, "HARDER MODE PASSWORD")

    if p.can_use_harder() then
        --Nothing to do.
    else
        ga_win_set_front_color(wid, std.vec(1.0, 0.0, 0.0))
        ga_win_txt_center(wid, 0.55, "CANNOT USE HARDER DIFFICULTY")
        ga_win_txt_center(wid, 0.45, "AFTER 5 MINUTES OF GAMEPLAY")
    end
end

function p.__process_input(wid)
    if( p.can_use_harder() ) then
        cur_txt = ga_win_widget_text_input_process_input(wid)
        if cur_txt == "icandoit" then
            ga_play_sound("harp")
            ga_window_push("win_main_menu_diff_normal")
            return
        end
        if cur_txt == "elfenlied" then
            ga_play_sound("harp")
            ga_window_push("win_main_menu_diff_hard_1")
            return
        end
        if cur_txt == "supersolenoid" then
            ga_play_sound("harp")
            ga_window_push("win_main_menu_diff_hard_2")
            return
        end
        if cur_txt == "wings" then
            ga_play_sound("harp")
            ga_window_push("win_main_menu_diff_hard_3")
            return
        end
        if cur_txt == "thespicemustflow" then
            ga_play_sound("harp")
            ga_window_push("win_main_menu_diff_hard_4")
            return
        end
        if cur_txt == "custom" then
            ga_play_sound("harp")
            game_difficulty.set_custom()
            return
        end
        if cur_txt == "peace" then
            ga_set_b("xar.difficulty.trying_to_be_pacifist", true)
            ga_play_sound("harp")
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
