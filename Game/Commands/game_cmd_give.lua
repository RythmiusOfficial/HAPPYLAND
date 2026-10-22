--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "give"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

local initialized = false
p.str_to_func_ref = {}

--Feeling the peer pressure not to make a chain of if-else statements.
--Not like it matters here.
function p.init_maybe()
    if( initialized ) then return end
    initialized = true
    p.str_to_func_ref["all"]         = p.handler_default
    p.str_to_func_ref["gold"]        = p.handler_gold
    p.str_to_func_ref["keys"]        = p.handler_keys
    p.str_to_func_ref["upgrades0"]   = p.handler_upgrades0
    p.str_to_func_ref["upgrades1"]   = p.handler_upgrades1
    p.str_to_func_ref["upgrades2"]   = p.handler_upgrades2
    p.str_to_func_ref["weaponmodes"] = p.handler_weaponmodes
end

function p.handler(str)
    p.init_maybe()
    local func = p.str_to_func_ref[str]
    if( func == nil ) then
        ga_console_print("^1Unknown str passed to give command: \"" .. str .. "\"")
        ga_console_print("^1Type \"help give\" for help")
        return
    end
    func()
end

function p.handler_default()
    --Getting all ammo, shield, healh, and armor.
    game_cheats.giveall()
end

function p.handler_gold()
    --Getting all keys.
    game_cheats.givegold()
end

function p.handler_keys()
    --Getting all keys.
    game_remove_ammo.give_keys()
end

function p.handler_upgrades0(str)
    game_cheats.giveupgrades0()
end

function p.handler_upgrades1(str)
    game_cheats.giveupgrades()
end

function p.handler_upgrades2(str)
    game_cheats.giveupgrades2()
end

function p.handler_weaponmodes(str)
    game_cheats.give_all_weapon_modes()
end

function p.get_help_str()
    return
           "Usage: give all\n"
        .. "       give gold\n"
        .. "       give keys\n"
        .. "       give upgrades0\n"
        .. "       give upgrades1\n"
        .. "       give upgrades2\n"
        .. "       give weaponmodes\n\n"
        .. "The command \"give all\" gives you all ammo, health, and armor of the player. "
        .. "The command \"give gold\" sets the player's gold to a very high amount. "
        .. "The command \"give keys\" will give you keys. "
        .. "The command \"give upgrades0\" sets the player to have a very "
        .. "small number of upgrades in many categories. "
        .. "The command \"give upgrades1\" sets the player to have 100 upgrades in many categories. "
        .. "The command \"give upgrades2\" sets the player to have 1000 upgrades in many categories. "
        .. "The command \"give weaponmodes\" unlocks the extra weapon modes for the player's weapons. "
end
