--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "wep_script_stop"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    if( ga_get_b("xar.inv_exec.wep_script_in") ) then
        local last_wep = ga_get_i("xar.inv_exec.wep_script_last_wep")
        if( last_wep >= 0 ) then
            top.__game_input("equip " .. tostring(last_wep))
            ga_set_i("xar.inv_exec.wep_script_last_wep", -1)
        end
    end
end

function p.get_help_str()
    return
           "Usage: wep_script_stop\n\n"
        .. "Stops firing the current weapon. "
end
