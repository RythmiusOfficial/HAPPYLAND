function p.use()
    local mode = 2
    return game_item_gun_8_1.use_common(mode)
end

function p.get_use_period()
    return game_wep_modes.get_fire_period(8,2)
end
