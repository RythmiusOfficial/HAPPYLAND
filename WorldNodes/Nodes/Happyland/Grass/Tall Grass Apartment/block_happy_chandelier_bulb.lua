function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_yellow_concrete"
end

function p.__main()
    set_default_block("e")
    std.create_edges("r_yellow")
    
    -- Create pool ball
    ment_start(7,7,7, "ment_monster_pool_ball_4")
    ment_set_offset(7.5,7.5,7.5)
    ment_end()

    -- Create trophy
    -- add_bent(7,7,7, "bent_trophy_st_chandelier")

    -- Create gold
    add_bent(7,7,5, "bent_gold_once_300")
end