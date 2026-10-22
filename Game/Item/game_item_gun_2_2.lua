function p.use()
    local mode = 2
    return game_item_gun_2_1.use_common(mode)
end

function p.get_use_period()
    return game_wep_modes.get_fire_period(2,2)
end
