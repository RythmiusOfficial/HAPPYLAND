function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_rug_2"
end

function p.__main()
    local gold = 5
    local depth_limit = 9

    local parent_depth = 0
    local level = get_level()

    if (get_input_path_block_var_exists(level-1, "depth", "i")) then
        parent_depth = get_input_path_block_i(level-1, "depth")
    end

    local depth = parent_depth + 1
    chunk_set_i("depth", depth)

    if depth <= depth_limit then set_default_block("happy_rug_caves_2") end
    if depth > depth_limit then set_default_block("happy_rug_caves_3") end

    -- Create cave system
    caves_start()
    caves_set_5x5x5()
    caves_set_num_nodes(23.0, 45.99)
    caves_set_nodes(0.01, 3.0,4.3, 17.5,18.0)
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
            set_pos(x,y,z, "grow_air")
        end

        create_rect("happy_rug_caves_2", 0,0,0, 15,15,2)

        -- Add gold and rats!
        if close_to_node then
            local which_node = data.which_node
            local dist = data.dist
            local is_big = data.is_big

            if (dist < 1.5) and filled_nodes[which_node] == nil then
                if randf() <= 0.001 then -- 0.1% chance!
                    filled_nodes[which_node] = true
                    add_bent(x,y,z, "bent_gold_" .. tostring(gold))

                    -- Minor Bilge Rat
                    if randf() <= 0.5 then -- 0.005% chance!
                        ment_start(x,y,z, "ment_monster_rat_bilge_minor")
                        ment_set_offset(x,y,z)
                        ment_set_i("health", 1000) -- nerfed from 10,000
                        ment_end()
                    end
                end
            end
        end

        -- Add shrink rings
        if (get_pos(x,y,z) == "block_grow_air") and (get_pos(x,y,z-1) == "block_happy_rug_caves_2") then
            if randf() <= 0.001 then -- 0.1% chance!
                add_bent(x,y,z, "bent_base_ring_green")
            end
        end

        -- Text box
        if (get_pos(x,y,z) == "block_grow_air") then
            if randi(1,10000) == 1 then
                local msg = "^x00ff00Current Rug Level:^! 2\n"
                          .."^x00ff00Depth:^! " .. tostring(depth)
                add_bent_s(x,y,z, "bent_base_txt", msg)
            end
        end
    end end end
end

function p.__type_init(id)
    ia_block_new_var_i(id, "depth", 0)
end