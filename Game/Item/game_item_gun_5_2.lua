function p.use()
    local cur_gun = 5
    local mode = 2

    --Making sure can use the weapon mode.
    if( not game_wep_modes.has_wep_mode(cur_gun, mode) ) then
        return false
    end

    --Making sure have enough ammo.
    if not game_item_gun_1_1.ammo_check_common(cur_gun, mode) then return false end

    --Grep for "xar.player.gun5.bucket.1".
    --Adding one homing rocket to each of the "buckets".
    --An update function will do the "bucket brigade".
    for i = 1,20 do
        local var = "xar.player.gun5.bucket." .. tostring(i)
        std.set_bydelta_i(var, 1) --Adding one to the var.
    end

    --Spending ammo.
    local ammo_var = "xar.player.gun" .. tostring(cur_gun) .. ".ammo"
    local req_ammo = game_wep_modes.get_ammo_per_fire(cur_gun, mode)
    std.set_bydelta_i(ammo_var, -req_ammo)

    game_play_wep_sound.play(cur_gun, mode)

    return true
end

function p.get_use_period()
    return game_wep_modes.get_fire_period(5,2)
end

function p.update()
    local game_time = ga_get_sys_f("game.time.total")
    local next_release_time = ga_get_f("xar.player.gun5.bucket.next_release_time")

    --Saftey.
    if( game_time + 1.0 < next_release_time ) then
        next_release_time = game_time
        ga_set_f("xar.player.gun5.bucket.next_release_time", next_release_time)
    end

    if( game_time > next_release_time ) then
        local wait = 0.1
        ga_set_f("xar.player.gun5.bucket.next_release_time", game_time + wait)

        --Releasing them.
        local num_release = ga_get_i("xar.player.gun5.bucket.1")
        local viewer_chunk_id = ga_get_viewer_chunk_id()
        local viewer_level = ga_chunk_id_to_level(viewer_chunk_id)
        local viewer_pos = ga_get_viewer_offset()
        local speed = game_wep_modes.get_vel(5,2)
        local raw_damage = game_wep_modes.get_curved_shot_damage(5,2) --NOT get_curved_damage!
        local damage = game_damage.calc_damage_from_player(raw_damage, true) --Allowing powerups.
        -- damage_no_powerups = game_damage.calc_damage_from_player(raw_damage, false)
        for i = 1,num_release do
            local extend_len = 2.0
            local look = ga_get_sys_v("game.player.camera.look")
            local pos = std.vec_add(viewer_pos, std.vec_scale(look,extend_len))

            ga_ment_start(viewer_level, pos, "ment_player_proj_homing_2")
            -- local vel = std.vec_scale(dir, speed)
            -- ga_ment_init_set_v("__vel", vel) --No longer need to set an initial vel.
            ga_ment_init_set_f("__homing_speed", speed)
            --Old way.
            -- ga_ment_init_set_i("damage", damage)
            -- ga_ment_init_set_i("damage2", 1)
            --New way.
            ga_ment_init_set_i("damage", 1) --The damage handled by the main engine.
            ga_ment_init_set_i("damage2", damage) --Custom damage.
    
            ga_ment_end()
        end

        --Bucket brigade.
        --Grep for xar.player.gun5.bucket.1.
        for i = 1,19 do
            local var1 = "xar.player.gun5.bucket." .. tostring(i)
            local var2 = "xar.player.gun5.bucket." .. tostring(i+1)
            ga_set_i(var1, ga_get_i(var2))
        end
        ga_set_i( "xar.player.gun5.bucket.20", 0 )
    end
end
