function p.use()
    local mode = 4
    return game_item_gun_7_1.use_common(mode)
end

function p.get_use_period()
    return game_wep_modes.get_fire_period(7,4)
end
