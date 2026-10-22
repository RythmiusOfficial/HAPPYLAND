function p.drop_genesis_marker_short()
    --Dealing with cost.
    local long_marker_cost = 20
    if not ga_get_b("xar.cheat.free_markers") then
        local gold = ga_get_i("xar.player.gold.amount")
        if (gold < long_marker_cost) then return end
        ga_set_i("xar.player.gold.amount", gold - long_marker_cost)
    end

    --Sound.
    ga_play_sound("marker_short");

    local game_time = ga_get_sys_f("game.time.total")
    local remove_time = game_time + (60.0 * 60.0 * 3.0) --3 hours.

    -- Dropping a new ment.
    local viewer_level = ga_get_viewer_level()
    local offset = ga_get_viewer_offset()
    -- local bp = ga_get_viewer_bp(viewer_level)

    --ga_bent_add(
    --    viewer_level, bp,
    --    "bent_genesis_marker_short",
    --    remove_time)

    --Adding a moving entity.
    ga_ment_start(
        viewer_level, offset,
        "ment_marker_short")
    ga_ment_init_set_v("posv", offset)
    ga_ment_init_set_f("ttl", 3.0 * 3600.0) --3 hours.
    ga_ment_end()
end

function p.drop_genesis_marker_long()
    --Dealing with cost.
    local long_marker_cost = 50
    if not ga_get_b("xar.cheat.free_markers") then
        local gold = ga_get_i("xar.player.gold.amount")
        if (gold < long_marker_cost) then return end
        ga_set_i("xar.player.gold.amount", gold - long_marker_cost)
    end

    --Sound.
    ga_play_sound("marker_long");

    local game_time = ga_get_sys_f("game.time.total")
    local remove_time = game_time + 60.0 * 60.0 * 3.0 --3 hours.

    local viewer_level = ga_get_viewer_level()

    -- Dropping a new ment.
    local viewer_level = ga_get_viewer_level()
    local offset = ga_get_viewer_offset()
    -- local bp = ga_get_viewer_bp(viewer_level)

    -- ga_bent_add(
    --     viewer_level, bp,
    --     "bent_genesis_marker_long",
    --     remove_time)

    ga_ment_start(
        viewer_level, offset,
        "ment_marker_long")
    ga_ment_end()
end

function p.drop_marker_short()
    if( game_genesis.enabled() ) then
        p.drop_genesis_marker_short()
        return
    end

    --Dealing with gold.
    if not ga_get_b("xar.cheat.free_markers") then
        if ga_get_i("xar.player.markers.num_short") > 0 then
            std.set_bydelta_i("xar.player.markers.num_short", -1)
        else
            local gold = ga_get_i("xar.player.gold.amount")
            local cheap_cost = 10
            if ga_get_b("xar.player.cheat_comon_markers") then
                cheap_cost = 5
            end
            if (gold < cheap_cost) then return end
            ga_set_i("xar.player.gold.amount", gold - cheap_cost)
        end
    end
    
    -- Dropping a new ment.
    local viewer_level = ga_get_viewer_level()
    local offset = ga_get_viewer_offset()

    ga_ment_start(
        viewer_level, offset,
        "ment_marker_short")

    ga_ment_init_set_v("posv", offset)
    -- ga_ment_init_set_b("lasting", true) --Don't need to do anymore.
    ga_ment_init_set_f("ttl", 3.0 * 3600.0) --3 hours.
    --ga_ment_set_random_code_id() --Don't need to do anymore.

    ga_ment_end()

    ga_print("game_drop_markers.drop_marker_short e")

    --Playing a sound.
    ga_play_sound("marker_short");

    ga_print("game_drop_markers.drop_marker_short end")
end

function p.drop_marker_long()
    if( game_genesis.enabled() ) then
        p.drop_genesis_marker_long()
        return
    end

    --Dealing with gold.
    local long_marker_cost = 20
    if not ga_get_b("xar.cheat.free_markers") then
        local gold = ga_get_i("xar.player.gold.amount")
        if (gold < long_marker_cost) then return end
        ga_set_i("xar.player.gold.amount", gold - long_marker_cost)
    end

    -- Dropping a new ment.
    local viewer_level = ga_get_viewer_level()
    local offset = ga_get_viewer_offset()

    ga_ment_start(
        viewer_level, offset,
        "ment_marker_long")
    ga_ment_end()

    --Playing a sound.
    ga_play_sound("marker_long");
end

function p.enabled_cheap_common_markers()
    if ga_get_b("xar.player.cheat_comon_markers") then return end
    ga_play_sound("buy")
    ga_set_b("xar.player.cheat_comon_markers", true)
end
