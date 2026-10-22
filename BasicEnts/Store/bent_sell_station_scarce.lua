function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Scarce Sell Station"
end

function p.__on_use(level, bp)
    ga_play_sound_menu("use")
    
    local seed = ga_block_seed_pos(level, bp) --New way.
    ga_srand(seed)
    
    bent_sell_station_common.helper2(1)

    ga_window_push("win_sell_station")
end
