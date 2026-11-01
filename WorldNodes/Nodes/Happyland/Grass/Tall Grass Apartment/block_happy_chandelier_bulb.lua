function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_yellow_concrete"
end

function p.__main()
    set_default_block("e")
    std.create_edges("r_yellow")

    chunk_set_i("floor_chand", 1)

    floor_num = floor_chand
    
    -- Create pool ball
    --ment_start(7,7,7, "ment_monster_pool_ball_" .. tostring(floor_chand))
    --ment_set_offset(7.5,7.5,7.5)
    --ment_end()

    -- Create trophy
    -- add_bent(7,7,7, "bent_trophy_st_chandelier")

    -- Create gold
    add_bent(7,7,5, "bent_gold_once_5")
    print(tostring(floor_chand))
end

function p.__type_init(id)
    ia_block_new_var_i(id, "floor_chand", 2)
end