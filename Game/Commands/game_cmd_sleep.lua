--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "sleep"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    if not ga_get_sys_b("metagame.cheat.enabled") then
        ga_console_print("^1Cheating must be enabled")
        return
    end
    local num_seconds = tonumber(str)
    if( num_seconds == nil ) then
        ga_console_print("^1*** Error: " .. str .. " is not a recognized number")
        return
    end
    ga_print("Sleeping (in game time) for " .. tostring(num_seconds) .. " seconds")
    local old_game_time = ga_get_sys_f("game.time.total")
    local new_game_time = old_game_time + num_seconds
    ga_set_sys_f("game.time.total", new_game_time)
end

function p.get_help_str()
    return
           "Usage: sleep num_seconds\n\n"
        .. "Advances the game time by this integer number of seconds. "
end
