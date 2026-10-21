function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 1.0)

    ga_win_set_front_color(wid, std.vec(1.0, 0.0, 0.0))
    
    ga_win_set_char_size(wid, 0.04, 0.08)
    ga_win_txt_center(wid, 0.5, "YOU ARE DEAD")

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.12, "PRESS ENTER TO RESPAWN")
end

function p.__process_input(wid)
    if( ga_win_key_pressed(wid, "ENTER") )
    then
        ga_command("respawn force")
        ga_hud_window_remove("blank_win_death")
        return
    end
end
