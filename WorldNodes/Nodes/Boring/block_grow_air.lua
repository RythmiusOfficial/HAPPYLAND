function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("grow_air")

    g_cube = false
    
    amount_chance = 80

    for i = 1,4 do
        local x = randi(0,15)
        local y = randi(0,15)
        local z = randi(0,15)
        
        -- Grow ring
        if randi(1,amount_chance) == 1 then
            if g_cube == false then
                add_bent(x,y,z, "bent_base_ring_red")
                -- Set to 'used'
                g_cube = truestd
            end
        end
    end
end