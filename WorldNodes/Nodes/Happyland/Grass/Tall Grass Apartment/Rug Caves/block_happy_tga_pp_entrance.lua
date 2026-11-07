function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_rug_2"
end

function p.__main()
    set_default_block("r_rug_2")

    -- Key Guard
    ment_start(8,8,8, "ment_key_guard_apartment")
    ment_set_offset(8,8,8)
    ment_end()

    -- Detailing and carving
    create_rect("r_black", 0,3,3, 0,12,12)
    create_rect("e", 0,4,4, 15,11,11)

    -- plug wall
    create_rect("plug", 15,4,4, 15,11,11)
    add_bent(14,8,8, "bent_base_ring_green")
end