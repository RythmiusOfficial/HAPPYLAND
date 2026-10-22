function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    --ga_win_set_char_size(wid, 0.03, 0.06)
    --ga_win_txt_center(wid, 0.85, "BABY MODE")

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.06, "Go Back (ESC)")

    ga_win_set_front_color(wid, std.vec(1.0, 0.0, 0.0))
    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.5, "YOU CANNOT SWITCH TO NORMAL MODE")
    ga_win_txt_center(wid, 0.45, "FROM A HARD DIFFICULTY")
end

function p.__process_input(wid)
    if ga_win_key_pressed(wid, "ESC") then
        ga_window_pop()
    end
end
