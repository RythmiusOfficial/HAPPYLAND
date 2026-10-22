--We might want to make this more general.
--That is, every weapon might have a string name,
--and this command could just return the string name
--of the current item being used.

--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "get_equipped"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    local cur_wep = ga_get_i("xar.player.cur_wep")
    return tostring(cur_wep)
end

function p.get_help_str()
    return
           "Usage: get_equipped\n\n"
        .. "Returns (in the form of a string) what weapon is "
        .. "is currently equipped. "
end
