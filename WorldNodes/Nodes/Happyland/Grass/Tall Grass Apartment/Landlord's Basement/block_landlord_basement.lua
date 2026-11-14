function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_concrete"
end

function p.__main()
    set_default_block("e")
    std.create_shell("r_concrete")

    local x_table = {}
    local y_table = {}

    local basement = state_get_b("basement")

    for x = 3,14,2 do
        table.insert(x_table, x)
    end
    for y = 3,14,2 do
        table.insert(y_table, y)
    end

    local vertex_index_x = randi(1, #x_table)
    local vertex_index_y = randi(1, #y_table)

    local rand_posx = x_table[vertex_index_x]
    local rand_posy = y_table[vertex_index_y]

    -- Layer 1-3 - Maze
    create_rect("r_concrete", 1,1,13, 14,14,15)

    for z = 13,15,1 do
        maze_start()

        for x = 1,13,2 do
        for y = 1,13,2 do
            maze_add_vertex(x,y,z)
            set_pos(x,y,z, "landlord_b_room")
        end end

        -- Create edges
        for x = 1,13,2 do
        for y = 1,13,2 do
            if (x+2 <= 13) then
                maze_add_edge(x,y,z, x+2,y,z)
            end
            if (y+2 <= 13) then
                maze_add_edge(x,y,z, x,y+2,z)
            end
        end end

        maze_end()

        -- Create hallways
        for x = 1,13,2 do
        for y = 1,13,2 do
            if (x+2 <= 13) then
                if maze_edge_open(x,y,z, x+2,y,z) then
                    set_pos(x+1,y,z, "landlord_b_hall")
                end
            end
            if (y+2 <= 13) then
                if maze_edge_open(x,y,z, x,y+2,z) then
                    set_pos(x,y+1,z, "landlord_b_hall")
                end
            end
        end end

        -- Create tunnel to the next layer
        local cur_x = rand_posx
        local cur_y = rand_posy

        while cur_x == rand_posx do
            vertex_index_x = randi(1, #x_table)
            rand_posx = x_table[vertex_index_x]
        end
        while cur_y == rand_posy do
            vertex_index_y = randi(1, #y_table)
            rand_posy = y_table[vertex_index_y]
        end

        set_pos(rand_posx,rand_posy,z, "landlord_b_room_tunnel")
    end

    -- Create entrance if basement is opened
    if basement then
        set_pos(1,1,15, "landlord_b_room_entrance")
        add_bent(1,1,15, "bent_base_ring_green_danger")
    end

    -- Layer 4 - In-Between Space
    create_rect("landlord_inbetween_pillars", 1,1,12, 14,14,12)
    set_pos(14,14,12, "landlord_info_4")

    -- Layer 5 - Office
    -- Placeholder rectangle
    create_rect("r_concrete", 1,1,11, 14,14,11)

    -- Layer 6-8 - Stairwell
    -- Placeholder

    -- Layer 9 - Boss Room
    -- Placeholder

    -- Layer 10-16 - Treasure Vault
    -- Placeholder
end