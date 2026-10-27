function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return("block_orange_concrete")
end

function p.__main()
    set_default_block("happy_exit_cube_air")

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)
    local zpos = get_input_adj_bt(0,0,1)
    local zneg = get_input_adj_bt(0,0,-1)
    
    -- Create room
    std.create_shell("r_orange")

    -- Create holes - x
    if xpos == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 15,6,6, 15,9,9)
    end
    if xneg == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 0,6,6, 0,9,9)
    end

    -- Create holes - y
    if ypos == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 6,15,6, 9,15,9)
    end
    if yneg == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 6,0,6, 9,0,9)
    end

    -- Create holes - z
    if zpos == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 6,6,15, 9,9,15)
    end
    if zneg == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 6,6,0, 9,9,0)
    end
end