function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return("block_yellow_concrete")
end

function p.__main()
    set_default_block("happy_exit_cube_air")
    std.create_shell("r_yellow")

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)
    local zpos = get_input_adj_bt(0,0,1)
    local zneg = get_input_adj_bt(0,0,-1)

    -- Create holes - x
    if xpos == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 15,6,6, 15,9,9)
    end
    if xneg == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 0,6,6, 0,9,9)
    end

    -- Create holes - y
    if ypos == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 6,15,6, 9,15,9)
    end
    if yneg == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 6,0,6, 9,0,9)
    end

    -- Create holes - z
    if zpos == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 6,6,15, 9,9,15)
    end
    if zneg == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 6,6,0, 9,9,0)
    end

    -- Create expanders
    create_rect("expander", 6,6,6, 9,9,9)

    -- Create treasure
    add_bent(13,13,13, "bent_base_ring_pink_source")
    local msg = "This pink ring will take you out of this dungeon. Now that I think about it, I need to move the pink sphere to the initial Exit Cube so you can actually escape."
    add_bent_s(13,13,11, "bent_base_txt", msg)

    msg = "Message from TON 618:\n\n"
        .."^x0000ffSince I have too much time on my hands, I guess it wouldn't hurt to jot down a couple things about myself. "
        .."Who knows when I might need to remember who I was? Time consumes everything, even memories, if you leave them to dry in the sun.\n\n"
        .."I've been described as a trickster, a deceiver, a funny guy, but those are all personality traits that are refined to a joker stereotype. "
        .."There's more to me, you know? "
        .."I've been told by a few that my intellect was great and my potential was exponential, but maybe that was false positivity meant to motivate me to do incredible things. "
        .."I guess it worked, lol.\n\n^!"
    add_bent_s(2,2,13, "bent_base_txt", msg)

    msg = "^x0000ffI remember the day I received my officialized Certificate of Metaphysical Theory, proof of my great desire to understand more about our current reality. "
        .."I began taking interest in universal Inner Cores, experimenting with their properties until I realized it had immense power.\n\n"
        .."Creationary power that is... If only there was some way to harness this power? This could redefine how we explore the Fractal Block World and how we live our lives.^!"
    add_bent_s(2,2,11, "bent_base_txt", msg)

    add_bent(2,2,9, "bent_trophy_st_exit_cube_part_dungeon")

    add_bent_s(2,13,13, "bent_base_waypoint", "Exit Cube Particle Dungeon - Treasure")

    -- Upgrades (rail and cannon)
    add_bent(13,2,13, "bent_upgrade_station")

    add_bent(13,2,11, "bent_upgrade_gun_7_ammo_cap")
    add_bent(13,2,9, "bent_upgrade_gun_7_ammo_cap")
    add_bent(13,2,7, "bent_upgrade_gun_7_ammo_cap")
    add_bent(13,2,5, "bent_upgrade_gun_7_ammo_cap")
    add_bent(13,2,3, "bent_upgrade_gun_7_ammo_cap")
    add_bent(13,2,1, "bent_upgrade_gun_7_ammo_cap")

    add_bent(11,2,11, "bent_upgrade_gun_7_damage")
    add_bent(11,2,9, "bent_upgrade_gun_7_damage")
    add_bent(11,2,7, "bent_upgrade_gun_7_damage")
    add_bent(11,2,5, "bent_upgrade_gun_7_damage")
    add_bent(11,2,3, "bent_upgrade_gun_7_damage")
    add_bent(11,2,1, "bent_upgrade_gun_7_damage")

    add_bent(9,2,11, "bent_upgrade_gun_2_fire_speed")
    add_bent(9,2,9, "bent_upgrade_gun_2_fire_speed")
    add_bent(9,2,7, "bent_upgrade_gun_2_fire_speed")
    add_bent(9,2,5, "bent_upgrade_gun_2_fire_speed")
    add_bent(9,2,3, "bent_upgrade_gun_2_fire_speed")
    add_bent(9,2,1, "bent_upgrade_gun_2_fire_speed")

    add_bent(7,2,11, "bent_upgrade_gun_2_damage")
    add_bent(7,2,9, "bent_upgrade_gun_2_damage")
    add_bent(7,2,7, "bent_upgrade_gun_2_damage")
    add_bent(7,2,5, "bent_upgrade_gun_2_damage")
    add_bent(7,2,3, "bent_upgrade_gun_2_damage")
    add_bent(7,2,1, "bent_upgrade_gun_2_damage")
end