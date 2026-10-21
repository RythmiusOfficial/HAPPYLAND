function p.__on_start(wid)
    --Nothing to do.
end

function p.__on_end(wid)
    --Nothing to do.
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.85, "RESPAWN?")

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.6, "WANT TO RESPAWN TO YOUR RESPAWN POINT?")

    ga_win_txt_center(wid, 0.5, "Y / N")

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.12, "Go Back (ESC)")
end

function p.__process_input(wid)
    if ga_win_key_pressed(wid, "Y") then
        --ga_play_sound("player_death")
        ga_main_menu_pop_all(true)
        ga_kill_player()
        return
    end
    if ga_win_key_pressed(wid, "N") then
        ga_play_sound("menu_back")
        ga_main_menu_pop()
        return
    end
    if ga_win_key_pressed(wid, "ESC") then
        ga_play_sound("menu_back")
        ga_main_menu_pop()
        return
    end
end
