function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_white_borderless"
end

function p.__main()
    set_default_block("e")
    std.create_shell("r_white_bdless")

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)

    -- Create holes - x
    if xpos == "block_happy_tall_grass_a_hall" then
        create_rect("r_black", 15,5,5, 15,10,10)
        create_rect("happy_air", 15,6,6, 15,9,9)
    end
    if xneg == "block_happy_tall_grass_a_hall" then
        create_rect("r_black", 0,5,5, 0,10,10)
        create_rect("happy_air", 0,6,6, 0,9,9)
    end

    -- Create holes - y
    if ypos == "block_happy_tall_grass_a_hall" then
        create_rect("r_black", 5,15,5, 10,15,10)
        create_rect("happy_air", 6,15,6, 9,15,9)
    end
    if yneg == "block_happy_tall_grass_a_hall" then
        create_rect("r_black", 5,0,5, 10,0,10)
        create_rect("happy_air", 6,0,6, 9,0,9)
    end

    -- Create treasure
    add_bent(13,13,13, "bent_base_ring_pink_source")
    local msg = "This pink ring will take you out of this ^x00ff00Tall Grass Apartment.^!"
    add_bent_s(13,13,11, "bent_base_txt", msg)

    msg = "Message from TON 618:\n\n"
        .."^x0000ffRecently, my mind has been detecting a copy of this universe from afar. "
        .."If someone did, I might be able to explain how you ended up here.\n\n"
        .."The mere idea of copying this universe is rather unsettling however... "
        .."Why would anyone do such a thing? "
        .."To^! ^x800080watch over me?^! ^x0000ffTo ensure my entrapment is eternal? "
        .."Or would it be out of pure oblivion and curiosity?\n\n"
        .."Whatever the reason, it still is rather irritating to feel another 'you' someplace else amongst the whole of reality...^!"

    add_bent_s(2,2,13, "bent_base_txt", msg)

    add_bent(2,2,9, "bent_trophy_tall_grass_apartment")

    add_bent_s(2,13,13, "bent_base_waypoint", "Tall Grass Apartment")

    -- Upgrades (plasma)
    add_bent(13,2,11, "bent_upgrade_gun_1_ammo_cap")
    add_bent(13,2,9, "bent_upgrade_gun_1_ammo_cap")
    add_bent(13,2,7, "bent_upgrade_gun_1_ammo_cap")

    add_bent(11,2,11, "bent_upgrade_gun_1_ammo_regen")
    add_bent(11,2,9, "bent_upgrade_gun_1_ammo_regen")
    add_bent(11,2,7, "bent_upgrade_gun_1_ammo_regen")

    add_bent(9,2,11, "bent_upgrade_gun_1_damage")
    add_bent(9,2,9, "bent_upgrade_gun_1_damage")
    add_bent(9,2,7, "bent_upgrade_gun_1_damage")

    add_bent(7,2,11, "bent_upgrade_gun_1_fire_speed")
    add_bent(7,2,9, "bent_upgrade_gun_1_fire_speed")
    add_bent(7,2,7, "bent_upgrade_gun_1_fire_speed")

    add_bent(5,2,11, "bent_upgrade_gun_1_proj_speed")
    add_bent(5,2,9, "bent_upgrade_gun_1_proj_speed")
    add_bent(5,2,7, "bent_upgrade_gun_1_proj_speed")
end