function p.__start(wid)
    --Nothing to do.
end

function p.__end(wid)
    --Nothing to do.
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_set_front_color(wid, std.vec(1.0, 0.0, 0.0))
    ga_win_txt_center(wid, 0.60, "YOU CANNOT RESPAWN")
    ga_win_txt_center(wid, 0.50, "KEEPING ALL YOUR AMMO")
    ga_win_txt_center(wid, 0.40, "WHILE IN AN ARCADE")

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_set_front_color_default(wid)
    ga_win_txt_center(wid, 0.06, "Go Back (ESC)")
end

function p.__process_input(wid)
    if ga_win_key_pressed(wid, "ESC") then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end
end
