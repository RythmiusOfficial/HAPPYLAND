function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_concrete"
end

function p.__main()
    set_default_block("r_concrete")
    create_sprinkles(0,0,0, 15,15,15, 0.2, "r_dark_gray")
    create_rect("e", 1,1,1, 14,14,14)

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)

    local adj = 0

    -- Carve out walls (only essential blocks)
    if xpos == "block_landlord_office_room_board" then
        create_rect("e", 15,1,1, 15,14,14)
        create_rect("landlord_concrete_growth", 15,14,1, 15,14,14)
        create_rect("landlord_concrete_growth", 15,1,1, 15,1,14)
        for z = 1,14 do
            block_set_i(15,14,z, "dir", 2)
        end
        adj = adj + 1
    end
    if xneg == "block_landlord_office_room_board" then
        create_rect("e", 0,1,1, 0,14,14)
        create_rect("landlord_concrete_growth", 0,14,1, 0,14,14)
        create_rect("landlord_concrete_growth", 0,1,1, 0,1,14)
        for z = 1,14 do
            block_set_i(0,14,z, "dir", 2)
        end
        adj = adj + 1
    end

    if ypos == "block_landlord_office_hall_key" or ypos == "block_landlord_office_room_board" then
        create_rect("e", 1,15,1, 14,15,14)
        create_rect("landlord_concrete_growth", 1,15,1, 1,15,14)
        create_rect("landlord_concrete_growth", 14,15,1, 14,15,14)
        for z = 1,14 do
            block_set_i(1,15,z, "dir", 3)
            block_set_i(14,15,z, "dir", 4)
        end
        if ypos == "block_landlord_office_room_board" then
            adj = adj + 1
        end
    end
    if yneg == "block_landlord_office_hall" or yneg == "block_landlord_office_room_board" then
        create_rect("e", 1,0,1, 14,0,14)
        create_rect("landlord_concrete_growth", 1,0,1, 1,0,14)
        create_rect("landlord_concrete_growth", 14,0,1, 14,0,14)
        for z = 1,14 do
            block_set_i(1,0,z, "dir", 3)
            block_set_i(14,0,z, "dir", 4)
        end
        if yneg == "block_landlord_office_room_board" then
            adj = adj + 1
        end
    end

    -- create tables and pillar thing
    if adj ~= 4 then
        create_rect("r_brown_concrete", 6,3,2, 9,12,2)
        set_pos(6,3,1, "r_brown_concrete")
        set_pos(6,12,1, "r_brown_concrete")
        set_pos(9,3,1, "r_brown_concrete")
        set_pos(9,12,1, "r_brown_concrete")
    else
        create_rect("r_black", 6,6,1, 9,9,14)
        create_rect("r_concrete", 6,6,1, 6,6,14)
        create_rect("r_concrete", 6,9,1, 6,9,14)
        create_rect("r_concrete", 9,9,1, 9,9,14)
        create_rect("r_concrete", 9,6,1, 9,6,14)

        create_rect("landlord_concrete_growth", 6,5,1, 9,5,14)
        create_rect("landlord_concrete_growth", 6,10,1, 9,10,14)
        create_rect("landlord_concrete_growth", 5,6,1, 5,9,14)
        create_rect("landlord_concrete_growth", 10,6,1, 10,9,14)
        for x = 5,10 do
        for z = 1,14 do
            block_set_i(x,5,z, "dir", 2)
            block_set_i(x,10,z, "dir", 1)
            block_set_i(5,x,z, "dir", 4)
            block_set_i(10,x,z, "dir", 3)
        end end
    end

    -- create lights
    set_pos(3,3,14, "chain")
    set_pos(3,3,13, "happy_chandelier_bulb")
    block_set_i(3,3,13, "floor_chand", 5)
    block_set_b(3,3,13, "obstacle", true)

    set_pos(3,12,14, "chain")
    set_pos(3,12,13, "happy_chandelier_bulb")
    block_set_i(3,12,13, "floor_chand", 5)
    block_set_b(3,12,13, "obstacle", true)

    set_pos(12,12,14, "chain")
    set_pos(12,12,13, "happy_chandelier_bulb")
    block_set_i(12,12,13, "floor_chand", 5)
    block_set_b(12,12,13, "obstacle", true)

    set_pos(12,3,14, "chain")
    set_pos(12,3,13, "happy_chandelier_bulb")
    block_set_i(12,3,13, "floor_chand", 5)
    block_set_b(12,3,13, "obstacle", true)
end