--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "equip_left"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    local cur_wep = ga_get_i("xar.player.cur_wep")
    local next_wep = game_change_wep.prev_useable_wep(cur_wep)
    ga_set_i("xar.player.cur_wep", next_wep)
end

function p.get_help_str()
    return
           "Usage: equip_left\n\n"
        .. "Equips the previous item in the player's inventory. "
end
