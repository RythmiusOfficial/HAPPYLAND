function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_happy_land"
end

function p.__main()
    set_default_block("r_green_deco")
    create_rect("e", 1,1,1, 14,14,14)
    
    -- create entry tunnel
    create_rect("r_green_deco", 6,6,1, 8,8,14)
    -- carve out tunnel
    create_rect("e", 7,7,10, 7,7,15)
    -- happy land air
    create_rect("happy_start_hooks", 7,7,1, 7,7,9)

    -- plug and shrink
    set_pos(7,7,10, "plug")
    add_bent(7,7,11, "bent_base_ring_green_danger")

    -- antiplug
    set_pos(7,7,15, "anti_plug")
end
