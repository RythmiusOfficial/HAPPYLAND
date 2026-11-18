function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_dark_gray"
end

function p.__main()
    set_default_block("r_dark_gray")

    local chance = 800
    
    -- Carve out tunnel
    create_rect("landlord_office_air", 1,1,0, 14,14,15)

    -- Create windows
    create_rect("r_white", 6,0,5, 9,0,9)
    create_rect("glass", 7,0,6, 8,0,8)

    create_rect("r_white", 6,15,5, 9,15,9)
    create_rect("glass", 7,15,6, 8,15,8)

    create_rect("r_white", 0,6,5, 0,9,9)
    create_rect("glass", 0,7,6, 0,8,8)

    create_rect("r_white", 15,6,5, 15,9,9)
    create_rect("glass", 15,7,6, 15,8,8)

    -- Create monsters
    for x = 2,13 do
    for y = 2,13 do
    for z = 0,15 do
        local monster = false
        if monster == false then
            if randi(1,chance) == 1 then
                ment_start(x,y,z, "ment_monster_agent_conformed")
                ment_set_offset(x,y,z)
                ment_end()
                monster = true
            end
        end
    end end end
end