--File: game_create_start_pos.lua

--This script is responsible for initially placing the player
--in the world when they do a new game.
--It basically works by starting the player at the root,
--and every block type has a "child block type" that we drop down to.

--To do: rewrite this file to use the
--ga_search_for_bt_in_chunk and
--ga_search_for_bt_in_chunk_random functions more.

--To do: Continue to clean up this file.

function p.main()
    local state = ga_get_s("xar.create_start_pos.state")
    if( state == "not_started" ) then
        p.init()
        return
    end
    if( state == "in_progress" ) then
        p.main2()
        return
    end
end

function p.splash(str)
    ga_set_s("xar.create_start_pos.splash", str)
    --ga_print("splashing: " .. str)
end

function p.init()
    local package_seed = ga_get_sys_i("game.package.seed")

    local which_try = ga_get_i("xar.create_start_pos.which_try")
    ga_set_i("xar.create_start_pos.which_try", which_try+1)
    ga_set_i("xar.create_start_pos.next_seed", package_seed + which_try) --Good enough?
    --
    ga_set_f("xar.create_start_pos.frac", 0.0)
    ga_hud_window_add("win_create_start_pos", 2000)
    ga_set_s("xar.create_start_pos.state", "in_progress")
    ga_set_i("xar.create_start_pos.cur_level", 0)
    --
    local tries_max = ga_get_i("xar.create_start_pos.global_tries_max")
    ga_set_i("xar.create_start_pos.global_tries", tries_max)
    --
    ga_move_set_body_spirit()
    ga_tele("EMPTY_PATH", std.vec(2.0, 2.0, 2.0))
end

--It would be good to have a more general
--random seed "stream" or "channel".
function p.random_pos(min_x, min_y, min_z, max_x, max_y, max_z)
    local seed = ga_get_i("xar.create_start_pos.next_seed")
    ga_srand(seed)
    --
    local x = ga_randi(min_x, max_x)
    local y = ga_randi(min_y, max_y)
    local z = ga_randi(min_z, max_z)
    local pos = std.bp(x,y,z)
    --
    local next_seed = ga_rand()
    -- ga_print("xar.create_start_pos.random_pos: next_seed = " .. tostring(next_seed))
    ga_set_i("xar.create_start_pos.next_seed", next_seed)
    --
    return pos
end

--This is for the new algorithm.
--This is to be applied in the chunk of the player.
function p.advance_to_pos(x,y,z, goal_bt)
    local level = ga_get_viewer_level()
    -- local chunk_id = ga_get_viewer_chunk_id()
    local pos = std.bp(x,y,z)
    local actual_bt = ga_block_get(level, pos)
    if goal_bt ~= actual_bt then
        local chunk_bt = ga_get_viewer_chunk_bt()
        ga_print("In game_create_start.lua: advance_to_pos:")
        ga_print("We are currently in chunk " .. chunk_bt)
        ga_print("trying to descend to position " .. std.vec_to_str(x,y,z))
        ga_print("However this position has block type " .. actual_bt)
        ga_print("instead of the requested block type " .. goal_bt)
        ga_exit()
    end
    ga_shrink2(std.block_center(pos))
    ga_set_i("xar.create_start_pos.cur_level", level+1)
end

--This is for the new algorithm.
--This is to be applied in the chunk of the player.
--It just tries a single position at random.
function p.advance_to_random_pos_maybe(goal_bt)
    local pos = p.random_pos(0,0,0, 15,15,15)
    local level = ga_get_viewer_level()
    local actual_bt = ga_block_get(level, pos)
    if goal_bt ~= actual_bt then return false end
    ga_shrink2(std.block_center(pos))
    ga_set_i("xar.create_start_pos.cur_level", level+1)
    return true
end

--This tries every local block position but in a random order.
function p.advance_to_random_pos_search_maybe(seed, goal_bt)
    local chunk_id = ga_get_viewer_chunk_id()
    local data = ga_search_for_bt_in_chunk_random(seed, chunk_id, goal_bt)
    if( data.is_valid ) then
        local pos = data.value
        ga_shrink2(std.block_center(pos))
        local level = ga_get_viewer_level()
        ga_set_i("xar.create_start_pos.cur_level", level+1)
        return true
    else
        return false
    end
end

--This tries every local block position but in the usual order.
function p.advance_to_search_maybe(goal_bt)
    local chunk_id = ga_get_viewer_chunk_id()
    local data = ga_search_for_bt_in_chunk(chunk_id, goal_bt)
    if( data.is_valid ) then
        local pos = data.value
        ga_shrink2(std.block_center(pos))
        local level = ga_get_viewer_level()
        ga_set_i("xar.create_start_pos.cur_level", level+1)
        return true
    else
        return false
    end
end

--This tries every local block position but in the usual order.
function p.advance_to_search(goal_bt)
    local worked = p.advance_to_search_maybe(goal_bt)
    if not worked then
        local chunk_bt = ga_get_viewer_chunk_bt()
        ga_print("In game_create_start.lua: advance_to_search_maybe: ")
        ga_print("No block of type " .. goal_bt .. " found in chunk of type " .. chunk_bt)
        local chunk_id = ga_get_viewer_chunk_id()
        ga_dump_chunk(chunk_id)
        ga_exit()
    end
end

--Goes to any block (chosen at random)
--in the player's chunk with the given block type.
function p.advance_to_random_with_bt(seed, goal_bt)
    local chunk_id = ga_get_viewer_chunk_id()
    local data = ga_search_for_bt_in_chunk_random(seed, chunk_id, goal_bt)
    if( data.is_valid ) then
        local pos = data.value
        ga_shrink2(std.block_center(pos))
        local level = ga_get_viewer_level()
        ga_set_i("xar.create_start_pos.cur_level", level+1)
    else
        local chunk_bt = ga_get_viewer_chunk_bt()
        ga_print("In game_create_start.lua: advance_to_random_with_bt:")
        ga_print("We are currently in chunk " .. chunk_bt)
        ga_print("trying to descend to position with block type " .. goal_bt)
        ga_print("However no such position can be found")
        ga_exit()
    end
end

function p.pop(n)
    local level = ga_get_viewer_level()
    ga_set_i("xar.create_start_pos.cur_level", level-n)

    --So we do not get caught in an infinite loop.
    ga_set_b("xar.create_start_pos.fast_track", false)
end

function p.main2()
    --Ticking down.
    local tries = ga_get_i("xar.create_start_pos.global_tries")
    ga_set_i("xar.create_start_pos.global_tries", tries-1)

    --Advancing the seed.
    local seed = ga_get_i("xar.create_start_pos.next_seed")
    ga_srand(seed)
    local next_seed = ga_rand()
    ga_set_i("xar.create_start_pos.next_seed", next_seed)

    --When fast_track is true, we attempt to look for a
    --SPACE_SOLAR_SYSTEM_START in a galaxy instead of a
    --SPACE_SOLAR_SYSTEM.  The former is better, but we do not
    --want to mess up anybody's save file (a single SPACE_SOLAR_SYSTEM_START
    --block was added to each galaxy chunk in update "1.01.23".
    local fast_track = ga_get_b("xar.create_start_pos.fast_track")

    if tries < 0 then
        ga_hud_window_remove("win_create_start_pos")
        p.init()
        return
    end

    local viewer_level = ga_get_viewer_level()
    local crawl_level = ga_get_i("xar.create_start_pos.cur_level")
    --
    ga_set_f("xar.create_start_pos.frac", viewer_level / 30.0)
    --
    local cur_bt = ga_get_cocoon_block_of_chunk(
        viewer_level, std.bp(0,0,0))
    p.splash(cur_bt)

    --
    if( viewer_level > crawl_level ) then
        ga_grow()
        return
    end
    if( viewer_level ~= crawl_level ) then
        --splash("WAITING TO SHRINK")
        return
    end
    local level = viewer_level

    local chunk_id = ga_get_viewer_chunk_id()
    local chunk_bt = ga_get_viewer_chunk_bt()
    ga_print("game_create_start_pos: level=" .. tostring(level) .. " bt=" .. chunk_bt)
    --
    if( chunk_bt == "block_root" ) then
        p.advance_to_pos(7,7,7, "block_root_flower")
    elseif( chunk_bt == "block_root_flower" ) then
        p.advance_to_pos(7,7,6, "block_root_flower_main")
    elseif( chunk_bt == "block_root_flower_main" ) then
        p.advance_to_random_pos_search_maybe(seed, "block_space0")
    elseif( chunk_bt == "block_space0" ) then
        p.advance_to_random_pos_search_maybe(seed, "block_space1")
    elseif( chunk_bt == "block_space1" ) then
        p.advance_to_random_pos_search_maybe(seed, "block_space2")
    elseif( chunk_bt == "block_space2" ) then
        p.advance_to_random_pos_search_maybe(seed, "block_supercluster")
    elseif( chunk_bt == "block_supercluster" ) then
        p.advance_to_random_pos_search_maybe(seed, "block_supercluster_inner")
    elseif( chunk_bt == "block_supercluster_inner" ) then
        p.advance_to_random_pos_search_maybe(seed, "block_cluster")
    elseif( chunk_bt == "block_cluster" ) then
        p.advance_to_random_pos_search_maybe(seed, "block_cluster_inner_kilo")
    elseif( chunk_bt == "block_cluster_inner_kilo" ) then
        p.advance_to_random_pos_search_maybe(seed, "block_cluster_inner")
    elseif( chunk_bt == "block_cluster_inner" ) then
        p.advance_to_random_pos_search_maybe(seed, "block_galaxy")
    elseif( chunk_bt == "block_galaxy" ) then
        p.advance_to_random_pos_search_maybe(seed, "block_galaxy_inner")
    elseif( chunk_bt == "block_galaxy_inner" ) then
        p.advance_to_random_pos_search_maybe(seed, "block_planet_chunk")
    elseif( chunk_bt == "block_planet_chunk" ) then
        p.advance_to_pos(7,7,7, "block_planet")
    elseif( chunk_bt == "block_planet" ) then
        p.advance_to_random_pos_search_maybe(seed, "block_planet_inner")
    elseif( chunk_bt == "block_planet_inner" ) then
        if not p.advance_to_random_pos_search_maybe(seed, "block_planet_inner_nomap") then
            p.pop(ga_randi(1,2))
        end
    elseif( chunk_bt == "block_planet_inner_nomap" ) then
        if not p.advance_to_random_pos_search_maybe(seed, "block_epsilon_caves_flower") then
            p.pop(ga_randi(1,2))
        end
    elseif( chunk_bt == "block_epsilon_caves_flower" ) then
        if not p.advance_to_random_pos_search_maybe(seed, "block_epsilon_caves_1") then
            p.pop(ga_randi(1,2))
        end
    elseif( chunk_bt == "block_epsilon_caves_1" ) then
        if not p.advance_to_random_pos_search_maybe(seed, "block_epsilon_caves_2") then
            p.pop(ga_randi(1,2))
        end
    elseif( chunk_bt == "block_epsilon_caves_2" ) then
        if not p.advance_to_random_pos_search_maybe(seed, "block_primordial_flower") then
            p.pop(ga_randi(1,3))
        end
    elseif( chunk_bt == "block_primordial_flower" ) then
        p.advance_to_pos(7,7,6, "block_primordial_prison")
    elseif( chunk_bt == "block_primordial_prison" ) then
        p.advance_to_pos(7,7,7, "block_primordial_shell_0")
    elseif( chunk_bt == "block_primordial_shell_0" ) then
        p.advance_to_pos(7,7,7, "block_primordial_shell_1")
    elseif( chunk_bt == "block_primordial_shell_1" ) then
        p.advance_to_pos(7,7,7, "block_primordial_shell_2")
    elseif( chunk_bt == "block_primordial_shell_2" ) then
        p.advance_to_pos(7,7,7, "block_primordial_main")
    elseif( chunk_bt == "block_primordial_main" ) then
        if not p.advance_to_random_pos_search_maybe(seed, "block_primordial_main_0") then
            p.pop(ga_randi(6,7))
        end
    elseif( chunk_bt == "block_primordial_main_0" ) then
        p.advance_to_random_pos_search_maybe(seed, "block_primordial_main_1")
    elseif( chunk_bt == "block_primordial_main_1" ) then
        p.advance_to_pos(7,7,10, "block_primordial_main_2_tut")
    elseif( chunk_bt == "block_primordial_main_2_tut" ) then
        p.advance_to_pos(7,7,7, "block_primordial_tutorial")
    elseif( chunk_bt == "block_primordial_tutorial" ) then
        p.advance_to_pos(7,7,7, "block_primordial_tutorial_1")
    elseif( chunk_bt == "block_primordial_tutorial_1" ) then
        p.finish()
    end
end

--Modifying the emergency waypoint room block
--and the block above it.
--The argument to this function is the chunk_id
--of the XAR_TUTORIAL block.
--This might seem bizzare, but it is the price we
--pay for having secret toll doors (with holes in them)
--blocking the duplicate emergency waypoint rooms.
-- function p.modify_em_wp_rooms(chunk_id)
--     local level = ga_chunk_id_to_level(chunk_id)
--     --
--     local bp1 = ga_chunk_id_and_lbp_to_bp(chunk_id, std.bp(11,7,6))
--     local bt1_found = ga_bp_to_bt(level, bp1)
--     local bt1_expected = "XAR_TUTORIAL_WP_PRE"
--     --
--     local bp2 = ga_chunk_id_and_lbp_to_bp(chunk_id, std.bp(11,7,7))
--     local bt2_found = ga_bp_to_bt(level, bp2)
--     local bt2_expected = "XAR_TUTORIAL_WP_ABOVE_PRE"
--     --
--     --Making sure are assumptions are correct.
--     if( bt1_found ~= bt1_expected or
--         bt2_found ~= bt2_expected )
--     then
--         ga_print("*** Error: bug in game_create_start_pos.lua: emergency wp block type problem")
--         ga_print("           bt1_found = " .. bt1_found)
--         ga_print("           bt2_found = " .. bt2_found)
--         ga_exit_with_error()
--     end
--     --
--     --Changing blocks in the world (permanently).
--     ga_block_change_perm(level, bp1, "XAR_TUTORIAL_WP")
--     ga_block_change_perm(level, bp2, "XAR_TUTORIAL_WP_ABOVE")
-- end

function p.finish()
    ga_set_s("xar.create_start_pos.state", "done")
    --
    --Important if the game is rebooted:
    ga_set_i("xar.create_start_pos.which_try", 0)
    --
    ga_hud_window_remove("win_create_start_pos")
    --
    --Setting camera mode.
    game_body.set_default_fly_mode()
    --
    ga_tele_same_level(std.vec(7.5, 2.0, 8.0))
    --
    --The emergency waypoint is always in the
    --same position relative to the starting chunk.
    local viewer_chunk = ga_get_viewer_chunk_id()
    local path1 = ga_chunk_id_to_path(viewer_chunk)
    local path2 = path1:sub(1, -4) --Magic.
    local path3 = path2 .. "767" --Magic.
    --ga_add_waypoint_sloppy(path3, "EMERGENCY")
    -- ga_print("emergency waypoint path = " .. path3)
    game_base_wp_system.add_emergency_wp(path3)
    ga_print(path3)
    ga_print("AAAAAAHHA!!") -- i'm keeping this
    ga_set_respawn_point(path3, std.bp(7,7,7))
    --
    ga_play_sound("enter_game")
end

--This is used for the non "classic" or "genesis" game configurations.
function p.dummy_finish()
    p.finish_helper()
end

--Helper function.
--Do not call this from the outside.
function p.finish_helper()
    --Recording that we were successful.
    local reboot_count = ga_get_sys_i("game.player.reboot_count")
    ga_set_i("xar.create_start_pos.which_reboot_cleared", reboot_count)
end

--This should be called in the top.__load function.
--If this returns false, then the player was not placed
--correctly in their starting position.
--A popup will be displayed that cannot be closed
--telling the player to reboot the game.
function p.check_start_pos_succeeded()
    return true
end