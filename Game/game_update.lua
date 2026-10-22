--Called during a regular (non discrete) update.
--This is called once per frame.
function p.update()
    local frame = "game_update.update"
    ga_debug_push(frame) --Be careful about returning.

    ga_debug_line("update: user")
    game_update_user.update()

    --Debugging:
    -- aaa_check_api.main()

    --Do we want to seed the random number generated?

    --Getting the initial starting position
    --(when starting a new game).
    if( ga_get_s("xar.create_start_pos.state") ~= "done" ) then
        ga_debug_line("update: create start pos")
        game_create_start_pos.main()
        ga_debug_pop(frame)
        return
    end

    --Needs to come after the starting pos step.
    --To make sure the player was correctly placed
    --at their starting position.
    game_create_start_pos.check_start_pos_succeeded()

    --It is complicated.
    --One issue is "the" emergency waypoint room.
    game_emergency_world_surgery.main()

    -- --Death checking.
    ga_debug_line("update: death checking")
    if ga_get_i("xar.player.health.amount") < 0 then
        ga_print("health is negative in top.update")
        if ga_get_sys_b("game.player.alive") then
            ga_print("calling ga_kill_player")
            ga_kill_player()
        end
    end
    if not ga_get_sys_b("game.player.alive") then
        -- ga_window_push("win_death")
        ga_hud_window_add("win_death", 1000)
    end

    -- --Damage.
    ga_debug_line("update: damage")
    game_damage.update()

    -- Hurt sound.
    ga_debug_line("update: hurt sound")
    game_hurt_sound.update()

    --Setting dependent variables.
    ga_debug_line("update: var helpers")
    game_var_helpers.set_dep_vars()

    --Inventory regen, etc.
    ga_debug_line("update: inventory regen")
    game_inv_regen.update()

    --Shooting weapons.
    ga_debug_line("update: inventory exec")
    game_inv_exec.update()

    --Hive attack.
    ga_debug_line("update: hive attack")
    game_ment_hive_attack.update()

    --Playing a playlist.
    ga_debug_line("update: play music")
    game_music.play_music_maybe()

    --In case a new weapon has been added to the game.
    ga_debug_line("update: game wep modes (annoying)")
    game_wep_modes.correct_has_vars()

    --Dealing with markers.
    ga_debug_line("update: dropping markers")
    if ga_get_b("xar.input.holding_drop_marker") and
        (   ga_get_sys_f("game.time.total") >
            ga_get_f("xar.input.holding_drop_marker_start") + 1.0 )
    then
        game_drop_markers.drop_marker_long()
        ga_set_b("xar.input.holding_drop_marker", false)
    end

    ga_debug_pop(frame)
end

--When the game is paused,
--such as when in a menu.
function p.update_passive()
    game_update_user.update_passive()

    --This is also here in passive, because
    --need to play the next song if the player
    --is in the main menu.
    game_music.play_music_maybe()
end

--Gets called first during a (discrete) update cycle.
--The the engine performs its own discrete update.
--Then the update_discrete_post function gets called
--There are 25 discrete updates per second.
function p.update_discrete_pre()
    game_update_user.update_discrete_pre()

    --Debugging.
    -- ga_set_game_paused_while_on_win_stack(false)

    --Nothing more to do.
end

function p.update_discrete_post()
    ga_debug_push("game_update.update_discrete_post")

    ga_debug_line("movement")
    if( ga_get_b("xar.cheat.inf2.enabled") ) then
        --Easter egg (moving with gravity).
        ga_debug_line("inf2 mode")
        game_inf2.movement_update_discrete()
        game_inf2.update_discrete_post() --Could combine into one.
    else
        ga_debug_line("normal mode")
        game_movement.update_discrete()
    end
    --more?

    ga_debug_line("user update post")
    game_update_user.update_discrete_post()

    ga_debug_pop("game_update.update_discrete_post")
end
