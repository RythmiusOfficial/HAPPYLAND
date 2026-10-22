--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "telekinesis"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    game_telekinesis.payload()
end

function p.get_help_str()
    return
           "Usage: telekinesis\n\n"
        .. "Uses the telekinesis ability of the player to pick up nearby items. "
end
