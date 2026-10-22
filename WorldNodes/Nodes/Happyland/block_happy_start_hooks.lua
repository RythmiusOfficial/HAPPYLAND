function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("happy_air")

    -- Create wall of even more Start Hooks
    create_rect("happy_start_hooks", 0,0,0, 0,15,15)
    
    -- Create hooks with random bend and shrink spawn chances
    for i = 1,20 do
        -- Initializing variables
        local y = randi(0,15)
        local z = randi(0,13)

        local len = randi(3,14)
        local shrink_chance = randf()
        local bend_chance = randf()
        local bend_amt = 0

        -- Check bend chance
        if bend_chance <= 0.1 then
            bend_amt = randi(1,len)
        end
        
        -- Create hooks and Medium Grass chunks
        for x = 0,(len-bend_amt) do
            set_pos(x,y,z, "r_green")
            -- Generate Treasure Flower if requirements are met, else generate Medium Grass
            if randf() <= 0.05 then
                set_pos(x,y,z+1, "happy_treasure_flower")
            else
                set_pos(x,y,z+1, "happy_medium_grass")
            end
            -- Bend, or else continue to generate a straight hook
            if bend_chance <= 0.1 then
                for x = (len-bend_amt)+1,len do
                    set_pos(x,y,z+1, "r_green")
                    set_pos(x,y,z+2, "happy_medium_grass")
                end

            -- Continue generating straight hook if bend chance is false
            else
                for x = (len-bend_amt),len do
                    set_pos(x,y,z, "r_green")
                end
            end
            -- Set the leftmost spot back to a start hook
            set_pos(0,y,z+1, "happy_start_hooks")
        end

        -- Check to place shrink rings
        if shrink_chance <= 0.07 then -- 7% chance!
            if bend_chance > 0.1 then
                add_bent(len,y,z+1, "bent_base_ring_green_danger")
            end
        end
    end
end