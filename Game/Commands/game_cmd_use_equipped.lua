--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "use_equipped"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    local strs = game_str.split(str)
    if( #strs ~= 2 ) then return end --Uh oh!
    local str1 = strs[1]
    local str2 = strs[2]
    if( str1 == "primary" and str2 == "start" ) then
        if( ga_get_b("xar.input.use_primary_uses_object") and
            ga_use_object_exists() )
        then
            ga_command("use")
            return ""
        else
            local gun = ga_get_i("xar.player.cur_wep")
            game_inv_exec.start_use(gun, true)
        end
    end
    if( str1 == "primary" and str2 == "stop" ) then
        game_inv_exec.end_use()
    end
    if( str1 == "secondary" and str2 == "start" ) then
        if( ga_get_b("xar.input.use_secondary_uses_object") and
            ga_use_object_exists() )
        then
            ga_command("use 2")
            return ""
        end
        local gun = ga_get_i("xar.player.cur_wep")
        game_inv_exec.start_use(gun, false)
    end
    if( str1 == "secondary" and str2 == "stop" ) then
        game_inv_exec.end_use()
    end
end

function p.get_help_str()
    return
           "Usage: use_equipped (primary | secondary) (start | stop)\n\n"
        .. "Uses the equipped item in the player's inventory. "
end
