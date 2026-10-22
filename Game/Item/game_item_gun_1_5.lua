function p.use()
    local mode = 5
    return game_item_gun_1_1.use_common(mode)
end

function p.get_use_period()
    return game_wep_modes.get_fire_period(1,5)
end
