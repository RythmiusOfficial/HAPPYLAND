function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green"
end

function p.__main()
    set_default_block("r_green")

    -- Carve out the tunnel
    create_rect("happy_air", 0,6,6, 15,9,9)
end
