function p.stop_back_hole_drive()
    local game_time = ga_get_game_time()
    local end_time_var = "xar.player.gun0.black_hole_drive_end"
    ga_set_f(end_time_var, game_time - 1.0)
end

--Returns whether or not an alternate level radius
--WOULD be used if the player was in black hole drive mode.
function p.get_uses_alt_radius()
    local var = "movement.black_hole_drive.uses_alt_radius"
    ga_package_init_b(var, true)
    return ga_package_get_b(var)
end

function p.toggle_uses_alt_radius()
    local var = "movement.black_hole_drive.uses_alt_radius"
    ga_package_init_b(var, true)
    local old_value = ga_package_get_b(var)
    local new_value = not old_value
    ga_package_set_b(var, new_value)
end

--The radius we should use for the "finest level of detail"
--when the player is in black hole drive mode.
function p.get_alt_radius()
    local var = "movement.black_hole_drive.alt_radius"
    ga_package_init_i(var, 3)
    return ga_package_get_i(var)
end

function p.set_alt_radius(new_radius)
    local var = "movement.black_hole_drive.alt_radius"
    ga_package_init_i(var, 3)
    return ga_package_set_i(var, new_radius)
end
