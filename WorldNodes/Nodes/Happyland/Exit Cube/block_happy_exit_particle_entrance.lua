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
        create_rect("plug", 15,6,6, 15,9,9)
    end
    if xneg == "block_happy_exit_particle_hall" then
        create_rect("plug", 0,6,6, 0,9,9)
    end

    -- Create holes - y
    if ypos == "block_happy_exit_particle_hall" then
        create_rect("plug", 6,15,6, 9,15,9)
    end
    if yneg == "block_happy_exit_particle_hall" then
        create_rect("plug", 6,0,6, 9,0,9)
    end

    -- Create holes - z
    create_rect("e", 5,5,15, 10,10,15)
    if zneg == "block_happy_exit_particle_hall" then
        create_rect("plug", 6,6,0, 9,9,0)
    end

    -- Create text box
    local msg = "This is an ^x00ff00Exit Cube Particle Dungeon!^!\n\n"
              .."You will find upgrades for your Rail and Cannon weapons at the end of the following easy 3x3x3 maze, which can be entered by using the shrink ring below and flying through the plug(s) in the wall(s).\n\n"
              .."The treasure rooms can be found at dead ends on the bottom-most floor, indicated with ^xffff00yellow^! rooms. Regular rooms are ^xffa500orange^! and are filled with dangerous Exit Cube Air (as well as this room).\n\n"
              .."^xff0000Hope you brought enough health to survive the onslaught of Menaces...^!"
    add_bent_s(7,7,7, "bent_base_txt", msg)

    -- Create waypoint
    add_bent_s(7,7,5, "bent_base_waypoint", "Exit Cube Particle Dungeon - Entrance")

    -- Create ammo boxes
    add_bent(13,13,13, "bent_ammo_gun_1") -- Plasma
    add_bent(13,13,11, "bent_ammo_gun_2_large") -- Cannon
    add_bent(13,13,9, "bent_ammo_gun_7_small") -- Rail

    -- Create armor and health
    add_bent(2,13,13, "bent_health_200p_armor_200p")
    add_bent(2,13,11, "bent_armor_600p_once")

    -- Create shrink ring
    add_bent(7,7,1, "bent_base_ring_green")
end