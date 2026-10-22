function p.render_hive_attack_meter(wid)
    if game_genesis.enabled() then return end

    local ammo_y_min = game_hud_render_ammo.get_ammo_y_min()
    local ammo_width = game_hud_render_ammo.get_ammo_width()
    local ammo_height = game_hud_render_ammo.get_ammo_height()

    --Hive attack meter.
    local x_min = 0.002
    local hive_frac = game_ment_hive_attack.get_frac()
    ga_win_quad_two(wid,
        x_min, ammo_y_min,
        x_min + 0.01, ammo_y_min + ammo_height,
        "icon_hive_attack_bar", "icon_hive_attack_bar_back", hive_frac)
end
