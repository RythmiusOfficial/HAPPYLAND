function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("happy_air")
    
    -- Create grass tubing
    for i = 1,15 do
        local y = randi(1,15)
        local z = randi(0,14)

        shrink_chance = randf()
        len = randi(3,15)

        for x = 0,(len-1) do
            set_pos(x,y,z, "happy_grass_tube_1")
        end
    end
end