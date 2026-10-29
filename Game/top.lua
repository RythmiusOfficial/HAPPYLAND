function p.__new_game()
    --Setting camera mode.
    game_body.set_default_fly_mode()

    --Maybe need to procedurally create the starting position.
    local game_desc = ga_get_sys_s("game.package.config_desc")
    if( game_desc == "Genesis" or
        game_desc == "Classic" )
    then
        ga_set_s("xar.create_start_pos.state", "not_started")
    else
        --Needed so we know that a new game was created successfully.
        game_create_start_pos.dummy_finish()
    end

    --Only adding extra builtin waypoints
    --if using "Cheater Hub" configuration.
    if( ga_get_sys_s("game.package.config_desc") == "Cheater Hub" ) then
        game_cheater_waypoints.add()
    end

    --Setting curve mode on by default.
    --The reason it is not set this way in globals.txt
    --is because I don't want to modify legacy saved games.
    ga_set_b("xar.difficulty.curve.enabled", true)

    --Initializing package vars, if they have not been already.
    game_package_init.init()
end

function p.__load_game()
    ga_debug_push("top.__load_game")

    --Setting dependent variables.
    game_var_helpers.set_dep_vars()

    --Adding windows to the hud.
    --Lower numbers are rendered first.
    ga_hud_window_add("win_hud_user_below", 50)
    ga_hud_window_add("win_hud", 100) --Do not change.
    ga_hud_window_add("win_hud_user_above", 150)

    --more?

    --Forcing it.
    local respawn_explore_while_func = "game_respawn.explore_while_func"
    local respawn_explore_while_win = ""
    ga_set_respawn_cb(
        respawn_explore_while_func,
        respawn_explore_while_win)

    ga_command("cheat hodisclosetov nosound")
    ga_command("cheat on nosound")
    ga_command("god on")
    ga_command("noclip on")
    ga_command("shrinkany on")
    ga_command("cheat chpasswd rythmius") -- you spoiled it.
    ga_command("cheat off")
    ga_command("clear")

    --DEBUGGING!!!
    aaa_check_api.main()
    ga_debug_pop("top.__load_game")
end

--Returns false when done.
function p.__reboot_game()
    ga_print("Here in top.__reboot_game")

    --Clearing certain env vars.
    ga_set_f("xar.emp_end_time", 0.0)

    local countdown = 10000 --10 thousand.
    while true do
        if ga_reboot_dyn_itr_at_end() then
            --Done the rebooting process.
            return false
        end

        countdown = countdown - 1
        if( countdown <= 0 ) then
            --Too many vars to do now,
            --must do them later.
            return true
        end

        local var = ga_reboot_dyn_itr_get()

        --Put code here to save specific dynamic variables.

        --Only saving the var called
        --"dyn.test.my_favorite_book".
        -- if var == "dyn.test.my_favorite_book" then
        --     ga_reboot_dyn_itr_save()
        -- end

        ga_reboot_dyn_itr_next()
    end

    --Will never reach here.
    return false
end

--Called during a regular (non discrete) update.
--This is called once per frame.
function p.__update()
    ga_debug_push("top.__update")
    game_update.update()
    ga_debug_pop("top.__update")
end

--Gets called when the game is paused,
--such as when in a menu.
function p.__update_passive()
    ga_debug_push("top.__update_passive")
    game_update.update_passive()
    ga_debug_pop("top.__update_passive")
end

--Gets called first during a (discrete) update cycle.
--The the engine performs its own discrete update.
--Then the update_discrete_post function gets called
--There are 25 discrete updates per second.
function p.__update_discrete_pre()
    ga_debug_push("top.__update_discrete_pre")
    game_update.update_discrete_pre()
    ga_debug_pop("top.__update_discrete_pre")
end

function p.__update_discrete_post()
    ga_debug_push("top.__update_discrete_post")
    game_update.update_discrete_post()
    ga_debug_pop("top.__update_discrete_post")
end

--Note: In the past this function could crash by either calling
--ga_get_viewer_chunk_id or ga_get_viewer_level.
--This was because the mtree was sometimes "loading locked".
--The solution is to note call __game_input if the mtree
--is loading locked.
function p.__game_input(str)
    -- ga_print("top.game_input: " .. str)

    if not ga_get_sys_b("game.player.alive") then return "" end

    --The command system.
    local split = game_str.split_into_head_and_tail(str)
    local cmd_name = split.head
    local cmd_options = split.tail
    if( game_command_system.command_exists(cmd_name) ) then
        ga_debug_push("game_command_system.run_command")
        local result_str = game_command_system.run_command(cmd_name, cmd_options)
        ga_debug_pop("game_command_system.run_command")
        -- ga_print("Returning string from top.game_input: " .. result_str)
        return result_str
    end

    --Engine defined commands.
    if( str == "__game_saved__" ) then
        if( ga_get_b("xar.hud.msg.show_saved_game_msg") ) then
            game_msg.add("Game saved")
        end
        return ""
    end
    if( cmd_name == "^__spiral_of_death__" ) then
        if( ga_get_b("xar.hud.msg.show_spiral_of_death_msg") ) then
            --num = string.gsub(str, "^__spiral_of_death__ ", "")
            --game_msg.add("*** Danger: spiral of death: " .. num)
            --game_msg.add("SOD: " .. num) --Put this back in!
        end
        return ""
    end
    if( cmd_name == "__screenshot__" ) then
        game_msg.add("Screenshot saved")
        return ""
    end
    if( cmd_name == "__screenshot_failed__" ) then
        game_msg.add("*** Error: the Inner Core is too shy to have a screenshot taken")
        return ""
    end
    if( cmd_name == "__cmd__" ) then
        local mod = "Command: " .. cmd_options
        game_msg.add(mod)
        return ""
    end

    -- ga_console_print("^1Error: unknown string passed to game_input: ")
    -- ga_console_print(str)
    return "error"
end

function p.__game_input_get_all_cmds()
    return game_command_system.get_commands_in_single_str()
end

function p.__game_input_get_help_str(cmd_name)
    return game_command_system.get_help(cmd_name)
end

--Called when the engine actually "kills" the player.
function p.__killed_player()
    ga_debug_push("top.__killed_player")
    ga_play_sound_menu("player_death")
    ga_debug_pop("top.__killed_player")
end

--Called when the player has been teleported to
--their respawn point (because they are respawning).
--Todo: move this to "game_respawn.lua".
function p.__respawn_player(param)
    game_respawn.respawn_player(param)
end

function p.__get_level_color(level, block_side_str)
    return game_level_colors.main(level, block_side_str)
end
