--File: game_command_system.lua

--Other scripts should not access this directly.
local commands = {} --Maps command name to function ref.
local command_help = {}

function p.add_command(cmd_name, func_ref)
    commands[cmd_name] = func_ref
end

--Returns an array with all command names in it.
function p.get_commands()
    local array = {}
    local index = 0
    for cmd,_ in pairs(commands) do
        index = index + 1
        array[index] = cmd
    end
    game_str.sort_array_of_strs(array)
    return array
end

--Gets all the commands in a single string,
--separated by semicolons.
function p.get_commands_in_single_str()
    local array = p.get_commands()
    local str = ""
    for i = 1,#array do
        str = str .. array[i]
        if( i < #array ) then str = str .. ";" end
    end
    return str
end

function p.command_exists(cmd_name)
    local func = commands[cmd_name]
    return (func ~= nil)
end

--Returns the function reference
--(or nil if it does not exist).
function p.get_command_by_name(cmd_name)
    return commands[cmd_name]
end

--For example, if the player runs the command
--"use_equipped primary stop" fron the console,
--then this function should be called with
--cmd_name = "use_equipped" and
--cmd_options = "primary stop"
--Returns a string.
function p.run_command(cmd_name, cmd_options)
    local func = commands[cmd_name]
    if( func == nil ) then return end --Could complain.
    local frame = "game_command_system.run_command: " .. cmd_name
    ga_debug_push(frame)
    local result = func(cmd_options) --Calling the function reference.
    ga_debug_pop(frame)
    -- ga_print("game_command_system.run_command: cmd_name = " .. cmd_name)
    -- ga_print("game_command_system.run_command: result = " .. tostring(result))
    local the_type = tostring(type(result))
    -- ga_print("game_command_system.run_command: type = " .. the_type)
    if( the_type == "string" ) then
        -- ga_print("It is a string!!!")
        return result
    end
    return "" --Uh oh!
end

function p.add_help(cmd_name, help_str)
    command_help[cmd_name] = help_str
end

function p.get_help(cmd_name)
    local str = command_help[cmd_name]
    if( str == nil ) then return "" end
    return str
end
