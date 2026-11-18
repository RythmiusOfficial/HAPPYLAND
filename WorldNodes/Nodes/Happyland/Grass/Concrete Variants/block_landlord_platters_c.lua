function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("happy_air")
    
    -- Create plates
    for z = 1,13,2 do
        local tr = randf()
        create_rect("r_dark_gray", 5,5,z, 9,9,z)
        create_rect("landlord_concrete_grass", 5,5,z+1, 9,9,z+1)

        -- Check to generate Treasure Flower
        if tr <= 0.8 then -- 80% chance per plate!
        if fertile then
            for i = randi(1,2),randi(2,3) do
                local x = randi(6,8)
                local y = randi(6,8)
                set_pos(x,y,z+1, "landlord_treasure_flower_c")
            end
        end end

        -- add randomized chains that connect to the plate above it in a random location on the platter
    end

    -- Create pillar
    create_rect("landlord_platters_c_stem", 7,7,0, 7,7,13)
    set_pos(7,7,0, "landlord_platters_c_entrance")
    set_pos(7,7,13, "landlord_platters_c_treasure")

    -- Pink Ring Destination
    set_pos(6,6,0, "e")
    add_bent(6,6,0, "bent_base_ring_pink_dest")

    -- shrink
    add_bent(7,7,14, "bent_base_ring_green_danger")
end

function p.__type_init(id)
    ia_block_new_var_b(id, "fertile", false)
end