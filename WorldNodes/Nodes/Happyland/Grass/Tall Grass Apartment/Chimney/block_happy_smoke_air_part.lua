function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return("block_concrete")
end

function p.__main()
    set_default_block("happy_smokey_air")
    std.create_edges("r_concrete")
    create_rect("r_concrete", 2,2,2, 13,13,13)
    create_rect("e", 3,3,3, 12,12,12)

    -- Create maze vertexes
    maze_start()

    for x = 3,12,2 do
    for y = 3,12,2 do
    for z = 3,12,2 do
        maze_add_vertex(x,y,z)
        set_pos(x,y,z, "happy_smoke_particle_room")
    end end end
    
    -- Create edges
    for x = 3,12,2 do
    for y = 3,12,2 do
    for z = 3,12,2 do
        if (x+2 <= 12) then
            maze_add_edge(x,y,z, x+2,y,z)
        end
        if (y+2 <= 12) then
            maze_add_edge(x,y,z, x,y+2,z)
        end
        if (z+2 <= 12) then
            maze_add_edge(x,y,z, x,y,z+2)
        end
    end end end

    maze_end()

    -- Add hallways
    for x = 3,12,2 do
    for y = 3,12,2 do
    for z = 3,12,2 do
        if (x+2 <= 12) then
            if maze_edge_open(x,y,z, x+2,y,z) then
                set_pos(x+1,y,z, "happy_smoke_particle_hall")
            end
        end
        if (y+2 <= 12) then
            if maze_edge_open(x,y,z, x,y+2,z) then
                set_pos(x,y+1,z, "happy_smoke_particle_hall")
            end
        end
        if (z+2 <= 12) then
            if maze_edge_open(x,y,z, x,y,z+2) then
                set_pos(x,y,z+1, "happy_smoke_particle_hall")
            end
        end
    end end end

    -- Create entrance
    set_pos(3,3,11, "happy_smoke_particle_entrance")
    set_pos(3,3,12, "plug")
    set_pos(4,3,12, "r_concrete")
    set_pos(3,4,12, "r_concrete")
    set_pos(3,3,13, "plug")

    -- Create treasure rooms (any dead end on the bottom floor will be a treasure room)
    for x = 3,12,2 do
    for y = 3,12,2 do
        if maze_num_edges_from_vertex(x,y,3) == 1 then
            set_pos(x,y,3, "happy_smoke_particle_treasure")
        end
    end end

    -- Create shrink ring
    set_pos(3,3,13, "e")
    add_bent(3,3,13, "bent_base_ring_green")
end