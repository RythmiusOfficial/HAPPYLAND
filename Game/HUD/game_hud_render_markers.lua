function p.render_markers(wid)
    -- Markers.

    game_hud_render_ammo.set_txt_size(wid)

    local ammo_y_min = game_hud_render_ammo.get_ammo_y_min()
    local ammo_width = game_hud_render_ammo.get_ammo_width()
    local ammo_height = game_hud_render_ammo.get_ammo_height()

    local col_red    = std.vec(1.0, 0.0, 0.0)
    local col_yellow = std.vec(1.0, 1.0, 0.0)
    local col_green  = std.vec(0.0, 1.0, 0.0)

    x_min = 0.88
    local markers = ga_get_i("xar.player.markers.num_short");
    if ga_get_b("xar.hud.show_markers") and (not game_genesis.enabled()) then
        ga_win_quad(wid, 
            x_min,
            ammo_y_min,
            x_min + ammo_width,
            ammo_y_min + ammo_height,
            "icon_markers");
    end
    if     (markers < 10)  then col = col_red
    elseif (markers < 100) then col = col_yellow
    else                        col = col_green
    end
    if ga_get_b("xar.hud.show_markers") and (not game_genesis.enabled()) then
        win_hud.txt_col(wid, col)
        local short_str = game_str.make_3_digit_big(markers)
        ga_win_txt_center_at_bg(wid, 
            x_min + 0.5 * ammo_width,
            ammo_y_min + ammo_height,
            short_str)
    end
end
