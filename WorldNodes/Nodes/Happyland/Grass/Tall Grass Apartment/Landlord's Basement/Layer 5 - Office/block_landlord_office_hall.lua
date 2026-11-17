function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_concrete"
end

function p.__main()
    set_default_block("r_concrete")
    create_sprinkles(0,0,0, 15,15,15, 0.2, "r_dark_gray")

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)

    -- Create halls
    if xpos == "block_landlord_office_room" or xpos == "block_landlord_office_hall" then
        create_rect("landlord_office_air", 6,6,1, 15,9,14)
    end
    if xneg == "block_landlord_office_room" or xneg == "block_landlord_office_hall" then
        create_rect("landlord_office_air", 0,6,1, 9,9,14)
    end

    -- The ypos only needs to check for the Boardroom because that's the only way in
    -- other than the Apartment Key variant of this hallway script
    if (ypos == "block_landlord_office_room"
        or ypos == "block_landlord_office_hall"
        or ypos == "block_landlord_office_room_board") then
        create_rect("landlord_office_air", 6,6,1, 9,15,14)
    end
    -- The yneg is the only direction that is needed to check for the Apartment Key variant of the hallway script
    -- The yneg also is the only direction that needs to check for the entrance
    if (yneg == "block_landlord_office_entrance"
        or yneg == "block_landlord_office_hall"
        or yneg == "block_landlord_office_hall_key"
        or yneg == "block_landlord_office_room") then
        create_rect("landlord_office_air", 6,0,1, 9,9,14)
    end
    
    -- add enemies
    local ment_list = {}
    local ment_type = 0
    local final_ment = ""
    ment_list[0] = "conformed"
    ment_list[1] = "assimilated"
    ment_list[2] = "integrated"

    ment_type = randi(0,#ment_list)
    final_ment = tostring(ment_list[ment_type])

    if randi(1,3) == 1 then
        ment_start(7,7,7, "ment_monster_agent_" .. final_ment)
        ment_set_offset(8,8,8)
        ment_end()
    end
end