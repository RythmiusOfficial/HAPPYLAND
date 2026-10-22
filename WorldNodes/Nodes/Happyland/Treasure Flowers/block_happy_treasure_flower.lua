function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("happy_air")

    -- Create stem with variable length
    treasure = randi(1,3)
    len = randi(4,9) -- Make sure to account for the height of the flower bud (3)
    for z = 0,(len-1) do
        set_pos(7,7,z, "r_green")
    end
    
    -- Create ‘petals’
    create_rect("r_green", 5,7,(len), 9,7,(len))
    create_rect("r_green", 7,5,(len), 7,9,(len))

    set_pos(5,7,(len+1), "r_green")
    set_pos(9,7,(len+1), "r_green")
    set_pos(7,5,(len+1), "r_green")
    set_pos(7,9,(len+1), "r_green")
    
    -- Create treasure
    if treasure == 1 then
        set_pos(7,7,(len+2), "happy_treasure_yellow")
    end
    if treasure == 2 then
        set_pos(7,7,(len+2), "happy_treasure_orange")
    end
    if treasure == 3 then
        set_pos(7,7,(len+2), "happy_exit_cube")
    end

    -- Create platter chunks
    set_pos(5,7,(len+2), "happy_platters")
    set_pos(9,7,(len+2), "happy_platters")
    set_pos(7,5,(len+2), "happy_platters")
    set_pos(7,9,(len+2), "happy_platters")
end