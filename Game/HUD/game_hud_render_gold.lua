function p.render_gold(wid)
    game_hud_render_ammo.set_txt_size(wid)

    -- Gold.

    local ammo_y_min = game_hud_render_ammo.get_ammo_y_min()
    local ammo_width = game_hud_render_ammo.get_ammo_width()
    local ammo_height = game_hud_render_ammo.get_ammo_height()

    local col_red    = std.vec(1.0, 0.0, 0.0)
    local col_yellow = std.vec(1.0, 1.0, 0.0)
    local col_green  = std.vec(0.0, 1.0, 0.0)

    x_min = 0.94
    local gold = ga_get_i("xar.player.gold.amount");
    if ga_get_b("xar.hud.show_gold") then
        ga_win_quad(wid, 
            x_min,
            ammo_y_min,
            x_min + ammo_width,
            ammo_y_min + ammo_height,
            "icon_gold");
        if     (gold < 100)  then col = col_red
        elseif (gold < 1000) then col = col_yellow
        else                      col = col_green
        end
        win_hud.txt_col(wid, col)
        -- display_gold = gold
        -- if( gold > 99999 ) then display_gold = 99999 end
        local short_str = game_str.make_3_digit_big(gold)
        ga_win_txt_center_at_bg(wid, 
            x_min + 0.5 * ammo_width,
            ammo_y_min + ammo_height,
            short_str)
    end
end
