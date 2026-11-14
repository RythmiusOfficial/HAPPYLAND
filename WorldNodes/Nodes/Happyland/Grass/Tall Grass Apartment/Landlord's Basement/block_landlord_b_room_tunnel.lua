function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_concrete"
end

function p.__main()
    set_default_block("r_concrete")
    create_rect("e", 3,3,0, 11,11,11)

    -- Start on layer 1
    local layer = 1
    local msg = ""

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)

    -- Check to see what layer the room is on and generate enemies accordingly
    if get_input_adj_bt(0,0,1) == "block_landlord_b_room" then
        layer = layer + 1
    end
    if get_input_adj_bt(0,0,2) == "block_landlord_b_room" then
        layer = layer + 1
    end

    -- Create holes
    if xpos == "block_landlord_b_hall" then
        create_rect("e", 11,6,6, 15,8,8)
    else
        create_rect("e", 12,6,6, 12,8,9)
        set_pos(12,7,10, "e")
        set_pos(12,7,5, "e")
        set_pos(13,7,8, "num_" .. tostring(layer))
    end
    if xneg == "block_landlord_b_hall" then
        create_rect("e", 0,6,6, 3,8,8)
    else
        create_rect("e", 2,6,6, 2,8,9)
        set_pos(2,7,10, "e")
        set_pos(2,7,5, "e")
        set_pos(1,7,8, "num_" .. tostring(layer))
    end

    if ypos == "block_landlord_b_hall" then
        create_rect("e", 6,11,6, 8,15,8)
    else
        create_rect("e", 6,12,6, 8,12,9)
        set_pos(7,12,10, "e")
        set_pos(7,12,5, "e")
        set_pos(7,13,8, "num_" .. tostring(layer))
    end
    if yneg == "block_landlord_b_hall" then
        create_rect("e", 6,0,6, 8,3,8)
    else
        create_rect("e", 6,2,6, 8,2,9)
        set_pos(7,2,10, "e")
        set_pos(7,2,5, "e")
        set_pos(7,1,8, "num_" .. tostring(layer))
    end

    -- Create bents based on layer num
    if layer == 1 then
        msg = "Message from The Landlord:\n\n"
            .."^xffff00It appears that you have found my basement... Funny... "
            .."No one usually wants to see me in person, unless they really want me^! ^xff0000dead.^!\n\n"
            .."^xffff00You better hope you're here for autographs, because I don't tend well to assassins.^!"
        add_bent_s(4,4,10, "bent_base_txt", msg)
        add_bent(4,4,8, "bent_base_save")
        add_bent(4,4,6, "bent_upgrade_health_regen")
    end
    if layer == 2 then
        msg = "Message from The Landlord:\n\n"
            .."^xffff00A little birdy told me that you have^! ^xff0000killed a couple of my clients.^! "
            .."^xffff00But, maybe you actually saved them from the hell that they didn't even know they were in.\n\n"
            .."You see, housing is considered a luxury in this universe, so a lot of customers came pouring into my apartment. "
            .."More and more continued to purchase rooms, so much so that I ran out of rooms!\n\n"
            .."I didn't realize that the housing industry was^! ^xff0000BOOMING!^!"
        add_bent_s(4,4,10, "bent_base_txt", msg)
        add_bent(4,4,8, "bent_base_save")
        add_bent(4,4,6, "bent_upgrade_health_cap")
    end
    if layer == 3 then
        msg = "Message from The Landlord:\n\n"
            .."^xffff00I had realized that once the influx of new customers kept exponentially increasing, "
            .."I had to purchase more and more land to build more copies of my apartment.\n"
            .."Turns out it doesn't cost much to purchase land when land is recursively infinite...\n\n"
            .."What does cost a lot is constructing the apartment copies, so I had to cut costs on food supply. "
            .."In response, I had sealed off the kitchens and the food budget. "
            .."I got severe reputational backlash from the residents, so I did what any good business owner would do:^!\n\n"
            .."^xff0000I brainwashed them into thinking the Apartment as their savior. Now, they never want to leave!^!"
        add_bent_s(4,4,10, "bent_base_txt", msg)
        add_bent(4,4,8, "bent_base_save")
        add_bent(4,4,6, "bent_upgrade_gun_7_damage")
    end
end