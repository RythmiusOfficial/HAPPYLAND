function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("happy_air")
    
    -- Create floor grass
    create_rect("happy_small_grass", 0,0,0, 15,15,0)

    -- Create grass
    for i = 1,20 do
        local x = randi(0,15)
        local y = randi(0,15)
        local spawn_chance = randf()
        len = randi(3,7)

        for z = 0,(len-1) do
            set_pos(x,y,z, "r_green")
        end
        -- Create tall grass on top
        set_pos(x,y,len, "happy_tall_grass")
    
        -- Create dangerous shrink two blocks above top if spawn chance is satisfied
        if spawn_chance <= 0.02 then -- 2% chance!
            add_bent(x,y,len+2, "bent_base_ring_green_danger")
        end
    end
end