function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("e")

    -- Create cave system
    caves_start()
    caves_set_5x5x5()
    caves_set_num_nodes(8.0, 11.99)
    caves_set_nodes(0.01, 3.0,4.3, 6.0,7.0) -- 67 ._.
    caves_end()

    -- Carve out cave data
    local filled_nodes = {}

    for z = 0,15 do
    for x = 0,15 do
    for y = 0,15 do
        local close_to_edge = caves_close_to_edge(x,y,z)

        local data = caves_close_to_node2(x,y,z)
        local close_to_node = data.close

        if close_to_node or close_to_edge then
            set_pos(x,y,z, "happy_rug_caves_2")
        end

        -- Add monsters!
        if randi(1,1000) == 1 then
            ment_start(x,y,z, "ment_monster_power_sweeper") -- unnerfed
            ment_set_offset(x,y,z)
            ment_end()
        end
    end end end
end