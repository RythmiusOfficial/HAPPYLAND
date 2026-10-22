function p.__start(wid)
    local min_y = 0.3
    ga_win_widget_text_input_start(wid, min_y, 0.02, 0.04)

    --Only allowing certain chars,
    --that way it is not confusing.
    ga_win_widget_text_input_forbid_all_chars(wid)
    local a_num = string.byte("a")
    local z_num = string.byte("z")
    for char_num = a_num,z_num do
        local char_str = string.char(char_num)
        ga_win_widget_text_input_set_char_allowed(wid, char_str, true)
    end
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 1.0)

    ga_win_set_char_size(wid, 0.015, 0.03)
    local col_red = std.vec(1.0, 0.0, 0.0)
    ga_win_set_front_color(wid, col_red)

    ga_win_txt_center(wid, 0.9, "YOU ALREADY HAVE A CURRENT BOOKMARK")

    ga_win_set_front_color_default(wid)
    ga_win_txt_center(wid, 0.7, "TYPE \"back\" TO TELEPORT TO YOUR CURRENT BOOKMARK")

    ga_win_set_front_color(wid, col_red)
    ga_win_txt_center(wid, 0.5, "ON THE OTHER HAND, IF YOU WANT TO LOSE YOUR CURRENT BOOKMARK,")
    ga_win_txt_center(wid, 0.45, "TYPE \"iwanttolosemycurrentbookmark\"")

    --The text input widget will be rendered.

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_set_front_color_default(wid)
    ga_win_txt_center(wid, 0.06, "Cancel (ESC)")
end

function p.__process_input(wid)
    if( ga_win_key_pressed(wid, "ESC") ) then
        ga_play_sound("menu_back")
        ga_window_pop()
    end

    local entered_str = ga_win_widget_text_input_process_input(wid)
    if( entered_str == "" ) then
        --They did not enter anything yet.
    elseif( entered_str == "back" ) then
        --Teleporting to the current bookmark.
        ga_window_pop()
        game_bookmark_tele.start_tele_from_respawn_point()
    elseif( entered_str == "iwanttolosemycurrentbookmark" ) then
        --Turning off the current bookmark.
        game_bookmark_tele.set_bookmark_off()
        ga_play_sound("explosion_tube_long")
        ga_window_pop()
    else
        ga_play_sound("error")
    end
end
