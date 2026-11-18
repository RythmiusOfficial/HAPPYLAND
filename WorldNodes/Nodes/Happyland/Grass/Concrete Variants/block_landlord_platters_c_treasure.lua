function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_dark_gray"
end

function p.__main()
    set_default_block("r_dark_gray")

    -- Carve out tunnel
    create_rect("landlord_office_air", 1,1,1, 14,14,14)

    -- Create hole
    create_rect("r_white", 6,6,0, 8,8,0)
    set_pos(7,7,0, "landlord_office_air")

    -- add ammo later please
end