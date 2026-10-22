function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 1.0)

    ga_win_set_char_size(wid, 0.015, 0.03)

    local txt =
           "This is a \"^x00ff00bookmark^!\". "
        .. "If you right click on this bookmark, "
        .. "the following will happen:\n\n"
        .. "1) This will be set as your ^x00ff00current bookmark^!.\n"
        .. "2) You will be teleported to your ^x00ff00current respawn point^!.\n"
        .. "3) Then if you right click on ^x00ff00ANY respawn point^!, "
        .. "you will be teleported back to your current bookmark (here).\n"
        .. "4) You will no longer have a current bookmark.\n"
    local show_go_back_msg = true
    ga_win_txt_box(wid, txt, show_go_back_msg)
end

function p.__process_input(wid)
    if( ga_win_key_pressed(wid, "ESC") or
        ga_win_key_pressed(wid, "F") )
    then
        ga_play_sound("menu_back")
        ga_window_pop()
    end
end
