function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_yellow_concrete"
end

function p.__main()
    set_default_block("e")
    std.create_edges("r_yellow")

    local level = get_level()
    local floor_chand = get_input_path_block_i(level, "floor_chand")

    -- Create pool ball
    ment_start(7,7,7, "ment_monster_pool_ball_" .. tostring(floor_chand))
    ment_set_offset(7.5,7.5,7.5)
    ment_end()

    -- Create trophy
    if floor_chand == 6 then
        add_bent(7,7,9, "bent_trophy_st_chandelier")
    end

    -- Create key
    add_bent_i(7,7,7, "bent_key_apartment", 25)

    -- Create gold
    add_bent(7,7,5, "bent_gold_once_5")
end

function p.__type_init(id)
    ia_block_new_var_i(id, "floor_chand", 2)
end