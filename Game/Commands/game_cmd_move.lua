--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "move"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    game_movement.input("move " .. str)
end

function p.get_help_str()
    return
           "Usage: move (forward | back)        (start | stop)\n"
        .. "       move (left | right)          (start | stop)\n"
        .. "       move (up | down)             (start | stop)\n"
        .. "       move (spwn_ccw | spin_cw)    (start | stop)\n"
        .. "       move brake                   (start | stop)\n"
        .. "       move toggle_rocket\n\n"
        .. "A command to move the player. "
end
