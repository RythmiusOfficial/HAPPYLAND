--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "marker"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    local strs = game_str.split(str)
    if( #strs == 0 ) then return end --Uh oh!
    local str1 = strs[1]
    if( str1 == "start" ) then
        if( not ga_get_b("xar.input.holding_drop_marker") ) then
            ga_set_f("xar.input.holding_drop_marker_start",
                ga_get_sys_f("game.time.total"))
        end
        ga_set_b("xar.input.holding_drop_marker", true)
    end
    if( str1 == "stop" ) then
        if ga_get_b("xar.input.holding_drop_marker") then
            game_drop_markers.drop_marker_short()
            ga_set_b("xar.input.holding_drop_marker", false)
        end
    end
end

function p.get_help_str()
    return
           "Usage: marker (start | stop)\n\n"
        .. "Starts / stops the drop marker ability. "
        .. "That is \"marker start\" should be called when the "
        .. "marker key is pressed, and \"marker stop\" should be called "
        .. "when the marker key is released. "
end
