function p.render_armor(wid)
    -- Armor.

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

    local x_min = 0.135
    local armor = ga_get_i("xar.player.armor.amount")
    local armor_max = ga_get_i("xar.player.armor.max")
    local value_1 = 0
    local value_2 = armor_max
    local value_3 = armor_max * 2
    local value_4 = armor_max * 10
    local frac = 0.0
    local tex1 = ""
    local tex2 = ""
    if( armor < value_2 ) then
        frac = (armor - value_1) / (value_2 - value_1)
        tex1 = "icon_armor"
        tex2 = "icon_armor_grey"
        if (armor <= value_1) then frac = 0.0 end
    elseif( armor <= value_3 ) then
        frac = (armor - value_2) / (value_3 - value_2)
        tex1 = "icon_armor_two"
        tex2 = "icon_armor"
    else
        frac = (armor - value_3) / (value_4 - value_3)
        tex1 = "icon_armor_three"
        tex2 = "icon_armor_two"
    end
    if ga_get_b("xar.hud.show_health") and (not game_genesis.enabled()) then
        ga_win_quad_two(wid, 
            x_min,
            ammo_y_min,
            x_min + ammo_width,
            ammo_y_min + ammo_height,
            tex1, tex2, frac)
    end
    if     (armor <= armor_max/4) then col = col_red
    elseif (armor <= armor_max/2) then col = col_yellow
    elseif (armor <= armor_max  ) then col = col_green
    elseif (armor <= armor_max*2) then col = col_blue
    else                               col = col_cyan
    end
    if ga_get_b("xar.hud.show_health") and (not game_genesis.enabled()) then
        win_hud.txt_col(wid, col)
        local short_str = game_str.make_3_digit_big(armor)
        ga_win_txt_center_at_bg(wid, 
            x_min + 0.5 * ammo_width,
            ammo_y_min + ammo_height,
            short_str)
    end
end
