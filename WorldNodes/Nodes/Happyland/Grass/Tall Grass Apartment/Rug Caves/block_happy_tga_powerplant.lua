function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_rug_3"
end

function p.__main()
    set_default_block("grow_air")

    -- Floor
    create_rect("r_rug_3", 0,0,0, 15,15,0)

    -- Structure
    create_rect("r_rug_3", 6,7,1, 9,9,4)
    create_rect("happy_rug_caves_2_internal", 7,8,1, 8,8,4)

    -- Entrance
    set_pos(6,8,1, "happy_tga_pp_entrance")

    -- Exit
    set_pos(7,8,5, "happy_tga_pp_exit")
    set_pos(8,8,5, "happy_tga_pp_room")

    -- Pink dest
    add_bent(11,8,1, "bent_base_ring_pink_dest")

    -- Shrink ring
    add_bent(4,8,1, "bent_base_ring_green")
end