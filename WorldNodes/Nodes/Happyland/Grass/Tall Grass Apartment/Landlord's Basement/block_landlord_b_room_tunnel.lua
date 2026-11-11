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
    -- Placeholder
end