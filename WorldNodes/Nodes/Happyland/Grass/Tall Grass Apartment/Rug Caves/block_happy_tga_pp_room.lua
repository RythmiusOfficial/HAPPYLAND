function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_rug_2"
end

function p.__main()
    set_default_block("e")

    -- Structure
    std.create_shell("r_rug_2")

    -- Hole
    create_rect("r_black", 0,4,4, 0,11,11)
    create_rect("e", 0,6,7, 0,9,7)

    -- Treasure placeholder
    -- Waypoint
    -- REALLY Long Apartment Key
    -- Breaker Box
    -- Pink Ring
end