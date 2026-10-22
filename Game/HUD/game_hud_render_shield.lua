function p.render_shield(wid)
    game_hud_render_ammo.set_txt_size(wid)

    local ammo_y_min = game_hud_render_ammo.get_ammo_y_min()
    local ammo_width = game_hud_render_ammo.get_ammo_width()
    local ammo_height = game_hud_render_ammo.get_ammo_height()

    local col_red    = std.vec(1.0, 0.0, 0.0)
    local col_yellow = std.vec(1.0, 1.0, 0.0)
    local col_green  = std.vec(0.0, 1.0, 0.0)

    local x_min = 0.015
    local shield     = ga_get_i("xar.player.shield.amount")
    local shield_max = ga_get_i("xar.player.shield.max")
    local frac = shield / shield_max
    if ga_get_b("xar.hud.show_health") and (not game_genesis.enabled()) then
        ga_win_quad_two(wid, 
            x_min,
            ammo_y_min,
            x_min + ammo_width,
            ammo_y_min + ammo_height,
            "icon_shield", "icon_shield_grey", frac)
    end
    local col = std.vec(0.0, 0.0, 0.0)
    if     (shield < shield_max/4) then col = col_red
    elseif (shield < shield_max/2) then col = col_yellow
    else                                col = col_green
    end
    if ga_get_b("xar.hud.show_health") and (not game_genesis.enabled()) then
        win_hud.txt_col(wid, col)
        local short_str = game_str.make_3_digit_big(shield)
        ga_win_txt_center_at_bg(wid, 
            x_min + 0.5 * ammo_width,
            ammo_y_min + ammo_height,
            short_str)
    end
end
