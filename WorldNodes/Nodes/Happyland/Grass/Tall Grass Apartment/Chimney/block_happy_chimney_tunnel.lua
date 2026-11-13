function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green_x"
end

function p.__main()
    local zpos = get_input_adj_bt(0,0,1)
    local zneg = get_input_adj_bt(0,0,-1)

    local basement = state_get_b("basement")
    local b_type = {}
    local block = ""
    local b_index = 0

    b_type[0] = "green"
    b_type[1] = "green_x"
    b_type[2] = "concrete"
    b_type[3] = "concrete_x"

    if basement then
        b_index = 2
    end

    block = b_type[b_index]

    set_default_block("r_" .. block)
    
    -- Create chimney layout
    block = b_type[b_index+1]
    create_rect("r_" .. block, 4,4,1, 12,12,15)
    create_rect("happy_smokey_air", 5,5,1, 11,11,15)

    -- hole
    set_pos(8,8,0, "expander_key_guard") -- expander block but with an apartment key guard in the center

    -- create Chimney Sweeper
    set_pos(8,8,1, "e")
    ment_start(8,8,1, "ment_monster_sweeper_chimney")
    ment_set_offset(8.5,8.5,1.5)
    ment_end()
end