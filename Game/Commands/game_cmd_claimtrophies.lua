--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "claimtrophies"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    ga_console_print("^2Getting Steam achievements for all trophies in player's inventory.")
    game_trophy.get_all_achievements_for_aquired_trophies()
end

function p.get_help_str()
    return
           "Usage: claimtrophies\n\n"
        .. "Gives you a Steam achievement for each trophy "
        .. "your player has collected. "
end
