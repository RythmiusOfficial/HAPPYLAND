function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green"
end

function p.__main()
    set_default_block("happy_grass_tube_1")

    -- Carve out the tunnel
    create_rect("happy_tube_air", 0,6,6, 15,9,9)

    -- Create even more medium grass
    create_rect("happy_medium_grass", 0,6,6, 15,9,6)
end
