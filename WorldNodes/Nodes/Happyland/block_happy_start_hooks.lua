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
    for i = 0,35 do
        srand = (seed_normal())
        -- Initializing variables
        local y = randi(0,15)
        local z = randi(0,14)

        local len = randi(3,14)
        local shrink_chance = randf()
        local bend_chance = randf()
        local bend_amt = 0

        -- Check bend chance
        if bend_chance <= 0.1 then
            bend_amt = randi(1,len)
        end
        
        -- Create hooks
        for x = 0,(len-bend_amt) do
            set_pos(x,y,z, "r_green")
            -- Bend, or else continue to generate a straight hook
            if bend_chance <= 0.1 then
                for x = (len-bend_amt)+1,len do
                    set_pos(x,y,z+1, "r_green")
                end
            -- Continue generating straight hook if bend chance is false
            else
                for x = (len-bend_amt),len do
                    set_pos(x,y,z, "r_green")
                end
            end
        end

        -- Check to place shrink rings
        if shrink_chance <= 0.07 then
            if bend_chance > 0.1 then
                add_bent(len,y,z+1, "bent_base_ring_green_danger")
            end
        end
    end

    -- debugging
    -- set_pos(15,15,0, "r_green")
end
