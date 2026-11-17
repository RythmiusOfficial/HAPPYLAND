function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_concrete"
end

function p.__main()
    set_default_block("r_concrete")
    create_sprinkles(0,0,0, 15,15,15, 0.2, "r_dark_gray")
    
    -- Create structure
    create_rect("e", 1,1,1, 14,14,14)
    create_rect("plug", 1,1,15, 14,14,15)

    -- Create hallway
    create_rect("r_concrete", 1,12,1, 14,15,14)
    create_rect("landlord_office_air", 6,12,1, 9,15,14)
end