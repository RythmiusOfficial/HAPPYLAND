--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "blue"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    game_cheats.blue_tele()
end

function p.get_help_str()
    return
           "Usage: blue\n\n"
        .. "A function to teleport the player "
        .. "using softcoded \"blue ring teleportation\". "
end
