function p.render_health(wid)
    game_hud_render_ammo.set_txt_size(wid)

    local ammo_y_min = game_hud_render_ammo.get_ammo_y_min()
    local ammo_width = game_hud_render_ammo.get_ammo_width()
    local ammo_height = game_hud_render_ammo.get_ammo_height()

    local col_white  = std.vec(1.0, 1.0, 1.0)
    local col_red    = std.vec(1.0, 0.0, 0.0)
    local col_yellow = std.vec(1.0, 1.0, 0.0)
    local col_green  = std.vec(0.0, 1.0, 0.0)
    local col_blue   = std.vec(0.0, 0.25, 1.0)
    local col_cyan   = std.vec(0.0, 1.0, 1.0)

    -- Health.
    local x_min = 0.075
    local health = ga_get_i("xar.player.health.amount")
    local health_max = ga_get_i("xar.player.health.max")
    local value_1 = 0
    local value_2 = health_max
    local value_3 = health_max * 2
    local value_4 = health_max * 5
    local frac = 0.0
    local tex1 = ""
    local tex2 = ""
    if( health < value_2 ) then
        frac = (health - value_1) / (value_2 - value_1)
        tex1 = "icon_health"
        tex2 = "icon_health_red"
        if (health <= value_1) then frac = 0.0 end
    elseif( health <= value_3 ) then
        frac = (health - value_2) / (value_3 - value_2)
        tex1 = "icon_health_blue"
        tex2 = "icon_health"
    else
        frac = (health - value_3) / (value_4 - value_3)
        tex1 = "icon_health_dark_blue"
        tex2 = "icon_health_blue"
    end
    if ga_get_b("xar.hud.show_health") and (not game_genesis.enabled()) then
        ga_win_quad_two(wid, 
            x_min,
            ammo_y_min,
            x_min + ammo_width,
            ammo_y_min + ammo_height,
            tex1, tex2, frac)
    end
    if     (health <= health_max/4) then col = col_red
    elseif (health <= health_max/2) then col = col_yellow
    elseif (health <= health_max  ) then col = col_green
    elseif (health <= health_max*2) then col = col_blue
    else                                 col = col_cyan
    end
    if ga_get_b("xar.hud.show_health") and (not game_genesis.enabled()) then
        win_hud.txt_col(wid, col)
        local short_str = game_str.make_3_digit_big(health)
        ga_win_txt_center_at_bg(wid, 
            x_min + 0.5 * ammo_width,
            ammo_y_min + ammo_height,
            short_str)
    end
end
