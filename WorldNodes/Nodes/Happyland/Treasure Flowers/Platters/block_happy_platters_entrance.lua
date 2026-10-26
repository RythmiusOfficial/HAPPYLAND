function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green"
end

function p.__main()
    set_default_block("r_green")

    local chance = 30
    local monster = false
    local monster_type = 0
    
    -- Carve out tunnel
    create_rect("happy_air", 1,1,1, 14,14,15)

    -- Create windows
    create_rect("happy_air", 7,0,6, 8,0,8)

    create_rect("happy_air", 7,15,6, 8,15,8)

    create_rect("happy_air", 0,7,6, 0,8,8)

    create_rect("happy_air", 15,7,6, 15,8,8)
end
