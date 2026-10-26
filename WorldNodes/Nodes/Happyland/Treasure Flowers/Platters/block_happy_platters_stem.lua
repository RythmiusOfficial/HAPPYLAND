function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green"
end

function p.__main()
    set_default_block("r_green")

    local chance = 800
    local monster_type = 0
    
    -- Carve out tunnel
    create_rect("happy_air", 1,1,0, 14,14,15)

    -- Create windows
    create_rect("r_black", 6,0,5, 9,0,9)
    create_rect("glass", 7,0,6, 8,0,8)

    create_rect("r_black", 6,15,5, 9,15,9)
    create_rect("glass", 7,15,6, 8,15,8)

    create_rect("r_black", 0,6,5, 0,9,9)
    create_rect("glass", 0,7,6, 0,8,8)

    create_rect("r_black", 15,6,5, 15,9,9)
    create_rect("glass", 15,7,6, 15,8,8)

    -- Create monsters
    for x = 2,13 do
    for y = 2,13 do
    for z = 0,15 do
        local monster = false
        if monster == false then
            monster_type = randi(0,2)
            if randi(1,chance) == 1 then
                if monster_type == 0 then
                    ment_start(x,y,z, "ment_monster_goblin")
                    ment_set_offset(x,y,z)
                    ment_end()
                    monster = true
                end
                if monster_type == 1 then
                    ment_start(x,y,z, "ment_monster_marine_light")
                    ment_set_offset(x,y,z)
                    ment_end()
                    monster = true
                end
                if monster_type == 2 then
                    ment_start(x,y,z, "ment_monster_imp")
                    ment_set_offset(x,y,z)
                    ment_end()
                    monster = true
                end
            end
        end
    end end end
end
