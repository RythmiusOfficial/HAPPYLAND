--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "topofworld"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    game_cheats.topofworld()
end

function p.get_help_str()
    return
           "Usage: topofworld\n\n"
        .. "Cheat code to teleport the player to the root of the world."
end
