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
    set_pos(14,1,12, "landlord_info_4")

    -- Layer 5 - Office
    create_rect("r_concrete", 1,1,11, 14,14,11)                 -- placeholder rectangle
    set_pos(14,1,11, "landlord_office_entrance")                -- entrance
        -- halls - perimeter
    create_rect("landlord_office_hall", 2,2,11, 14,2,11)
    create_rect("landlord_office_hall", 2,2,11, 2,13,11)
    create_rect("landlord_office_hall", 2,13,11, 13,13,11)
    create_rect("landlord_office_hall", 13,4,11, 13,13,11)
        -- halls - other
    create_rect("landlord_office_hall", 5,8,11, 5,10,11)
    create_rect("landlord_office_hall", 5,10,11, 10,10,11)
    set_pos(10,5,11, "landlord_office_hall")
    create_rect("landlord_office_hall", 10,4,11, 13,4,11)
        -- rooms
    set_pos(8,3,11, "landlord_office_room")                     -- 1
    block_set_i(8,3,11, "room", 1)
    set_pos(5,1,11, "landlord_office_room")                     -- 2
    block_set_i(5,1,11, "room", 2)
    set_pos(3,6,11, "landlord_office_room")                     -- 3
    block_set_i(3,6,11, "room", 3)
    set_pos(3,8,11, "landlord_office_room")                     -- 4
    set_pos(1,8,11, "landlord_office_room")                     -- 5
    set_pos(3,11,11, "landlord_office_room")                    -- 6
    set_pos(8,12,11, "landlord_office_room")                    -- 7
    block_set_i(8,12,11, "room", 7)
    set_pos(11,12,11, "landlord_office_room")                   -- 8
    set_pos(12,9,11, "landlord_office_room")                    -- 9
    block_set_i(12,9,11, "room", 9)
    set_pos(14,6,11, "landlord_office_room")                    -- 10
    block_set_i(14,6,11, "room", 10)
    create_rect("landlord_office_room_board", 9,6,11, 11,8,11)  -- boardrooms
    set_pos(5,6,11, "landlord_office_exit")                     -- exit
        -- apartment key halls
    set_pos(5,7,11, "landlord_office_hall_key")
    set_pos(10,9,11, "landlord_office_hall_key")

    -- Layer 6-8 - Stairwell
    -- Placeholder

    -- Layer 9 - Boss Room
    -- Placeholder

    -- Layer 10-16 - Treasure Vault
    -- Placeholder
end