function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_concrete"
end

function p.__main()
    set_default_block("r_concrete")

    -- Create carving
    -- Because the Apartment Key variant of the halls both sit on the y, no checks need to be made and it
    -- can be safe to assume that it will never need to open up on the x
    create_rect("landlord_office_air", 6,0,1, 9,15,14)

    -- Apartment Key Guard
    ment_start(7,7,7, "ment_key_guard_apartment")
    ment_set_offset(8,8,8)
    ment_end()
end