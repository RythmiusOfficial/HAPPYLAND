function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green"
end

function p.__main()
    set_default_block("r_orange")

    -- Carve out the tunnel
    create_rect("happy_tube_air", 0,5,5, 15,10,10)
end
