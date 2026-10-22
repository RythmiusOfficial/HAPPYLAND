function p.set_default_fly_mode()
    --Setting camera mode to use true up.
    local trans = std.vec(0.0, 0.0, 0.0)
    local radius = 0.3
    local use_true_up = true
    ga_move_set_body_fly(trans, radius, use_true_up)
end
