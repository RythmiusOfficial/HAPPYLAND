--Once the player has ten thousand gold in the bank,
--the cost maxes out at 500.
function p.get_keepammo_cost()
    local gold = ga_get_i("xar.player.gold.amount")
    local value1 = math.floor( gold * 0.08 ) --8% of gold.
    local value2 = 400
    local value3 = math.min(value1, value2)
    return math.max(value3, 30)
end

--When this is called, the player's body mode is "sprit".
function p.explore_while_func()
    --Returning the player's body to normal.
    ga_move_set_body_spirit_off()

    local chunk_id = ga_get_viewer_chunk_id()
    local bent_type = "bent_respawn_point"
    local data = ga_search_for_bent_in_chunk(chunk_id, bent_type)
    if data.is_valid then
        --Found a respawn bent within the chunk,
        --so we are assuming that the chunk is safe.
    else
        local em_wp_path = ga_get_s("xar.world_pos.emergency_waypoint.path")
        if( em_wp_path == "" ) then
            --Uh oh!!!
            --Teleporing the player to the top off the world.
            ga_tele("EMPTY_PATH", std.vec(2.0, 2.0, 2.0))
        else
            --Uh oh!
            --Teleporting the player to their emergency waypoint.
            ga_tele(em_wp_path, std.vec(7.5, 7.5, 7.5))
        end
    end
    return false --Done.
end

--This is called by "top.__respawn_player".
function p.respawn_player(param)
    if( ga_get_hardcore_mode() ) then
        ga_set_sys_b("game.player.alive", false)
        return
    end

    ga_debug_push("top.__respawn_player")

    local keep_ammo = false
    if( param == "keepammo" ) then keep_ammo = true end

    ga_hud_window_remove("win_death")

    game_damage.clear_damage()

    local fixed_cost = 30

    if( keep_ammo ) then
        ga_print("Respawning while keeping ammo")
        local respawn_cost = math.max(
            fixed_cost,
            game_respawn.get_keepammo_cost())
        local old_gold = ga_get_i("xar.player.gold.amount")
        ga_print("old gold = " .. tostring(old_gold))
        local new_gold = old_gold - respawn_cost
        if new_gold < 0 then new_gold = 0 end
        ga_set_i("xar.player.gold.amount", new_gold)
    else
        ga_set_i("xar.player.health.amount",
            ga_get_i("xar.player.health.max"))
        ga_set_i("xar.player.shield.amount", 0)
        ga_set_i("xar.player.armor.amount", 0)
        game_remove_ammo.remove_ammo()
        ga_set_i("xar.player.gun1.ammo",
            game_wep_modes.get_ammo_max(1))
        if game_can_use.main(0) then
            ga_set_i("xar.player.gun0.ammo",
                game_wep_modes.get_ammo_max(0))
        end
        --
        std.set_bydelta_i("xar.player.gold.amount", -fixed_cost)
        if ga_get_i("xar.player.gold.amount") < 0 then
            ga_set_i("xar.player.gold.amount", 0)
        end
        ga_set_i("xar.player.markers.num_short", 0)
    end

    --Another way to do this would be to
    --have a system where (xar) respawn callbacks can be registered.
    --When the player respawns, all these callbacks are called.

    ga_set_s("xar.world_pos.bookmark.path", "")

    ga_set_f("xar.key_time.yellow", -1.0)
    ga_set_f("xar.key_time.blue", -1.0)
    ga_set_f("xar.key_time.green", -1.0)
    ga_set_f("xar.key_time.universe", -1.0)
    ga_set_f("xar.key_time.laser_genesis", -1.0)
    ga_set_f("xar.key_time.dans_house", -1.0)

    ga_set_b("xar.first_life", false)

    ga_set_b("xar.player.arcade.inside", false)

    ga_print("top.__respawn_player end")
    ga_flush()
    ga_debug_pop("top.__respawn_player")

    --Putting the system hud back to normal.
    --We also do this in the win_death window,
    --but we are making extra sure by putting it here.
    ga_set_sys_b("game.window.hud.hide_system_hud", false)
end
