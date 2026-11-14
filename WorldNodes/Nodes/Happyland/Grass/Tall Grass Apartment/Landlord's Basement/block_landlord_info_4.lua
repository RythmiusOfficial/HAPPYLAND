function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_info"
end

function p.__main()
    set_default_block("e")
    std.create_edges("r_info")

    local msg = "Message from The Landlord:\n\n"
              .."^xffff00They never wanted to leave, but that didn't excuse the fact that they were running out of food, "
              .."and I didn't really wanna spend my hard-earned money on my fine-tasted customers.\n"
              .."So they began eating their furniture and each other to survive!^!\n\n"
              .."^xff0000Those blasted imbeciles!\n\n"
              .."Why would they eat MY FURNITURE?! I spent egregious sums of my hard-earned money onto those pieces!^!"
    add_bent_s(12,12,13, "bent_base_txt", msg)
    add_bent_s(12,12,11, "bent_base_waypoint", "Landlord's Basement - Office")
    add_bent(12,12,9, "bent_base_save")
    create_rect("r_info", 12,12,0, 12,12,7)
    create_rect("r_white", 11,11,0, 13,13,3)
end