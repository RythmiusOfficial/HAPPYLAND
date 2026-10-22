function p.__start(wid)
    --Nothing to do.
end

function p.__end(wid)
    --Nothing to do.
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.85, "DIFFICULTY CURVING")

    ga_win_set_char_size(wid, 0.015, 0.03)
    ga_win_txt_center(wid, 0.8, "CURVING ENLARGES THE GOLDILOCK REGION OF THE WORLD")
    ga_win_txt_center(wid, 0.75, "(THE AREA THAT IS NOT TOO EASY AND NOT TOO HARD)")
    ga_win_txt_center(wid, 0.65, "IT SLOWS DOWN THE STRENGTH GROWTH RATE")
    ga_win_txt_center(wid, 0.60, "OF BOTH THE PLAYER AND MONSTERS")

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.06, "Go Back (ESC)")

    local curved = ga_get_b("xar.difficulty.curve.enabled")
    ga_win_set_front_color(wid, std.vec(1.0, 1.0, 0.0))
    ga_win_set_char_size(wid, 0.015, 0.03)
    if( curved ) then
        ga_win_txt_center(wid, 0.50, "CURVING IS ALREADY ENABLED")
        ga_win_txt_center(wid, 0.45, "PRESS N TO DISABLE CURVING")
    else
        ga_win_txt_center(wid, 0.50, "CURVING IS DISABLED")
        ga_win_txt_center(wid, 0.45, "PRESS Y TO ENABLE CURVING")
    end
end

function p.__process_input(wid)
    local curved = ga_get_b("xar.difficulty.curve.enabled")
    if( ga_win_key_pressed(wid, "Y") and not curved ) then
        ga_set_b("xar.difficulty.curve.enabled", true)
        ga_play_sound_menu("cheater")
        ga_window_pop_all()
        return
    end
    if( ga_win_key_pressed(wid, "N") and curved ) then
        ga_set_b("xar.difficulty.curve.enabled", false)
        ga_play_sound_menu("cheater")
        ga_window_pop_all()
        return
    end
    if ga_win_key_pressed(wid, "ESC") then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end
end
