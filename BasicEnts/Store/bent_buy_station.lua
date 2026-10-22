function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Buy Station"
end

function p.__on_use(level, bp)
    ga_play_sound_menu("use")
    --ga_create_i("xar.ent.buy_marker.price")
    --ga_set_i("xar.ent.buy_marker.price", 1)
    ga_window_push("win_buy_station")
end
