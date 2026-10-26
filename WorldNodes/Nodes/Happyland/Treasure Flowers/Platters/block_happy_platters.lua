function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("happy_air")

    -- Floor with small grass
    create_rect("happy_small_grass", 0,0,0, 15,15,0)
    
    -- Create plates
    for z = 1,13,2 do
        local tr = randf()
        create_rect("r_green", 6,6,z, 8,8,z)
        create_rect("happy_small_grass", 6,6,z+1, 8,8,z+1)

        -- Check to generate Treasure Flower (and Reverse Tree in the future!)
        if tr <= 0.8 then -- 80% chance per plate!
            for i = randi(1,2),randi(2,3) do
                local x = randi(6,8)
                local y = randi(6,8)
                set_pos(x,y,z+1, "happy_treasure_flower")
            end
        end
    end

    -- Create pillar
    create_rect("happy_platters_stem", 7,7,0, 7,7,13)
    set_pos(7,7,0, "happy_platters_entrance")
    set_pos(7,7,13, "happy_platters_treasure")

    -- Pink Ring Destination
    set_pos(6,6,0, "e")
    add_bent(6,6,0, "bent_base_ring_pink_dest")
end
