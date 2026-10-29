function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("happy_air")
    std.create_edges("r_white")

    -- Create xp
    add_bent_i(13,2,13, "bent_xp", 2500)

    -- Create health and armor upgrades
    add_bent(13,2,11, "bent_upgrade_health_cap")
    add_bent(13,4,11, "bent_upgrade_health_cap")
    add_bent(13,6,11, "bent_upgrade_health_cap")
    add_bent(13,8,11, "bent_upgrade_health_cap")
    add_bent(13,10,11, "bent_upgrade_health_cap")
    add_bent(13,12,11, "bent_upgrade_health_cap")
    add_bent(13,14,11, "bent_upgrade_health_cap")

    add_bent(13,2,9, "bent_upgrade_health_regen")
    add_bent(13,4,9, "bent_upgrade_health_regen")
    add_bent(13,6,9, "bent_upgrade_health_regen")
    add_bent(13,8,9, "bent_upgrade_health_regen")
    add_bent(13,10,9, "bent_upgrade_health_regen")
    add_bent(13,12,9, "bent_upgrade_health_regen")
    add_bent(13,14,9, "bent_upgrade_health_regen")

    add_bent(13,2,7, "bent_upgrade_armor_regen")
    add_bent(13,4,7, "bent_upgrade_armor_regen")
    add_bent(13,6,7, "bent_upgrade_armor_regen")
    add_bent(13,8,7, "bent_upgrade_armor_regen")
    add_bent(13,10,7, "bent_upgrade_armor_regen")
    add_bent(13,12,7, "bent_upgrade_armor_regen")
    add_bent(13,14,7, "bent_upgrade_armor_regen")

    -- Create text boxes
    local msg = "Message from TON 618:\n\n"
              .."^x0000ffBecause I infinitely envelop this universe with my mind, I am capable of seeing everything. "
              .."Not once have I seen an Inner Core, which completely invalidates the Inner Botany Theory. "
              .."Either that, or I have replaced the Inner Core. "
              .."This hypothetical is not entirely unlikely considering that I used to be made of universes, "
              .."capable of carrying the creationary power an Inner Core has. "
              .."But, because I am everything, that would mean this whole universe is within an Inner Core which is kind of baffling to think about.\n\n"
              .."If this whole universe is an Inner Core, then the Inner Core must be NECESSARY for an outer universe, "
              .."which means that this universe is within another. A composite universe...^!"
    add_bent_s(2,13,13, "bent_base_txt", msg)
    msg = "^x0000ffNow this does make me wonder about many things. "
        .."Are monsters bounding boxes for internal fractalized universes? "
        .."Would it be logical that the universe this one is in is also part of another outer universe? "
        .."Does every monster contain a universe, or only^! ^xff0000specific ones?^!"
    add_bent_s(2,13,11, "bent_base_txt", msg)

    -- Create trophy
    add_bent(7,7,7, "bent_trophy_st_hollow_medium_grass")

    -- Create waypoint
    add_bent_s(2,2,13, "bent_base_waypoint", "Hollow Medium Grass")
    msg = "This waypoint is the only way out of ^x00ff00Hollow Medium Grass.^!\n\n"
        .."(unless you really wanna fly all the way back...)"
    add_bent_s(2,2,11, "bent_base_txt", msg)
    msg = "There might be a faster way to enter this treasure room without having to fly to the Overhead Tunnel System...\n\n^xff8000I wonder how...^!"
    add_bent_s(2,2,9, "bent_base_txt", msg)
end