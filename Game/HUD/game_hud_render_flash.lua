function p.render_flash(wid)
    --Flash of light.
    local flash_time_1 = ga_get_f("xar.hud.flash.last_time")
    local flash_time_2 = flash_time_1 + ga_get_f("xar.hud.flash.duration")
    local game_time = ga_get_game_time()
    if( game_time >= flash_time_1 and
        game_time <= flash_time_2 )
    then
        local frac = (game_time - flash_time_1)
            / (flash_time_2 - flash_time_1)
        local start_alpha = ga_get_f("xar.hud.flash.alpha")
        local flash_alpha = (1.0 - frac) * start_alpha
        local flash_col = std.vec(1.0, 1.0, 1.0)
        --
        local old_mode = ga_win_get_screen_coord_mode(wid)
        ga_win_set_screen_coord_mode(wid, "screen")
        ga_win_quad_color_alpha(wid, 0.0, 0.0, 1.0, 1.0, flash_col, flash_alpha)
        ga_win_set_screen_coord_mode(wid, old_mode)
    end
end
