-------------------------------------------------
--       The teleportation manifesto begin
-------------------------------------------------
-- Todo: Move this to a webpage.

-- A common task is to teleport from point A to point B,
-- and possibly teleport back if there is a problem.
-- Here is the process to do this.

-- Step 1: Get the block path and lbp of where we
-- want to teleport to.
-- We can even work with an "offset" into the
-- target chunk rather than an lbp (local block position).

-- Step 2: Call the following functions:
-- A) ga_move_set_body_spirit()
-- B) ga_explore_while(lua_func, lua_win)
-- C) ga_tele(block_path, offset)
-- Note: these must be called within the SAME frame.

-- Changing our body to "sprit" will make us not
-- collide with the world.  It also makes us
-- not render the WORLD.
-- It also makes teleportation faster because
-- "we do not explore as much".
-- The basic reason why it is so fast is because the following:
-- If the chunk_id of the player is different from what it was
-- last frame, then the engine effectively sets the level
-- radius of each level to 0.
-- The player needs to be at a chunk for at least
-- two frames in order for the engine to create chunks
-- AROUND the viewer's chunk.
-- So, spirit mode is ideal for "drilling down".

-- For the ga_explore_while function call,
-- we pass the (string) name of a Lua function that
-- functions as a "while loop".  That is, the function
-- is called over and over again until it returns false.
-- However, this might not have the purpose that
-- might expect, which we will explain later.
-- You also pass to the ga_explore_while the
-- (string) name of a Lua window which is rendered
-- and gets input even frame until the while loop
-- function return false.

-- The ga_tele function call actually causes
-- the teleportation to happen, which we explain
-- in the next step.

-- Step 3: Wait.
-- Because you called ga_tele, the engine will
-- gradually modify the chunk tree to move the
-- player to the target block path.
-- While this is happening, the engine renders
-- a loading screen and does not actually call
-- any Lua function of the package.
-- This may take a few seconds.

-- Step 4: The engine will finish the teleportation
-- and will begin to call Lua code again.
-- The player is now "in the target chunk",
-- but they are in spirit mode, so they do not
-- really have a body exactly.
--
-- Because you had called the
-- ga_explore_while function, instead of calling
-- normal game functions, the engine will
-- call the "while loop" function you registed
-- using the ga_explore_while.
-- It will also call the input and render functions
-- of the (optional) window you passed to the
-- ga_explore_while function.

-- Step 5: At this point, the game will be in
-- the "while loop".
-- What is the purpose of this loop?
-- Well, you need to make sure it is safe to
-- teleport to this chunk.
-- What if it is completely filled with
-- solid blocks?  What if you wanted to teleport
-- to a waypoint, but somehow there are no
-- waypoints in the chunk?
-- What you want to do is query the chunk of the
-- player to see if it is suitable.
-- You might think you can just do this check
-- in a single frame.  Maybe you can.
-- However if the player's normal body size is
-- more than one block tall, there is an issue
-- that the player's destination would have them
-- partially in this chunk but also spill over
-- to an adjacent chunk.
-- Since we were in spirit mode,
-- there might not be any adjacent chunks to the
-- player's chunk that are loaded!
-- We must wait a few frames from the engine to
-- load nearby chunks for us to assess whether
-- it is really safe to end the teleportation
-- process.
-- Once we have enough information,
-- we need to return "fase" from the while loop function.
-- Just before we do return false,
-- we need to do a few things.

-- Step 6: If we calculated that the destination
-- chunk is OK, we need to do the following:
-- A) Call ga_move_set_body_spirit_off()
--    This will reset the player's body mode and dimensions
--    to what they were just before we called
--    ga_move_set_body_spirit()
-- B) We could move the player slightly within the chunk.
--    Theoretically, we could teleport the player
--    to an adjacent chunk (on the same level)
--    with the ga_tele_same_level function.
--    However, it might be bast to keep things
--    simple and only do A.
-- We are now done!

-- Step 7: Suppose we could not do Step 7 because
-- we calculated that the destination chunk is NOT ok.
-- We are now in trouble!!!
-- Theoretically you could do whatever you want,
-- like display an error screen to the player that says
-- "bummer dude" and then kill the player and take away
-- all their ammo.
-- However what you probably want to do is teleport
-- the player back to where they started before the
-- teleportation.
-- To do this, first note that the player is
-- still in spirit mode.
-- You want to call the ga_tele function
-- but giving it the path and lbp of where the player
-- started.  So, you needed to record this information
-- at the beginning.  You could store it in a "global"
-- variable for example.
-- Next, you MIGHT want to do another ga_explore_while
-- call.  Indeed, you could have chosen not to
-- end the old while loop.  In this case after the
-- engine teleports you back to your starting position,
-- the engine will continue calling this while loop.
-- However one could argue that doing any sort of
-- while loop for the back teleportation
-- (either part of the original while loop or a second one)
-- is not needed: the teleportation back SHOULD succeed.

-- Step 8: If the teleportation BACK does not succeed,
-- you need to decide what is the right thing to do.
-- Perhaps you should teleport the player to their
-- current respawn point.
-- We are now done!

-- Note: If you have an explore_while loop
-- where the function is called many times,
-- you may consider having the function call
-- ga_render_skip_next_frame to pause rendering.
-- This is done for blue rings, and it speeds up
-- the teleportation by a factor of 3 or so.
-- However, since we are using the ga_tele function,
-- it does not really matter.

-- Note: It might make sense for the ga_tele
-- function to record the player's starting path and lbp
-- before the teleportation, that way the player can
-- call a function called something like "ga_tele_back"
-- to have the engine teleport them back to
-- their starting position.

-------------------------------------------------
--       The teleportation manifesto end
-------------------------------------------------

-------------------------------------------------------------------------------
--
--                 Teleporting from bookmark to respawn point
--
-------------------------------------------------------------------------------

-------------------------------------------------
--           Getting and setting vars
-------------------------------------------------
--Do not SET bookmark vars directly.
--Use these functions instead.

function p.set_bookmark(path_str, lbp)
    if( path_str == "" ) then
        --This function was not called correctly.
        p.set_bookmark_off()
        return
    end
    ga_set_s("xar.world_pos.bookmark.path", path_str)
    ga_set_b("xar.world_pos.bookmark.has", true)
    ga_set_i("xar.world_pos.bookmark.lbp.x", lbp.x)
    ga_set_i("xar.world_pos.bookmark.lbp.y", lbp.y)
    ga_set_i("xar.world_pos.bookmark.lbp.z", lbp.z)
end

function p.set_bookmark_off()
    ga_set_s("xar.world_pos.bookmark.path", "")
    ga_set_b("xar.world_pos.bookmark.has", false)
    ga_set_i("xar.world_pos.bookmark.lbp.x", -1)
    ga_set_i("xar.world_pos.bookmark.lbp.y", -1)
    ga_set_i("xar.world_pos.bookmark.lbp.z", -1)
end

--The reason why there is the
--"xar.world_pos.bookmark.has" variable is for speed:
--the path might be very long, and usually we just
--want to know if the current bookmark exists.

-------------------------------------------------
--                    Main
-------------------------------------------------

--This function should be passed the chunk_id and the
--lbp for the "bookmark" bent that the player is using.
--They are trying to use their bookmark to teleport
--to their respawn point.  The catch is if their respawn
--point cannot be found, then we have to recover somehow.
function p.start_tele_from_bookmark(chunk_id, lbp)
    --Setting this location as our current bookmark.
    local source_path = ga_chunk_id_to_path(chunk_id)
    local source_offset = std.block_center(lbp)
    p.set_bookmark(source_path, lbp)

    --Getting the target location.
    local dest_path = ga_get_respawn_path() --Will eventually softcode.
    local dest_lbp  = ga_get_respawn_lbp()  --Will eventually softcode.
    local dest_offset = std.block_center(dest_lbp)
    
    --Setting the player's body to "spirit mode".
    --We must turn this off at the end.
    ga_move_set_body_spirit()

    --Requesting that the engine do the teleportation.
    ga_tele(dest_path, dest_offset)

    --If ga_set_tele_back is called (like we are doing now),
    --it must be called immediately AFTER ga_tele (NOT BEFORE).
    --What this does is set the "back location".
    --If we decide the destination chunk is unsafe
    --(once the engine teleports us there),
    --we can call ga_tele_back and it will teleport us back to
    --the (source_path, source_offset) position.
    ga_set_tele_back(source_path, source_offset)

    --Setting up the "explore while loop".
    local lua_func = "game_bookmark_tele.tele_from_bookmark_while_loop"
    local lua_win = "" --Not using a window (the teleportation is fast).
    ga_explore_while(lua_func, lua_win)

    ga_play_sound("waypoint_travel") --Todo: have xar have its own version of this.
end

function p.tele_from_bookmark_while_loop()
    --Safety check.
    local viewer_chunk_id = ga_get_viewer_chunk_id()
    local viewer_path = ga_chunk_id_to_path(viewer_chunk_id)
    local respawn_path = ga_get_respawn_path()
    if( viewer_path ~= respawn_path ) then
        --This should never happen.
        ga_print("*** Error: game_bookmark_tele failed: not in respawn point chunk")
        ga_exit()
    end
    --Ok, we are in the respawn point chunk.
    local data = ga_search_for_bent_in_chunk(
        viewer_chunk_id, "bent_respawn_point") --The xar version of the bent.
    if( data.is_valid ) then
        --We found the respawn point.
        --Luckily the player's normal body fits
        --insisde a single block position,
        --so life is simple.
        --
        --Let us NOT trust that the bent_respawn_point
        --is where we thought it was before the
        --teleportation.
        local lbp = data.value
        local new_center = std.block_center(lbp)
        ga_tele_same_level(new_center)
        ga_move_set_body_spirit_off()
        return false --Ending the while loop.
    else
        --Uh oh!
        --Cannot teleport to this chunk.
        --Need to teleport back to the bookmark.
        p.tele_from_bookmark_cancel()
        --
        --Now we are going to return true.
        --The following might seem insane.
        --What happened is the tele_from_bookmark_cancel
        --function just set another "explore while" loop,
        --and we do not want to return from that just yet!
        --That is, there is at most one explore while loop.
        --Indeed these "while loop" functions, like the
        --function tele_from_bookmark_while_loop we are in
        --now, actually returns whether we should continue
        --the "current explore while loop", regarless of what
        --the callback function is.
        return true --Continue with "tele_from_bookmark_cancel_while_loop".
    end
end

-------------------------------------------------
-- Canceling the teleportation (going back)
-------------------------------------------------

--We tried to go to the respawn point,
--but that failed somehow.
--Now, we need to go back to our "current bookmark".
--The player should already be in spirit mode.
function p.tele_from_bookmark_cancel()
    game_msg.add("Teleportation failed")
    ga_play_sound("error")

    --Remember, the player is still in spirit mode.

    --Requesting that the engine do the teleportation.
    --That is, it will bring us back to the location of the player
    --when ga_tele was called.
    ga_tele_back()

    -- Setting up the "explore while loop".
    local lua_func = "game_bookmark_tele.tele_from_bookmark_cancel_while_loop"
    local lua_win = "" --Not using a window (the teleportation is fast).
    ga_explore_while(lua_func, lua_win)
end

function p.tele_from_bookmark_cancel_while_loop()
    --Assume the teleportation worked.
    p.set_bookmark_off()
    ga_move_set_body_spirit_off()
    return false --End the while loop.
end

-------------------------------------------------------------------------------
--
--                 Teleporting from respawn point to bookmark
--
-------------------------------------------------------------------------------
--This code mirrors the other direction.

function p.start_tele_from_respawn_point()
    local dest_path  = ga_get_s("xar.world_pos.bookmark.path")
    local dest_lbp = std.bp(-1,-1,-1)
    dest_lbp.x = ga_get_i("xar.world_pos.bookmark.lbp.x")
    dest_lbp.y = ga_get_i("xar.world_pos.bookmark.lbp.y")
    dest_lbp.z = ga_get_i("xar.world_pos.bookmark.lbp.z")
    local dest_offset = std.block_center(dest_lbp)
    if( dest_path == "" ) then
        ga_play_sound("error")
        game_msg.add("Your current bookmark does not exist")
        return
    end
    
    --Setting the player's body to "spirit mode".
    --We must turn this off at the end.
    ga_move_set_body_spirit()

    --Requesting that the engine do the teleportation.
    ga_tele(dest_path, dest_offset)

    --This is only needed if we need to cancel the
    --teleportation and teleport back.
    local source_path = ga_get_respawn_path()
    local source_lbp = ga_get_respawn_lbp();
    local source_offset = std.block_center(source_lbp)
    ga_set_tele_back(source_path, source_offset)

    --Setting up the "explore while loop".
    local lua_func = "game_bookmark_tele.tele_from_respawn_point_while_loop"
    local lua_win = "" --Not using a window (the teleportation is fast).
    ga_explore_while(lua_func, lua_win)

    ga_play_sound("waypoint_travel") --Todo: have xar have its own version of this.

    --So we do not have to do it later.
    p.set_bookmark_off()
end

function p.tele_from_respawn_point_while_loop()
    local viewer_chunk_id = ga_get_viewer_chunk_id()
    local data = ga_search_for_bent_in_chunk(
        viewer_chunk_id, "bent_bookmark")
    if( data.is_valid ) then
        --We found the bookmark.
        --Luckily the player's normal body fits
        --insisde a single block position,
        --so life is simple.
        --
        --Let us NOT trust that the bent_respawn_point
        --is where we thought it was before the
        --teleportation.
        local lbp = data.value
        local new_center = std.block_center(lbp)
        ga_tele_same_level(new_center)
        ga_move_set_body_spirit_off()
        return false --Ending the while loop.
    else
        --Uh oh!
        --Cannot teleport to this chunk.
        --Need to teleport back to the bookmark.
        p.tele_from_bookmark_cancel()
        --
        --Now we are going to return true.
        --The following might seem insane.
        --What happened is the tele_from_respawn_point_cancel
        --function just set another "explore while" loop,
        --and we do not want to return from that just yet!
        --That is, there is at most one explore while loop.
        --Indeed these "while loop" functions, like the
        --function tele_from_bookmark_while_loop we are in
        --now, actually returns whether we should continue
        --the "current explore while loop", regarless of what
        --the callback function is.
        return true --Continue with "tele_from_respawn_point_cancel_while_loop".
    end
end

-------------------------------------------------
-- Canceling the teleportation (going back)
-------------------------------------------------

--We tried to go to the bookmark,
--but that failed somehow.
--Now, we need to go back to our respawn point.
--The player should already be in spirit mode.
function p.tele_from_respawn_point_cancel()
    game_msg.add("Teleportation failed")
    ga_play_sound("error")

    --Requesting that the engine do the teleportation.
    ga_tele_back()

    -- Setting up the "explore while loop".
    local lua_func = "game_bookmark_tele.tele_from_respawn_point_cancel_while_loop"
    local lua_win = "" --Not using a window (the teleportation is fast).
    ga_explore_while(lua_func, lua_win)
end

function p.tele_from_respawn_point_cancel_while_loop()
    --Assume the teleportation worked.
    ga_move_set_body_spirit_off()
    return false --End the while loop.
end
