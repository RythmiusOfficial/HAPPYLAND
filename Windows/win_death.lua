function p.__render(wid)
    --Forcing it over and over again.
    --Could just call this when we open the window.
    --This is a hud window, but we don't want to show anything
    --else on the hud, such as the system hud.
    ga_set_sys_b("game.window.hud.hide_system_hud", true)

    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 1.0)

    ga_win_set_front_color(wid, std.vec(1.0, 0.0, 0.0))
    
    ga_win_set_char_size(wid, 0.04, 0.08)   
    ga_win_txt_center(wid, 0.5, "YOU ARE DEAD")

    if( ga_get_hardcore_mode() ) then
        ga_win_set_char_size(wid, 0.02, 0.04)
        ga_win_txt_center(wid, 0.30, "YOU CANNOT RESPAWN BECAUSE")
        ga_win_txt_center(wid, 0.25, "YOU ARE IN HARDCORE MODE")
    else
        ga_win_set_char_size(wid, 0.02, 0.04)
        ga_win_txt_center(wid, 0.3, "PRESS ENTER TO RESPAWN")
        ga_win_txt_center(wid, 0.12, "OR DO MAIN MENU -> LOAD GAME")
        ga_win_txt_center(wid, 0.06, "(NOT THE SAME AS RESPAWNING)")
    end
end

function p.__process_input(wid)
    if( ga_win_key_pressed(wid, "ENTER") )
    then
        ga_print("Calling respawn force from win_death")

        --Putting the system hud back to normal.
        ga_set_sys_b("game.window.hud.hide_system_hud", false)

        ga_print("got enter key in win_death")
        ga_command("respawn force")
        ga_hud_window_remove("win_death")

        --This needs to be called now.
        --There is a bug where in some state,
        --calling ga_command("respawn_force")
        --will not cause top.__respawn_player to be called.
        --It may have to do with when the respawn point
        --is at a very high level. 
        -- top.__respawn_player()
        return
    end

    -- if( ga_get_sys_b("game.player.alive") ) then
    --     --Removing this window.
    --     -- ga_window_pop()
    --     ga_hud_window_remove("win_death") --Not needed.
    -- end
end
