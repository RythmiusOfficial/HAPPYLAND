function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_concrete"
end

function p.__main()
    set_default_block("landlord_office_air")
    std.create_shell("r_concrete")

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)

    -- Carve out walls (only essential blocks)
    if xpos == "block_landlord_office_room_board" then
        create_rect("e", 15,1,1, 15,14,14)
    end
    if xneg == "block_landlord_office_room_board" then
        create_rect("e", 0,1,1, 0,14,14)
    end

    if ypos == "block_landlord_office_hall_key" or ypos == "block_landlord_office_room_board" then
        create_rect("e", 1,15,1, 14,15,14)
    end
    if yneg == "block_landlord_office_hall" or yneg == "block_landlord_office_room_board" then
        create_rect("e", 1,0,1, 14,0,14)
    end

    -- create tables and stuff
end