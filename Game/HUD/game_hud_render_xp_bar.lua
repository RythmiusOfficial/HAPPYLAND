function p.render_xp_bar(wid)
    local col_green  = std.vec(0.0, 1.0, 0.0)

    --Experience bar.
    local xp1 = ga_get_i("xar.experience.to_next_level")
    local xp2 = ga_get_i("xar.experience.to_next_level_max")
    local xp_frac = 1.0 - (xp1 / xp2)
    if ga_get_b("xar.hud.show_experience") and (not game_genesis.enabled()) then
        ga_win_quad_two(wid, 
            0.97, --x_min
            0.16, --y_min
            0.99, --x_max
            0.5,  --y_max
            "icon_xp", "icon_xp_back", xp_frac)
    end
    --Displaying the level.
    local player_level = ga_get_i("xar.experience.level")
    if ga_get_b("xar.hud.show_experience") and (not game_genesis.enabled()) then
        local xp_level_center_x = 0.98
        if( player_level >= 1000 ) then xp_level_center_x = 0.97 end
        win_hud.txt_col(wid, col_green)
        ga_win_txt_center_at_bg(wid, 
            xp_level_center_x, --x center
            0.51, --y min
            tostring(player_level))
    end
    --Asking player to press F4 if needed.
    local last_milestone_level = player_level - (player_level % 10)
    local last_claimed_milestone = ga_get_i("xar.experience.last_claimed_milestone_level")
    if( last_claimed_milestone < last_milestone_level ) then
        local game_time = ga_get_game_time()
        local rem = math.floor(game_time) % 2
        if( rem == 0 ) then
            ga_win_txt_center_at_bg(wid, 
                0.945, --center x
                0.54, --y min
                "PRESS F4")
        end
    end
    -- XP from last second.
    --USE A HELPER FUNCTION FOR THIS DIGIT STUFF!!!
    local xp_last_sec = ga_get_i("xar.experience.last_second")
    local num_digits = 1
    if( xp_last_sec < 10 ) then num_digits = 1
    elseif( xp_last_sec < 100 ) then num_digits = 2
    elseif( xp_last_sec < 1000 ) then num_digits = 3
    elseif( xp_last_sec < 10000 ) then num_digits = 4
    elseif( xp_last_sec < 100000 ) then num_digits = 5
    elseif( xp_last_sec < 1000000 ) then num_digits = 6
    elseif( xp_last_sec < 10000000 ) then num_digits = 7
    elseif( xp_last_sec < 100000000 ) then num_digits = 8 end
    local xp_x = 0.92
    if( num_digits == 1 ) then xp_x = 0.98 end
    if( num_digits == 2 ) then xp_x = 0.98 end
    if( num_digits == 3 ) then xp_x = 0.975 end
    if( num_digits == 4 ) then xp_x = 0.97 end
    if( num_digits == 5 ) then xp_x = 0.965 end
    if( num_digits == 6 ) then xp_x = 0.96 end
    if( num_digits == 7 ) then xp_x = 0.955 end
    if( num_digits == 8 ) then xp_x = 0.95 end
    win_hud.txt_col(wid, col_green)
    if ga_get_b("xar.hud.show_experience") and (not game_genesis.enabled()) then
        local short_str = game_str.make_3_digit_big(xp_last_sec)
        ga_win_txt_center_at_bg(wid, xp_x, 0.13, tostring(short_str))
        -- ga_win_txt_center_at_bg(wid, xp_x, 0.13, tostring(xp_last_sec))
    end
end
