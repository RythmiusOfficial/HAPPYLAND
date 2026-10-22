--Note: Might want to move the help2 command
--from Lua to C++.

--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "help2"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    if( str == "" ) then
        p.print_all_commands()
    else
        p.print_cmd_help(str)
    end
end

function p.print_all_commands()
    ga_console_print("Strings that can be passed to top.__game_input:")
    ga_console_print("\n")
    --
    local cmd_list = game_command_system.get_commands()
    for i = 1,#cmd_list do
        ga_console_print(cmd_list[i])
    end
end

function p.print_cmd_help(cmd_name)
    local help_str = game_command_system.get_help(cmd_name)
    ga_console_print(help_str)
end

function p.get_help_str()
    return
           "Usage: help2\n"
        .. "       help2 cmd\n\n"
        .. "The first usage prints the list of all commands "
        .. "defined by the package. "
        .. "The second usage prints information about the "
        .. "specified command. "
end
