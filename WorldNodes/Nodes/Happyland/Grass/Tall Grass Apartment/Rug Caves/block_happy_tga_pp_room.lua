function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_rug_2"
end

function p.__main()
    set_default_block("e")

    -- Structure
    std.create_shell("r_rug_2")

    -- Hole
    create_rect("r_black", 0,4,4, 0,11,11)
    create_rect("e", 0,6,7, 0,9,7)

    -- Treasure placeholder
    add_bent_s(13,7,9, "bent_base_waypoint", "Tall Grass Apartment - Power Box")
    add_bent_i(13,7,11, "bent_key_apartment", 500)
    local msg = "This key is supposed to last long for the sole reason of taking it out and finding the Secret Kitchen "
              .."in the ^x00ff00Tall Grass Apartment.^!\n\n"
              .."Instead of checking out every Chimney to see if it is open, you can read the news text box in the Treasure Rooms of the Apartment. "
              .."It will tell you if a Chimney Sweeper came through the building. If it does, that means the ^x00ff00Apartment has the Secret Kitchen.^!\n\n"
              .."You need to use this key because the keys inside the building have been designed to not last long enough to use in the Chimney."
    add_bent_s(13,7,13, "bent_base_txt", msg)
    add_bent(13,2,13, "bent_breaker_box")
    msg = "This is a ^xffff00Breaker Box^!. Upon using it, it will ask for 2000 Gold to deactivate Apartment Key Guards. "
        .."Every time you purchase a 10% deactivation from a Breaker Box, then Apartment Key Guards in the ^x00ff00Tall Grass Apartments^! will generate 10% less.\n\n"
        .."These are vital to dash through a Tall Grass Apartment, "
        .."especially if you are trying to quickly figure out if the Apartment has a ^x00ff00Secret Kitchen.^!"
    add_bent(13,2,11, "bent_base_txt", msg)
    add_bent(13,13,13, "bent_base_ring_pink_source")
    msg = "This pink ring will take you out of this Power Plant."
    add_bent_s(13,13,11, "bent_base_txt", msg)
    -- add_bent(13,13,13, "bent_trophy_st_powerplant")
end