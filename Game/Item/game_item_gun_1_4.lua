function p.use()
    local mode = 4
    return game_item_gun_1_1.use_common(mode)
end

function p.get_use_period()
    return game_wep_modes.get_fire_period(1,4)
end
