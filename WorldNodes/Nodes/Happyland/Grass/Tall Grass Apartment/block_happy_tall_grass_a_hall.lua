function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green_x"
end

function p.__main()
    set_default_block("r_green_x")

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)

    -- Create tubes - x
    if xpos == "block_happy_tall_grass_a_room" or xpos == "block_happy_tall_grass_a_treasure" or xpos == "block_happy_tall_grass_a_staircase" then
        std.create_half_tube(2,"x_pos", "happy_air")
        
    end
    if xneg == "block_happy_tall_grass_a_room" or xneg == "block_happy_tall_grass_a_treasure" or xneg == "block_happy_tall_grass_a_staircase" then
        std.create_half_tube(2,"x_neg", "happy_air")
    end

    -- Create tubes - y
    if ypos == "block_happy_tall_grass_a_room" or ypos == "block_happy_tall_grass_a_treasure" or ypos == "block_happy_tall_grass_a_staircase" then
        std.create_half_tube(2,"y_pos", "happy_air")
    end
    if yneg == "block_happy_tall_grass_a_room" or yneg == "block_happy_tall_grass_a_treasure" or yneg == "block_happy_tall_grass_a_staircase" then
        std.create_half_tube(2,"y_neg", "happy_air")
    end

    -- Decorate later
    -- Placeholder
end