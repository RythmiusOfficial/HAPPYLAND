function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_brown_concrete"
end

function p.__main()
    set_default_block("r_brown_concrete")

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)
    local zpos = get_input_adj_bt(0,0,1)

    local z_max = 15

    -- Carve out insides
    if zpos == "block_happy_tall_grass_a_staircase" then
        z_max = 15
    else
        z_max = 14
    end

    create_rect("e", 1,1,0, 14,14,z_max)

    -- Create holes - x
    if xpos == "block_happy_tall_grass_a_hall" then
        create_rect("r_black", 15,5,5, 15,10,10)
        if xpos == "block_happy_air" then
            create_rect("anti_plug", 15,6,6, 15,9,9)
        else
            create_rect("happy_air", 15,6,6, 15,9,9)
        end
    end
    if xneg == "block_happy_tall_grass_a_hall" then
        create_rect("r_black", 0,5,5, 0,10,10)
        if xneg == "block_happy_air" then
            create_rect("anti_plug", 0,6,6, 0,9,9)
        else
            create_rect("happy_air", 0,6,6, 0,9,9)
        end
    end
    
    -- Create holes - y
    if ypos == "block_happy_tall_grass_a_hall" then
        create_rect("r_black", 5,15,5, 10,15,10)
        if ypos == "block_happy_air" then
            create_rect("anti_plug", 6,15,6, 9,15,9)
        else
            create_rect("happy_air", 6,15,6, 9,15,9)
        end
    end
    if yneg == "block_happy_tall_grass_a_hall" then
        create_rect("r_black", 5,0,5, 10,0,10)
        if yneg == "block_happy_air" then
            create_rect("anti_plug", 6,0,6, 9,0,9)
        else
            create_rect("happy_air", 6,0,6, 9,0,9)
        end
    end
end