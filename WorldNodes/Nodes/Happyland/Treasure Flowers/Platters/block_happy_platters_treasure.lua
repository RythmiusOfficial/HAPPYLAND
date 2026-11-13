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
    add_bent(11,13,13, "bent_upgrade_gun_2_num_shots")
    add_bent(11,13,11, "bent_upgrade_gun_2_num_shots")
    add_bent(9,13,13, "bent_upgrade_gun_2_proj_speed")
    add_bent(9,13,11, "bent_upgrade_gun_2_proj_speed")
    add_bent_i(7,13,13, "bent_xp", 200)

    -- Text message
    local msg = "Message from TON 618:\n\n"
              .."^x0000ffMany know that Re-Creation requires the essential Inner Cores because of its creationary strength, "
              .."but if you're a supermassive cosmic entity, you sorta have a lot of those within you. "
              .."I guess that was the case with me; "
              .."I had plenty of naturally-forming universes within my body. "
              .."The others weren't as lucky as I, those pathetic^! ^xff0000BLASTED^! ^x0000ffidiots... Woahhaa-hahhaa!!^!"
    add_bent_s(13,13,9, "bent_base_txt", msg)
    msg = "^x0000ffOne of these universes was of my own creation (or should I say Re-Creation, hah!), "
        .."and I would visit it often (aside from toying with gullible adventurers from Xar; "
        .."I enjoyed doing that in my free time). "
        .."This universe was derived from an Inner Core from Xar to recreate the similar aesthetic; "
        .."there was something about the uniformity of the universe that struck me fancy, "
        .."about how every chunk was subdivided into 16x16x16 cubes, which themselves were constructed with equal height, width, and length...\n\n"
        .."I used to enjoy this place... but now I'm stuck here.\n\n"
        .."I want to be happy in a time where my friends considered me someone to love. But maybe I do deserve^! ^xff0000hell...^!\n\n"
        .."^x0000ffI need some time to^! ^x9500ffthink...^!"
    add_bent_s(13,13,7, "bent_base_txt", msg)

    -- Trophy
    add_bent(13,2,13, "bent_trophy_platters")

    -- Pink Ring
    add_bent(2,13,13, "bent_base_ring_pink_source")

    -- another text box
    msg = "This pink ring will take you out of these ^x00ff00Platters.^!"
    add_bent_s(2,13,11, "bent_base_txt", msg)

    -- save
    add_bent(2,13,9, "bent_base_save")
end

