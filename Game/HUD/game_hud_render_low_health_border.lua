function p.render_low_health_border(wid)
    local shield     = ga_get_i("xar.player.shield.amount")
    local shield_max = ga_get_i("xar.player.shield.max")
    local shield_frac = shield / shield_max
    local shield_danger_cutoff = ga_get_f("xar.hud.shield_danger_cutoff")
    local health = ga_get_i("xar.player.health.amount")
    local health_max = ga_get_i("xar.player.health.max")
    local health_frac = health / health_max
    local health_danger_cutoff = ga_get_f("xar.hud.health_danger_cutoff")
    local armor = ga_get_i("xar.player.armor.amount")
    local armor_max = ga_get_i("xar.player.armor.max")
    local armor_frac = armor / armor_max
    local armor_danger_cutoff = ga_get_f("xar.hud.armor_danger_cutoff")
    --
    local cur_showing_border = ga_get_b("xar.hud.showing_border")
    local next_showing_boarder =
      ( shield_frac < shield_danger_cutoff and
        health_frac < health_danger_cutoff and
        armor_frac < armor_danger_cutoff )
    if cur_showing_border ~= next_showing_boarder then
        --Attempting to make a change, but need to worry about epilepsy.
        if( game_flash.safe_for_flash_and_reg() ) then
            --It is epilepsy safe to make a change.
            ga_set_b("xar.hud.showing_border", next_showing_boarder)
            --Will take effect next cycle.
        end
    end
    if( cur_showing_border ) then
        --Making a red boarder around the screen.
        local red = std.vec(1.0, 0.0, 0.0)
        local alpha = 0.7
        local w_thick = 0.03
        local h_thick = 0.05
        ga_win_quad_color_alpha(wid, 0.0, 0.0, 1.0, h_thick, red, alpha)
        ga_win_quad_color_alpha(wid, 0.0, 1.0-h_thick, 1.0, 1.0, red, alpha)
        ga_win_quad_color_alpha(wid, 0.0, h_thick, w_thick, 1.0-h_thick, red, alpha)
        ga_win_quad_color_alpha(wid, 1.0-w_thick, h_thick, 1.0, 1.0-h_thick, red, alpha)
    end
end
