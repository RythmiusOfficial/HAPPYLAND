--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "inf2"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    local strs = game_str.split(str)
    if( #strs == 0 ) then
        p.toggle()
    elseif( #strs == 1 ) then
        local str1 = strs[1]
        if( str1 == "on" ) then
            p.turn_on()
        elseif( str1 == "off" ) then
            p.turn_off()
        end
    elseif( #strs == 2 ) then
        local str1 = strs[1]
        local str2 = strs[2]
        -- if( str1 == "set_bt1" ) then
        --     ga_set_s("xar.cheat.inf2.primary_bt", str2)
        -- elseif( str1 == "set_bt2" ) then
        --     ga_set_s("xar.cheat.inf2.secondary_bt", str2)
        -- end
    end
    --Could complain if args are wrong.
end

function p.toggle()
    local enabled = ga_get_b("xar.cheat.inf2.enabled")
    if enabled then
        p.turn_off()
    else
        p.turn_on()
    end
end

function p.turn_on()
    local worked = game_inf2.enable()
    if( worked ) then
        ga_set_b("xar.cheat.inf2.enabled", true)
        ga_console_print("^xff00ffLong live the game Infinifrag 2!")
    end
end

function p.turn_off()
    game_inf2.disable()
    ga_set_b("xar.cheat.inf2.enabled", false)
end

function p.get_help_str()
    return
           "Usage: inf2\n"
        .. "Usage: inf2 on\n"
        .. "Usage: inf2 off\n\n"
        -- .. "Usage: inf2 set_bt1 BLOCK_TYPE\n"
        -- .. "Usage: inf2 set_bt2 BLOCK_TYPE\n\n"
        .. "Cheat code to toggle the Infinifrag 2 Easter egg. "
end
