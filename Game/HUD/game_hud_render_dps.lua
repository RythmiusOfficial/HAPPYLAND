function p.render_dps(wid)
    -- DPS (top middle of the screen).
    local in_dps = ga_get_sys_i("stats.in_dps")
    if( in_dps > 0 ) then
        local dps_str = "DPS: " .. game_str.add_commas(in_dps)
        ga_win_set_front_color(wid, std.vec(0.0, 1.0, 0.0))
        ga_win_set_char_size(wid, 0.02, 0.03)
        ga_win_txt_center(wid, 0.90, dps_str)
    end
    local max_health = ga_get_i("xar.player.health.max")
    local f = in_dps / max_health
    local icon_height = 0.05
    --icon_width is 0.04.
    local y_min = 0.84
    if( f >= 0.25 and f < 0.5 ) then
        ga_win_quad(wid, 0.48, y_min, 0.52, y_min+icon_height, "icon_skull")
    elseif( f >= 0.5 and f < 1.0 ) then
        ga_win_quad(wid, 0.45, y_min, 0.49, y_min+icon_height, "icon_skull")
        ga_win_quad(wid, 0.51, y_min, 0.55, y_min+icon_height, "icon_skull")
    elseif( f >= 1.0 and f < 2.0 ) then
        ga_win_quad(wid, 0.42, y_min, 0.46, y_min+icon_height, "icon_skull")
        ga_win_quad(wid, 0.48, y_min, 0.52, y_min+icon_height, "icon_skull")
        ga_win_quad(wid, 0.54, y_min, 0.58, y_min+icon_height, "icon_skull")
    elseif( f >= 2.0 ) then
        ga_win_quad(wid, 0.39, y_min, 0.43, y_min+icon_height, "icon_skull")
        ga_win_quad(wid, 0.45, y_min, 0.49, y_min+icon_height, "icon_skull")
        ga_win_quad(wid, 0.51, y_min, 0.55, y_min+icon_height, "icon_skull")
        ga_win_quad(wid, 0.57, y_min, 0.61, y_min+icon_height, "icon_skull")
    end
end
