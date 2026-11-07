function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_rug_2"
end

function p.__main()
    set_default_block("r_rug_2")

    -- Detailing and carving
    create_rect("r_black", 5,5,0, 10,10,0)
    create_rect("e", 6,6,0, 9,9,7)
    create_rect("e", 6,6,7, 15,9,7)

    -- antiplugs
    create_rect("anti_plug", 6,6,1, 9,9,1)
    create_rect("expander", 6,6,0, 9,9,0)
end