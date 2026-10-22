function p.get_price(level, bp)
    return ga_bent_get_param_i(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    local price = p.get_price(level, bp)
    return "Buy A Blue Key for " .. tostring(price) .. " gold"
end

function p.__on_use(level, bp)
    ga_play_sound_menu("use")
    local price = p.get_price(level, bp)
    ga_create_i("temp.xar.ent.buy_blue_key.price")
    ga_set_i(   "temp.xar.ent.buy_blue_key.price", price)
    ga_window_push("win_buy_blue_key")
end
