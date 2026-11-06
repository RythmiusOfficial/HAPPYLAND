function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("happy_air")

    local chance = 12
    
    -- Create tall grass floor
    create_rect("happy_tall_grass", 0,0,0, 15,15,0)
    
    -- Create grass and start hooks, and maybe the Apartment
    for x = 0,14 do
    for y = 0,15 do
        if randi(1,chance) == 1 then
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
    end end
end