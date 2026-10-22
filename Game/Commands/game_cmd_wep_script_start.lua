--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "wep_script_start"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    local strs = game_str.split(str)
    if( #strs ~= 2 ) then return end --Uh oh!
    --
    local wep_to_use = tonumber(strs[1])
    local mode = strs[2]
    --
    ga_set_b("xar.inv_exec.wep_script_in", true)
    local cur_wep = ga_get_i("xar.player.cur_wep")
    ga_set_i("xar.inv_exec.wep_script_last_wep", cur_wep)
    top.__game_input("equip " .. tostring(wep_to_use))
    if mode == "primary" then top.__game_input("use_equipped primary start") end
    if mode == "secondary" then top.__game_input("use_equipped secondary start") end
    return ""
end

function p.get_help_str()
    return
           "Usage: wep_script_start wep mode\n\n"
        .. "Starts firing the given weapon. "
        .. "The argument wep should be a number from 0 to 9, "
        .. "and mode should be either \"primary\" or \"secondary\". "
end
