--File: win_start_pos_failed.lua

function p.__render(wid)
    --Forcing it over and over again.
    --Could just call this when we open the window.
    --This is a hud window, but we don't want to show anything
    --else on the hud, such as the system hud.
    ga_set_sys_b("game.window.hud.hide_system_hud", true)

    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 1.0)

    ga_win_set_front_color(wid, std.vec(1.0, 0.0, 0.0))
    
    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.65, "THE PLAYER WAS NOT CORRECTLY")
    ga_win_txt_center(wid, 0.6, "PLACED IN THE WORLD")
    --
    ga_win_txt_center(wid, 0.5, "YOU MUST \"REBOOT\" THIS GAME")
    ga_win_txt_center(wid, 0.45, "BY GOING TO")
    ga_win_txt_center(wid, 0.35, "OPTIONS")
    ga_win_txt_center(wid, 0.3, "-> GAME LOADING/SAVING")
    ga_win_txt_center(wid, 0.25, "-> REBOOT PLAYER")
end

function p.__process_input(wid)
    --Cannot close this window.
end
