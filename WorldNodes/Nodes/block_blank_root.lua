function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("s")
    create_rect("e", 1,1,1, 14,14,14)

    -- --Solid boring block.
    -- -- set_pos(2,2,13, "s")

    set_pos(7,7,5, "happy_land_0")
    set_pos(7,7,0, "e")
    set_pos(7,7,15, "e")
    set_pos(7,0,7, "e")
    set_pos(7,15,7, "e")
    set_pos(0,7,7, "e")
    set_pos(15,7,7, "e")

    -- clear_blocks("e")

    add_bent_s(2,2,11, "bent_base_waypoint", "Top Of World")
    add_bent(2,2,9, "bent_base_respawn_point")
    add_bent(2,2,7, "bent_base_ring_pink_dest")
    add_bent(7,7,6, "bent_base_ring_green_danger")
    set_blue_type_terminal(2,2,5);
end
