function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return("block_concrete")
end

function p.__main()
    set_default_block("r_concrete")

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)
    local zpos = get_input_adj_bt(0,0,1)
    local zneg = get_input_adj_bt(0,0,-1)

    -- Create tubes - x
    if xpos == "block_happy_exit_particle_room" or xpos == "block_happy_exit_particle_entrance" or xpos == "block_happy_exit_particle_treasure" then
        std.create_half_tube(1,"x_pos", "happy_exit_cube_air")
    end
    if xneg == "block_happy_exit_particle_room" or xneg == "block_happy_exit_particle_entrance" or xneg == "block_happy_exit_particle_treasure" then
        std.create_half_tube(1,"x_neg", "happy_exit_cube_air")
    end

    -- Create tubes - y
    if ypos == "block_happy_exit_particle_room" or ypos == "block_happy_exit_particle_entrance" or ypos == "block_happy_exit_particle_treasure" then
        std.create_half_tube(1,"y_pos", "happy_exit_cube_air")
    end
    if yneg == "block_happy_exit_particle_room" or yneg == "block_happy_exit_particle_entrance" or yneg == "block_happy_exit_particle_treasure" then
        std.create_half_tube(1,"y_neg", "happy_exit_cube_air")
    end

    -- Create tubes - z
    if zpos == "block_happy_exit_particle_room" or zpos == "block_happy_exit_particle_entrance" or zpos == "block_happy_exit_particle_treasure" then
        std.create_half_tube(1,"z_pos", "happy_exit_cube_air")
    end
    if zneg == "block_happy_exit_particle_room" or zneg == "block_happy_exit_particle_entrance" or zneg == "block_happy_exit_particle_treasure" then
        std.create_half_tube(1,"z_neg", "happy_exit_cube_air")
    end
end