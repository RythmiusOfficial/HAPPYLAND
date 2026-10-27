function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return("block_yellow_concrete")
end

function p.__main()
    set_default_block("happy_exit_cube_air")
    std.create_shell("r_yellow")

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)
    local zpos = get_input_adj_bt(0,0,1)
    local zneg = get_input_adj_bt(0,0,-1)

    -- Create holes - x
    if xpos == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 15,6,6, 15,8,8)
    end
    if xneg == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 0,6,6, 0,8,8)
    end

    -- Create holes - y
    if ypos == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 15,6,6, 15,8,8)
    end
    if yneg == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 0,6,6, 0,8,8)
    end

    -- Create holes - z
    if zpos == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 15,6,6, 15,8,8)
    end
    if zneg == "block_happy_exit_particle_hall" then
        create_rect("happy_exit_cube_air", 0,6,6, 0,8,8)
    end

    -- Create treasure
    add_bent(7,7,7, "bent_base_ring_pink_source")
    add_bent_s(7,7,9, "bent_base_waypoint", "Exit Cube Particle - Treasure")
end