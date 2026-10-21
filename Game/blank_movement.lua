function p.set_true_up(use_true_up)
    local trans = std.vec(0.0, 0.0, 0.0)
    -- radius = ga_get_sys_f("game.player.move.fly.radius")
    local radius = 0.3
    ga_move_set_body_fly(trans, radius, use_true_up)
end

function p.input(str)
    if( str == "move forward start"  ) then ga_set_b("blank.movement.forward",  true)  end
    if( str == "move forward stop"   ) then ga_set_b("blank.movement.forward",  false) end
    if( str == "move back start"     ) then ga_set_b("blank.movement.back",     true)  end
    if( str == "move back stop"      ) then ga_set_b("blank.movement.back",     false) end
    if( str == "move left start"     ) then ga_set_b("blank.movement.left",     true)  end
    if( str == "move left stop"      ) then ga_set_b("blank.movement.left",     false) end
    if( str == "move right start"    ) then ga_set_b("blank.movement.right",    true)  end
    if( str == "move right stop"     ) then ga_set_b("blank.movement.right",    false) end
    if( str == "move up start"       ) then ga_set_b("blank.movement.up",       true)  end
    if( str == "move up stop"        ) then ga_set_b("blank.movement.up",       false) end
    if( str == "move down start"     ) then ga_set_b("blank.movement.down",     true)  end
    if( str == "move down stop"      ) then ga_set_b("blank.movement.down",     false) end
    if( str == "move spin_ccw start" ) then ga_set_b("blank.movement.spin_ccw", true)  end
    if( str == "move spin_ccw stop"  ) then ga_set_b("blank.movement.spin_ccw", false) end
    if( str == "move spin_cw start"  ) then ga_set_b("blank.movement.spin_cw",  true)  end
    if( str == "move spin_cw stop"   ) then ga_set_b("blank.movement.spin_cw",  false) end
    if( str == "move brake start"    ) then ga_set_b("blank.movement.brake",    true)  end
    if( str == "move brake stop"     ) then ga_set_b("blank.movement.brake",    false) end

    if( str == "move toggle_rocket"   ) then
        cur_value = ga_get_b("blank.movement.rocket")
        ga_set_b("blank.movement.rocket", not cur_value)
    end
end

function p.add_impulse(x,y,z)
    impulse = ga_get_v("blank.movement.extra_impulse")
    std.vec_add_eq(impulse, std.vec(x,y,z))
    ga_set_v("blank.movement.extra_impulse", impulse)
end

function p.update_discrete()
    --Spinning.
    spin_add = 0
    if ga_get_b("blank.movement.spin_cw") then spin_add = spin_add + 1 end
    if ga_get_b("blank.movement.spin_ccw") then spin_add = spin_add - 1 end
    spinning_angular_drag = 0.70 --0.85
    spin_value = ga_get_f("blank.movement.spin_value")
    spin_value = spin_value * spinning_angular_drag
    spin_value = spin_value + spin_add * 0.01 --Magic num.
    ga_set_f("blank.movement.spin_value", spin_value)
    -- ga_move_set_roll(spin_value)
    ga_move_set_roll(spin_value)

    --Translation movement.

    lpd = ga_get_sys_v("game.player.move.last_pos_diff")
    time_step = 0.04
    speed = std.length(lpd) / time_step

    --Extra impulse.
    extra_impl = ga_get_v("blank.movement.extra_impulse")
    lpd.x = lpd.x + extra_impl.x
    lpd.y = lpd.y + extra_impl.y
    lpd.z = lpd.z + extra_impl.z
    ga_set_v("blank.movement.extra_impulse", std.vec_zero())

    --Setting drag and magnitude of acceleration.
    primary_speed_cutoff = 6.0 --Not being used!
    if(
        ga_get_b("blank.movement.rocket") )
    then
        drag = 0.98
        m_acc = 0.2
    else
        drag = 0.95
        m_acc = 0.1
    end

    if ga_get_b("blank.movement.brake") then
        drag = 0.8
    end

    --Getting the acc due the pressing keys.

    vec_look = ga_get_sys_v("game.player.camera.look")
    vec_up   = ga_get_sys_v("game.player.camera.up")
    vec_left = ga_get_sys_v("game.player.camera.left")

    acc = {x=0.0, y=0.0, z=0.0}
    if ga_get_b("blank.movement.forward") then
        acc.x = acc.x + vec_look.x
        acc.y = acc.y + vec_look.y
        acc.z = acc.z + vec_look.z
    end
    if ga_get_b("blank.movement.back") then
        acc.x = acc.x - vec_look.x
        acc.y = acc.y - vec_look.y
        acc.z = acc.z - vec_look.z
    end
    if ga_get_b("blank.movement.left") then
        acc.x = acc.x + vec_left.x
        acc.y = acc.y + vec_left.y
        acc.z = acc.z + vec_left.z
    end
    if ga_get_b("blank.movement.right") then
        acc.x = acc.x - vec_left.x
        acc.y = acc.y - vec_left.y
        acc.z = acc.z - vec_left.z
    end
    if ga_get_b("blank.movement.up") then
        acc.x = acc.x + vec_up.x
        acc.y = acc.y + vec_up.y
        acc.z = acc.z + vec_up.z
    end
    if ga_get_b("blank.movement.down") then
        acc.x = acc.x - vec_up.x
        acc.y = acc.y - vec_up.y
        acc.z = acc.z - vec_up.z
    end

    --Normalizing acc vector.
    if ( std.length(acc) < 0.0001 ) then
        acc = {x=0.0, y=0.0, z=0.0}
    else
        std.normalize(acc)
    end

    speed_mod = 0.15
    acc.x = acc.x * m_acc * speed_mod
    acc.y = acc.y * m_acc * speed_mod
    acc.z = acc.z * m_acc * speed_mod

    --Scaled lpd.
    slpd = {}
    slpd.x = lpd.x * drag
    slpd.y = lpd.y * drag
    slpd.z = lpd.z * drag

    --Setting the travel.
    travel = {}
    travel.x = slpd.x + acc.x
    travel.y = slpd.y + acc.y
    travel.z = slpd.z + acc.z
    ga_move_set_desired_travel(travel)
end
