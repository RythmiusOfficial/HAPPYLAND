function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green"
end

function p.__main()
    set_default_block("r_green")

    -- Carve out tunnel
    create_rect("happy_air", 1,1,1, 14,14,14)

    -- Create hole
    create_rect("r_black", 6,6,0, 8,8,0)
    set_pos(7,7,0, "happy_air")

    -- Cannon upgrades
    add_bent(13,13,13, "bent_upgrade_gun_2_damage")
    add_bent(13,13,11, "bent_upgrade_gun_2_damage")

    -- Text message
    local msg = "This is a placeholder."
    add_bent_s(13,13,9, "bent_base_txt", msg)

    -- Trophy
    add_bent(13,2,13, "bent_trophy_platters")

    -- Pink Ring
    add_bent(2,13,13, "bent_base_ring_pink_source")

    -- another text box
    msg = "This pink ring will take you out of these Platters."
    add_bent_s(2,13,11, "bent_base_txt", msg)

    -- save
    add_bent(2,13,9, "bent_base_save")
end

