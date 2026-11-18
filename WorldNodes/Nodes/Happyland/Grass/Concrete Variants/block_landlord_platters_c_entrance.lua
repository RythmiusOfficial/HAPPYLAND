function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_dark_gray"
end

function p.__main()
    set_default_block("r_dark_gray")
    
    -- Carve out tunnel
    create_rect("landlord_office_air", 1,1,1, 14,14,15)

    -- Create windows
    create_rect("landlord_office_air", 6,0,6, 8,0,8)

    create_rect("landlord_office_air", 6,15,6, 8,15,8)

    create_rect("landlord_office_air", 0,6,6, 0,8,8)

    create_rect("landlord_office_air", 15,6,6, 15,8,8)
end