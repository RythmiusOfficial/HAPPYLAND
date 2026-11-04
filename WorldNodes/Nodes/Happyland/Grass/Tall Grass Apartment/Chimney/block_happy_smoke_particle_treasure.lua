function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return("block_yellow_concrete")
end

function p.__main()
    set_default_block("happy_smokey_air")
    std.create_shell("r_yellow")

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)
    local zpos = get_input_adj_bt(0,0,1)
    local zneg = get_input_adj_bt(0,0,-1)

    -- Create holes - x
    if xpos == "block_happy_smoke_particle_hall" then
        create_rect("happy_smokey_air", 15,6,6, 15,9,9)
    end
    if xneg == "block_happy_smoke_particle_hall" then
        create_rect("happy_smokey_air", 0,6,6, 0,9,9)
    end

    -- Create holes - y
    if ypos == "block_happy_smoke_particle_hall" then
        create_rect("happy_smokey_air", 6,15,6, 9,15,9)
    end
    if yneg == "block_happy_smoke_particle_hall" then
        create_rect("happy_smokey_air", 6,0,6, 9,0,9)
    end

    -- Create holes - z
    if zpos == "block_happy_smoke_particle_hall" then
        create_rect("happy_smokey_air", 6,6,15, 9,9,15)
    end
    if zneg == "block_happy_smoke_particle_hall" then
        create_rect("happy_smokey_air", 6,6,0, 9,9,0)
    end

    -- Create expanders
    create_rect("expander", 6,6,6, 9,9,9)

    -- Create treasure
    add_bent(13,13,13, "bent_base_ring_pink_source")
    local msg = "This pink ring will take you out of this dungeon and to the outside of the ^x00ff00Tall Grass Apartment^! that this Chimney is a part of."
    add_bent_s(13,13,11, "bent_base_txt", msg)

    msg = "Message from TON 618:\n\n"
        .."^x0000ffI figured it out...\n\n" 
        .."I piled all of my Inner Core research in a manilla folder, ready to submit my findings to the Council.^!\n\n"
        .."^xff0000But that BASTARD stole it all and submitted it under her name, calling it the \"Re-Creation Theory\".\n\n"
        .."She would be praised and I would be left as the stereotypical jester, belittled to nothing but humour.\n\n"
        .."I TRUSTED HER.\n" 
        .."I LOVED HER.^!"
    add_bent_s(2,2,11, "bent_base_txt", msg)

    msg = "Message from TON 618:\n\n"
        .."^xff0000She used me to obtain my secrets, my efforts. "
        .."She knew I was hated. She knew nobody would believe me.\n\n"
        .."So she STABBED ME IN THE BACK AND LEFT ME TO DIE IN THE DEBRIS OF EXISTENCE.^!\n\n"
        .."^x0000ffWhy would I deserve any better anyways? "
        .."I was designed to waste away as a mound of unspent potential.\n\n"
        .."I sometimes wish I didn't have my personality. "
        .."It stings. I guess finding joy in a \"serious\" universe is reprimandable and shameful..."
    add_bent_s(2,2,9, "bent_base_txt", msg)

    add_bent(2,2,9, "bent_trophy_chimney")

    add_bent_s(2,13,13, "bent_base_waypoint", "Smoke Particle Dungeon - Treasure")

    -- Upgrades (laser and rocket)
    add_bent(13,2,11, "bent_upgrade_gun_3_ammo_cap")
    add_bent(13,2,9, "bent_upgrade_gun_3_ammo_cap")
    add_bent(13,2,7, "bent_upgrade_gun_3_ammo_cap")
    add_bent(13,2,5, "bent_upgrade_gun_3_ammo_cap")
    add_bent(13,2,3, "bent_upgrade_gun_3_ammo_cap")
    add_bent(13,2,1, "bent_upgrade_gun_3_ammo_cap")

    add_bent(11,2,11, "bent_upgrade_gun_3_damage")
    add_bent(11,2,9, "bent_upgrade_gun_3_damage")
    add_bent(11,2,7, "bent_upgrade_gun_3_damage")
    add_bent(11,2,5, "bent_upgrade_gun_3_damage")
    add_bent(11,2,3, "bent_upgrade_gun_3_damage")
    add_bent(11,2,1, "bent_upgrade_gun_3_damage")

    add_bent(9,2,11, "bent_upgrade_gun_4_proj_speed")
    add_bent(9,2,9, "bent_upgrade_gun_4_proj_speed")
    add_bent(9,2,7, "bent_upgrade_gun_4_proj_speed")
    add_bent(9,2,5, "bent_upgrade_gun_4_proj_speed")
    add_bent(9,2,3, "bent_upgrade_gun_4_proj_speed")
    add_bent(9,2,1, "bent_upgrade_gun_4_proj_speed")

    add_bent(7,2,11, "bent_upgrade_gun_4_damage")
    add_bent(7,2,9, "bent_upgrade_gun_4_damage")
    add_bent(7,2,7, "bent_upgrade_gun_4_damage")
    add_bent(7,2,5, "bent_upgrade_gun_4_damage")
    add_bent(7,2,3, "bent_upgrade_gun_4_damage")
    add_bent(7,2,1, "bent_upgrade_gun_4_damage")
end