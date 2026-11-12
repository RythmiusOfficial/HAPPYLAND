function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_concrete_white_diag"
end

function p.__main()
    set_default_block("e")
    std.create_shell("r_concrete_white_diag")

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)

    local p_rate_spawn = state_get_i("tgaplasma")

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

    -- News text box (kitchen)
    local level = get_level()
    local kitchen = get_input_path_block_b(level, "kitchen")
    local msg = ""
    local news_reporter = randi(1,7)

    if kitchen == true then
        msg = "^xffffffBREAKING NEWS:^!\n\n"
            .."The residents in this Apartment mentioned something about a ^x00ff00Chimney Sweeper^! coming in through here. "
            .."Many suspect that the furnaces would now be safe to use, but they don't have any furnaces so they wouldn't know."
    else
        if news_reporter == 1 then
            msg = "^xffffffBREAKING NEWS:^!\n\n"
                .."Many Floor 1 residents complain about a deep laughter emanating beneath them as they sleep. "
                .."Experts suggest the possibility of a severe pervert infestation."
        elseif news_reporter == 2 then
            msg = "^xffffffBREAKING NEWS:^!\n\n"
                .."Resident Marshall was recently caught attempting to leave the Apartment "
                .."without filling out the official resignation papers from The Landlord's binding contract.\n\n"
                .."^xff0000He was never seen again.^!"
        elseif news_reporter == 3 then
            msg = "^xffffffBREAKING NEWS:^!\n\n"
                .."The Landlord receives extreme criticisms from competition, claiming absolutely ridiculous accusations of mass imprisonment "
                .."and food deprivation amongst his customers. "
                .."He followed up with an incredibly melodramatic YouTube apology video, but showed no signs of halting his actions."
        elseif news_reporter == 4 then
            msg = "^xffffffBREAKING NEWS:^!\n\n"
                .."New scientific study shows that pacifists are 120% more likely to be gunned down by home intruders. "
                .."Stay inside and make sure to conform to violence."
        else
            msg = "^xffffffBREAKING NEWS:^!\n\n"
                .."The residents here are boring and do not have any news to broadcast to this unbranded news text box."
        end
    end

    add_bent_s(13,13,2, "bent_base_txt", msg)

    -- Create treasure
    add_bent(13,13,13, "bent_base_ring_pink_source")
    msg = "This pink ring will take you down to a room on Floor 1 of this ^x00ff00Tall Grass Apartment.^!"
    add_bent_s(13,13,11, "bent_base_txt", msg)

    msg = "Message from TON 618:\n\n"
        .."^x0000ffRecently, my mind has been detecting a copy of this universe from afar. "
        .."If someone did, I might be able to explain how you ended up here.\n\n"
        .."The mere idea of copying this universe is rather unsettling however... "
        .."Why would anyone do such a thing? "
        .."To^! ^x800080watch over me?^! ^x0000ffTo ensure my entrapment is eternal? "
        .."Or would it be out of pure oblivion and curiosity?\n\n"
        .."Whatever the reason, it still is rather irritating to feel another 'you' someplace else amongst the whole of reality...^!"

    add_bent_s(2,13,11, "bent_base_txt", msg)

    add_bent(2,13,9, "bent_trophy_tall_grass_apartment")

    add_bent_s(2,13,13, "bent_base_waypoint", "Tall Grass Apartment")

    -- Upgrades (plasma)
    add_bent(13,2,13, "bent_upgrade_gun_1_ammo_cap")
    add_bent(13,2,11, "bent_upgrade_gun_1_ammo_cap")
    add_bent(13,2,9, "bent_upgrade_gun_1_ammo_cap")
    add_bent(13,2,7, "bent_upgrade_gun_1_ammo_cap")

    add_bent(11,2,13, "bent_upgrade_gun_1_ammo_regen")
    add_bent(11,2,11, "bent_upgrade_gun_1_ammo_regen")
    add_bent(11,2,9, "bent_upgrade_gun_1_ammo_regen")
    add_bent(11,2,7, "bent_upgrade_gun_1_ammo_regen")

    add_bent(6,2,11, "bent_upgrade_gun_1_damage")
    add_bent(9,2,11, "bent_upgrade_gun_1_damage")
    add_bent(6,2,13, "bent_upgrade_gun_1_damage")
    add_bent(9,2,13, "bent_upgrade_gun_1_damage")

    -- fire rate limiter; no late-game cheesing
    if p_rate_spawn > 0 then
        add_bent_i(4,2,13, "bent_upgrade_gun_1_fire_speed", 1)
    end

    print(tostring(p_rate_spawn))

    add_bent(4,2,11, "bent_upgrade_gun_1_damage")
    add_bent(4,2,9, "bent_upgrade_gun_1_damage")
    add_bent(4,2,7, "bent_upgrade_gun_1_damage")

    add_bent(2,2,13, "bent_upgrade_gun_1_proj_speed")
    add_bent(2,2,11, "bent_upgrade_gun_1_proj_speed")
    add_bent(2,2,9, "bent_upgrade_gun_1_proj_speed")
    add_bent(2,2,7, "bent_upgrade_gun_1_proj_speed")
end

function p.__type_init(id)
    ia_block_new_var_b(id, "kitchen", false)
end