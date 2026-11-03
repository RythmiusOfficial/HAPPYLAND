function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_expander"
end

function p.__main()
    set_default_block("e")
    std.create_edges("r_expander")

    add_bent(7,7,7, "bent_base_ring_red")
end