function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("happy_air")

    -- Create Small Grass chunks on the floor
    create_rect("happy_small_grass", 0,0,0, 15,15,0)
    
    -- Create grass and Treasure Flowers (only if the grass is hollow)
    for i = 1,20 do
        local x = randi(0,14)
        local y = randi(0,15)

        local hollow_chance = randf()
        len = randi(3,11)
        for z = 0,(len-1) do
            if hollow_chance <= 0.05 then -- 5% chance!
                set_pos(x,y,z, "happy_med_grass_hollow")
                set_pos(x,y,len, "happy_treasure_flower")
            else
                set_pos(x,y,z, "r_green")
            end
            set_pos(x+1,y,z, "happy_grass_tube_0")
        end
    end
end