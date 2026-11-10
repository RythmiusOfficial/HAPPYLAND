function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("e")
    std.create_edges("r_expander")

    add_bent(3,3,3, "bent_base_ring_red")
    add_bent(11,3,3, "bent_base_ring_red")
    add_bent(3,11,3, "bent_base_ring_red")
    add_bent(11,11,3, "bent_base_ring_red")

    -- apartment key guard
    ment_start(7,7,7, "ment_key_guard_apartment")
    ment_set_offset(8,8,8)
    ment_end()
end