--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "equip"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    local strs = game_str.split(str)
    if( #strs == 0 ) then return end --Uh oh!
    local str1 = strs[1]
    --Silly code.
    local item_num = tonumber(str1)
    if( item_num == nil ) then return end --Uh oh!
    --
    if game_change_wep.can_use_wep(item_num) then
        ga_set_i("xar.player.cur_wep", item_num)
        game_inv_exec.end_use()
    end
end

function p.get_help_str()
    return
           "Usage: equip n\n\n"
        .. "Equips item number n. "
end
