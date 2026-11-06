function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green_x"
end

function p.__main()
    set_default_block("r_green")
    
    -- Create chimney layout
    create_rect("r_green_x", 4,4,1, 12,12,15)
    create_rect("happy_smokey_air", 5,5,1, 11,11,15)

    -- Dust
    for x = 5,11 do
    for y = 5,11 do
    for z = 1,15 do
        create_sprinkles(5,5,1, 11,11,4, 0.2, "dust")
    end end end

    -- hole
    set_pos(7,7,0, "expander")
end