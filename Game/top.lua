function p.__new_game()
    --Emergeny waypoint (sensitive).
    ga_add_waypoint_sloppy("EMPTY_PATH", "EMERGENCY")

    --Camera mode.
    blank_movement.set_true_up(true)
end

function p.__load_game()
    --Could add initialization here.

    --Adding windows to the hud.
    ga_hud_window_add("blank_win_hud", 0)
end

function p.__update()
    --Opening the death window.
    if not ga_get_sys_b("game.player.alive") then
        ga_hud_window_add("blank_win_death", 1000)
    end

    --Fading out messages that appear in the lower left.
    blank_msg.update()
end

function p.__update_passive()
    --Nothing to do.
end

function p.__update_discrete_pre()
    --Nothing to do.
end

function p.__update_discrete_post()
    blank_movement.update_discrete()
    --more?
end

function p.__game_input(str)
    if not ga_get_sys_b("game.player.alive") then return "" end

    if (str == "help") then
        ga_console_print("Strings that can be passed to game_input:")
        ga_console_print("help")
        ga_console_print("__game_saved__")
        ga_console_print("move ...")
        return ""
    end

    if( str == "__game_saved__" ) then
        blank_msg.add("Game saved")
        return ""
    end

    if( str:find("^__spiral_of_death__") ~= nil ) then
        num = string.gsub(str, "^__spiral_of_death__ ", "")
        blank_msg.add("SOD: " .. num)
        return ""
    end

    if( str:find("^move") ~= nil ) then
        --str starts with "move".
        blank_movement.input(str)
        return ""
    end
    
    ga_console_print("^1Error: unknown string passed to game_input: ")
    ga_console_print(str)
    return ""
end

-- function p.screen_inv_selected()
--     return ga_get_i("xar.player.cur_wep")
-- end

function p.__killed_player()
    --Nothing to do.
end

function p.__respawn_player()
    ga_hud_window_remove("blank_win_death")
end
