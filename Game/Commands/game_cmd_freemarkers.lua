--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "freemarkers"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    game_cheats.freemarkers()
end

function p.get_help_str()
    return
           "Usage: blue\n\n"
        .. "Cheat code that allows the player to place "
        .. "markers for zero gold. "
end
