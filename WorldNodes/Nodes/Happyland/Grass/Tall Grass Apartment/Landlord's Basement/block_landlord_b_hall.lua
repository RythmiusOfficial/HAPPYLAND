function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_concrete"
end

function p.__main()
    set_default_block("r_dark_gray")
    std.create_shell("r_concrete")

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)

    -- Create tubes - x
    if xpos == "block_landlord_b_room" or xpos == "block_landlord_b_room_tunnel" or xpos == "block_landlord_b_room_entrance" then
        std.create_half_tube(3,"x_pos", "e")
        
    end
    if xneg == "block_landlord_b_room" or xneg == "block_landlord_b_room_tunnel" or xneg == "block_landlord_b_room_entrance"then
        std.create_half_tube(3,"x_neg", "e")
    end

    -- Create tubes - y
    if ypos == "block_landlord_b_room" or ypos == "block_landlord_b_room_tunnel" or ypos == "block_landlord_b_room_entrance"then
        std.create_half_tube(3,"y_pos", "e")
    end
    if yneg == "block_landlord_b_room" or yneg == "block_landlord_b_room_tunnel" or yneg == "block_landlord_b_room_entrance"then
        std.create_half_tube(3,"y_neg", "e")
    end
end