function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("r_concrete")
    create_rect("e", 3,3,3, 11,11,11)

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)

    -- Create holes
    if xpos == "block_landlord_b_hall" then
        create_rect("e", 11,6,6, 15,8,8)
    end
    if xneg == "block_landlord_b_hall" then
        create_rect("e", 0,6,6, 3,8,8)
    end

    if ypos == "block_landlord_b_hall" then
        create_rect("e", 6,11,6, 8,15,8)
    end
    if yneg == "block_landlord_b_hall" then
        create_rect("e", 6,0,6, 8,3,8)
    end
    
    -- Bents
    add_bent_s(4,4,4, "bent_base_waypoint", "Landlord's Basement - Maze")
    local msg = "This is the ^xff0000Landlord's Basement,^! and it is split up into layers. "
              .."The first three layers are easy 7x7 two-dimensional mazes with enemies on the second and third layer.\n\n"
              .."You must've really pissed The Landlord in order to be able to access this area. "
              .."If you don't think you are ready, then take the pink ring to escape this ^x00ff00Tall Grass Apartment.^!\n\n"
              .."^xff0000Tread further with caution.^!"
    add_bent_s(4,4,10, "bent_base_txt", msg)
    add_bent(4,4,8, "bent_base_ring_pink_source")
end