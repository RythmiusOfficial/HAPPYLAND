function p.pressed_or_spammed(wid, key)
    local init_wait = 1.0
    local subsequent_wait = 0.05
    return ga_win_key_pressed_or_spammed(
        wid, key, init_wait, subsequent_wait)
end
