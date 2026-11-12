function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return ("block_green_x")
end

function p.__main()
    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)

    local basement = state_get_b("basement")
    local b_type = {}
    local block = ""
    local b_index = 0

    b_type[0] = "green_x"
    b_type[1] = "concrete"

    if basement then
        b_index = 1
    end

    block = b_type[b_index]

    set_default_block("r_" .. block)

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
end