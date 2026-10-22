function p.__start(wid)
    p.make_list(wid)

    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Return To Game (ESC or F)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg)
end

--Helper function.
function p.make_list(wid)
    local min_y = 0.4
    local max_y = 0.55
    local char_w = 0.015
    local char_h = 0.03
    local col = {x=0.0, y=0.5, z=0.5}
    local options = {
        "PRESS 1 TO SET DIFFICULTY TO TRANQUILITY MODE (EASY)",
        "PRESS 2 TO SET DIFFICULTY TO NORMAL MODE"}
    ga_win_widget_small_list_start(
        wid, min_y, max_y, char_w, char_h,
        col, options)
    ga_win_widget_small_list_set_use_nums(wid, false)
end

function p.__render(wid)
    ga_win_set_background_default(wid)
    
    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.9, "CHANGE GAME DIFFICULTY")

    ga_win_set_char_size(wid, 0.015, 0.03)
    ga_win_txt_center(wid, 0.85, "REMINDER: YOU CAN ALSO CHANGE THE DIFFICULTY BY GOING TO")
    ga_win_txt_center(wid, 0.80, "MAIN MENU -> OPTIONS -> PACKAGE TOP MENU -> DIFFICULTY")

    local diff_num = game_difficulty.num()
    local cur_diff = game_difficulty.num_to_human_readable(diff_num)
    local cur_diff_str = "CURRENT DIFFICULTY: " .. cur_diff
    ga_win_txt_center(wid, 0.70, cur_diff_str)

    ga_win_txt_center(wid, 0.20, "PRESSING F5 WHILE IN GAME SHOWS DIFFICULTY AND PLAY TIME")
end

function p.__process_input(wid)
    if( ga_win_widget_go_back_button_process_input(wid) or
        ga_win_key_pressed(wid, "F") )
    then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end

    local selection = ga_win_widget_small_list_process_input(wid)
    local sel_name = ga_win_widget_small_list_get_entry(wid, selection)
    --
    if string.match(sel_name, "PRESS 1") or
        ga_win_key_pressed(wid, "1") then sel_str = "1" end
    if string.match(sel_name, "PRESS 2") or
        ga_win_key_pressed(wid, "2") then sel_str = "2" end
    -- if string.match(sel_name, "PRESS 3") or
        -- ga_win_key_pressed(wid, "3") then sel_str = "3" end

    local cur_diff = game_difficulty.num()
    if ( sel_str == "1" and cur_diff ~= -2 ) then
        --Actually changing the difficulty.
        game_difficulty.set(-2)
        ga_play_sound("pickup_gold")
        ga_window_pop()
    end
    if ( sel_str == "2" and cur_diff ~= -1 ) then
        --Actually changing the difficulty.
        game_difficulty.set(-1)
        ga_play_sound("pickup_gold")
        ga_window_pop()
    end
end
