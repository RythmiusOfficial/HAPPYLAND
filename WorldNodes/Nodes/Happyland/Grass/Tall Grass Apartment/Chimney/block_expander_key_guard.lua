function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("e")
    -- Create glass and tubes to prevent cheesing
    create_rect("glass", 0,0,1, 15,15,1)
    create_rect("r_concrete", 2,2,1, 4,4,5)
    create_rect("e", 3,3,1, 3,3,5)
    create_rect("r_concrete", 10,2,1, 12,4,5)
    create_rect("e", 11,3,1, 11,3,5)
    create_rect("r_concrete", 2,10,1, 4,12,5)
    create_rect("e", 3,11,1, 3,11,5)
    create_rect("r_concrete", 10,10,1, 12,12,5)
    create_rect("e", 11,11,1, 11,11,5)

    -- tops of tubes
    create_rect("r_black", 1,1,7, 5,5,7)
    create_rect("glass", 2,2,7, 4,4,7)
    create_rect("r_black", 9,1,7, 13,5,7)
    create_rect("glass", 10,2,7, 12,4,7)
    create_rect("r_black", 1,9,7, 5,13,7)
    create_rect("glass", 2,10,7, 4,12,7)
    create_rect("r_black", 9,9,7, 13,13,7)
    create_rect("glass", 10,10,7, 12,12,7)

    std.create_edges("r_expander")

    add_bent(3,3,0, "bent_base_ring_red")
    add_bent(11,3,0, "bent_base_ring_red")
    add_bent(3,11,0, "bent_base_ring_red")
    add_bent(11,11,0, "bent_base_ring_red")

    -- apartment key guard
    ment_start(7,7,15, "ment_key_guard_apartment")
    ment_set_offset(8,8,15)
    ment_end()
end