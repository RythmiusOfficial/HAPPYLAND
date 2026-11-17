function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_info"
end

function p.__main()
    set_default_block("e")
    std.create_edges("r_info")

    -- Floor
    create_rect("r_concrete", 1,1,0, 14,14,0)

    -- Text box and white pillar
    local msg = "Message from The Landlord:\n\n"
              .."^xffff00They never wanted to leave, but that didn't excuse the fact that they were running out of food, "
              .."and I didn't really wanna spend my hard-earned money on my fine-tasted customers.\n"
              .."So they began eating their furniture and each other to survive!^!\n\n"
              .."^xff0000Those blasted imbeciles!\n\n"
              .."Why would they eat MY FURNITURE?! I spent egregious sums of my hard-earned money onto those pieces!^!"
    add_bent_s(12,3,14, "bent_base_txt", msg)
    add_bent_s(12,3,12, "bent_base_waypoint", "Landlord's Basement - Office")
    add_bent(12,3,10, "bent_base_save")
    create_rect("r_info", 12,3,1, 12,3,8)
    create_rect("r_white", 11,2,1, 13,4,4)

    -- Shrink pillar
    create_rect("e", 8,5,0, 10,7,0)
    set_pos(9,6,0, "r_green")
    set_pos(11,4,1, "expander")
    set_pos(11,4,0, "r_expander")
    add_bent(9,6,1, "bent_base_ring_green_danger")
end