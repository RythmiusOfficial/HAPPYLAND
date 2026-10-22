function p.get_price(level, bp)
    return ga_bent_get_param_i(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    local price = p.get_price(level, bp)
    return "Pay " .. tostring(price) .. " Toll"
end

function p.__on_use(level, bp)
    ga_play_sound_menu("use")
    --
    local price = p.get_price(level, bp)
    ga_create_i("temp.xar.ent.pay_toll.price")
    ga_set_i(   "temp.xar.ent.pay_toll.price", price)
    --
    ga_create_i("temp.xar.ent.pay_toll.level")
    ga_set_i(   "temp.xar.ent.pay_toll.level", level)
    --
    ga_create_i("temp.xar.ent.pay_toll.bp.x")
    ga_set_i(   "temp.xar.ent.pay_toll.bp.x", bp.x)
    --
    ga_create_i("temp.xar.ent.pay_toll.bp.y")
    ga_set_i(   "temp.xar.ent.pay_toll.bp.y", bp.y)
    --
    ga_create_i("temp.xar.ent.pay_toll.bp.z")
    ga_set_i(   "temp.xar.ent.pay_toll.bp.z", bp.z)
    --
    --This way the change will also take place
    --in the PARENT chunk.
    bent_pay_toll.init_use_level_vars(1)
    --
    ga_window_push("win_pay_toll")
end
