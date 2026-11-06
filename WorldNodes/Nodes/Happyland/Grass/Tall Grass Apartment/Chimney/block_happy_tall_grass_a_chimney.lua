function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green_x"
end

function p.__main()
    set_default_block("e")

    local zpos = get_input_adj_bt(0,0,1)
    local zneg = get_input_adj_bt(0,0,-1)
    
    -- Create chimney layout
    create_rect("r_green_x", 4,4,0, 12,12,15)
    create_rect("happy_smokey_air", 5,5,0, 11,11,15)

    -- Create chimney top bulge
    if zpos == "block_happy_air" then
        create_rect("e", 4,4,15, 12,12,15)
        create_rect("r_green_x", 2,2,10, 14,14,14)
        create_rect("happy_smokey_air", 5,5,10, 11,11,14)
        create_rect("plug", 5,5,10, 11,11,10)
        create_rect("expander", 5,5,11, 11,11,11)
        add_bent(8,8,14, "bent_base_ring_green")
    end

    -- Create dust
    if zneg == "block_r_green" or zneg == "block_happy_chimney_tunnel" then
        create_rect("r_concrete", 5,5,0, 11,11,0)
        for x = 5,11 do
        for y = 5,11 do
            len = randi(1,4)
            create_rect("dust", x,y,1, x,y,len+1)
        end end
    end

    -- Overwrite concrete with empty if the Kitchen has been created in the Apartment
    if zneg == "block_happy_chimney_tunnel" then
        create_rect("e", 5,5,0, 11,11,0)
        create_sprinkles(5,5,1, 11,11,4, 0.2, "dust")
    end
end