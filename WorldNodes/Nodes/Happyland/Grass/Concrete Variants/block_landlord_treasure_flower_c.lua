function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("e")

    -- Create stem with variable length
    len = randi(4,9) -- Make sure to account for the height of the flower bud (3)
    for z = 0,(len-1) do
        set_pos(7,7,z, "r_concrete")
    end
    
    -- Create ‘petals’
    create_rect("r_concrete", 5,7,(len), 9,7,(len))
    create_rect("r_concrete", 7,5,(len), 7,9,(len))

    set_pos(5,7,(len+1), "r_concrete")
    set_pos(9,7,(len+1), "r_concrete")
    set_pos(7,5,(len+1), "r_concrete")
    set_pos(7,9,(len+1), "r_concrete")

    set_pos(7,7,(len+2), "landlord_treasure_c")

    set_pos(7,7,len, "expander")

    -- Create shrink rings
    add_bent(4,7,len+1, "bent_base_ring_green")
    add_bent(10,7,len+1, "bent_base_ring_green")
    add_bent(7,4,len+1, "bent_base_ring_green")
    add_bent(7,10,len+1, "bent_base_ring_green")

    -- Create platter chunks
    set_pos(5,7,(len+2), "landlord_platters_c")
    block_set_b(5,7,(len+2), "fertile", true)
    set_pos(9,7,(len+2), "landlord_platters_c")
    block_set_b(5,7,(len+2), "fertile", true)
    set_pos(7,5,(len+2), "landlord_platters_c")
    block_set_b(5,7,(len+2), "fertile", true)
    set_pos(7,9,(len+2), "landlord_platters_c")
    block_set_b(5,7,(len+2), "fertile", true)
end
