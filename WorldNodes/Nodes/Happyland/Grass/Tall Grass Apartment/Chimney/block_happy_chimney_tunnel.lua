function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green_x"
end

function p.__main()
    set_default_block("r_green")
    
    -- Create chimney layout
    create_rect("r_green_x", 4,4,1, 12,12,15)
    create_rect("happy_smokey_air", 5,5,1, 11,11,15)

    -- hole
    set_pos(8,8,0, "expander")

    -- create Chimney Sweeper
    set_pos(8,8,1, "e")
    ment_start(8,8,1, "ment_monster_chimney_sweeper")
    ment_set_offset(8.5,8.5,1.5)
    ment_end()
end