function p.__start(wid)
    local min_y = 0.15
    local max_y = 0.7
    local char_w = 0.03
    local char_h = 0.06
    local col = {x=0.0, y=0.5, z=0.5}
    local options = {
        "TRANQUILITY MODE (EASY)",
        "NORMAL MODE",
        -- "NORMAL MODE",
        "HARDER MODE",
        "HARDCORE MODIFIER"}
        -- "CURVING"}
    ga_win_widget_small_list_start(
        wid, min_y, max_y, char_w, char_h,
        col, options)

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
    return "DIFFICULTY"
end

function p.__process_input(wid)
    local selection = ga_win_widget_small_list_process_input(wid)
    if( selection == 0 ) then
        ga_window_push("win_main_menu_diff_easy_2")
        return
    end
    if( selection == 1 ) then
        ga_window_push("win_main_menu_diff_easy_1")
        return
    end
    -- if( selection == 2 ) then
    --     ga_window_push("win_main_menu_diff_normal")
    --     return
    -- end
    if( selection == 2 ) then
        ga_window_push("win_main_menu_diff_hard")
        return
    end
    if( selection == 3 ) then
        ga_window_push("win_main_menu_diff_hardcore")
        return
    end
    -- if( selection == 4 ) then
    --     ga_window_push("win_main_menu_diff_curving")
    --     return
    -- end

    if ga_win_widget_go_back_button_process_input(wid) then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end
end

function p.__render(wid)
    local color_black = std.vec(0.0, 0.0, 0.0)
    ga_win_set_background(wid, color_black, 0.95)

    local path = ga_get_window_stack_display_names()
    game_win_top_bar.render_path(wid, path)
    ga_win_set_front_color_default(wid)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.85, "SELECT A DIFFICULTY LEVEL")

    local cur_diff = game_difficulty.human_readable()
    local cur_diff_caps = string.upper(cur_diff)
    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_set_front_color(wid, std.vec(0.0, 1.0, 0.0))
    ga_win_txt_center(wid, 0.80, "YOUR CURRENT DIFFICULTY: " .. cur_diff_caps)
end
