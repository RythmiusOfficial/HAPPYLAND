function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_white_concrete"
end

function p.__main()
    set_default_block("e")
    std.create_edges("r_white")

    -- Create key and enemies
    add_bent_i(7,7,7, "bent_key_apartment", 140)

    for x = 3,12,9 do
    for y = 3,12,9 do
    for z = 3,12,9 do
        ment_start(x,y,z, "ment_monster_agent_assimilated")
        ment_set_offset(x,y,z)
        ment_end()
    end end end

    ment_start(7,7,7, "ment_monster_agent_integrated")
    ment_set_offset(8,8,8)
    ment_end()
end