--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "pink"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    game_cheats.pink_tele()
end

function p.get_help_str()
    return
           "Usage: pink\n\n"
        .. "Cheat code that causes the player to teleport as if "
        .. "they used pink rings. "
end
