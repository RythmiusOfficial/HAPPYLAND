--File: game_cmd_telehome.lua

--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "telehome"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    if not ga_get_sys_b("metagame.cheat.enabled") then
        ga_console_print("^1Cheating must be enabled")
        return
    end

    if( str == "" ) then
        game_base_wp_system.teleport_home()
    else
        game_base_wp_system.teleport_to_first_matches_fancy(str)
    end
end

function p.get_help_str()
    return
           "Usage: telehome\n"
        .. "       telehome STR\n\n"
        .. "The command \"teleport\" teleports you back to your EMERGENCY waypoint. "
        .. "The command \"teleport STR\", where STR is a nonempty string, "
        .. "teleports you to the first waypoint whose full name matches the string STR. "
end
