function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("happy_air")
    
    -- Create tall grass floor
    create_rect("happy_tall_grass", 0,0,0, 15,15,0)
    
    -- Create grass and start hooks, and maybe the Apartment
    for i = 1,15 do
        local x = randi(0,14)
        local y = randi(0,15)
        len = randi(3,16)
        local apmt_chance = randf()
        if apmt_chance <= 0.05 then -- 5% chance!
            set_pos(x,y,0, "happy_tall_grass_apartment")
        else
            for z = 0,(len-1) do
                set_pos(x,y,z, "r_green")
                set_pos(x+1,y,z, "happy_start_hooks")
            end
        end
    end
end