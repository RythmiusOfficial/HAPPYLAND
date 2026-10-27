function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green"
end

function p.__main()
    set_default_block("happy_exit_cube_air")
    std.create_shell("r_green")

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)
    local zpos = get_input_adj_bt(0,0,1)
    local zneg = get_input_adj_bt(0,0,-1)

    -- Create holes - x
    if xpos == "block_happy_exit_particle_hall" then
        create_rect("plug", 15,5,5, 15,9,9)
    end
    if xneg == "block_happy_exit_particle_hall" then
        create_rect("plug", 0,5,5, 0,9,9)
    end

    -- Create holes - y
    if ypos == "block_happy_exit_particle_hall" then
        create_rect("plug", 15,5,5, 15,9,9)
    end
    if yneg == "block_happy_exit_particle_hall" then
        create_rect("plug", 0,5,5, 0,9,9)
    end

    -- Create holes - z
    create_rect("e", 5,5,15, 10,10,15)

    -- Create text box
    local msg = "This is a placeholder message for instructions."
    add_bent_s(7,7,7, "bent_base_txt", msg)

    -- Create waypoint
    add_bent_s(7,7,5, "bent_base_waypoint", "Exit Cube Particle - Entrance")

    -- Create ammo boxes
    add_bent(9,9,9, "bent_ammo_gun_1") -- Plasma
    add_bent(9,9,7, "bent_ammo_gun_2_large") -- Cannon
    add_bent(9,9,5, "bent_ammo_gun_7_small") -- Rail
    
    -- Create shrink ring
    add_bent(7,7,1, "bent_base_ring_green")
end