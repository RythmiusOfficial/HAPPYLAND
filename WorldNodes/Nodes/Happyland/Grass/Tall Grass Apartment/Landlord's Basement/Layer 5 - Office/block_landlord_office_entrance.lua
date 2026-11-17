function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_concrete"
end

function p.__main()
    set_default_block("landlord_office_air")
    
    -- Create structure
    std.create_shell("r_concrete")
    create_rect("plug", 1,1,15, 14,14,15)

    -- Create hallway
    create_rect("r_concrete", 1,12,1, 14,15,14)
    create_rect("landlord_office_air", 6,12,1, 9,15,14)
end