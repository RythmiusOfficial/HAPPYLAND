function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_concrete"
end

function p.__main()
    set_default_block("happy_exit_cube_air")
    std.create_edges("r_concrete")
    create_rect("r_concrete", 4,4,4, 11,11,11)
    create_rect("e", 5,5,5, 10,10,10)

    -- Create maze vertexes
    maze_start()

    for x = 5,10,2 do
    for y = 5,10,2 do
    for z = 5,10,2 do
        maze_add_vertex(x,y,z)
        set_pos(x,y,z, "happy_exit_particle_room")
    end end end
    
    -- Create edges
    for x = 5,10,2 do
    for y = 5,10,2 do
    for z = 5,10,2 do
        if (x+2 <= 10) then
            maze_add_edge(x,y,z, x+2,y,z)
        end
        if (y+2 <= 10) then
            maze_add_edge(x,y,z, x,y+2,z)
        end
        if (z+2 <= 10) then
            maze_add_edge(x,y,z, x,y,z+2)
        end
    end end end

    maze_end()

    -- Add hallways
    for x = 5,10,2 do
    for y = 5,10,2 do
    for z = 5,10,2 do
        if (x+2 <= 10) then
            if maze_edge_open(x,y,z, x+2,y,z) then
                set_pos(x+1,y,z, "happy_exit_particle_hall")
            end
        end
        if (y+2 <= 10) then
            if maze_edge_open(x,y,z, x,y+2,z) then
                set_pos(x,y+1,z, "happy_exit_particle_hall")
            end
        end
        if (z+2 <= 10) then
            if maze_edge_open(x,y,z, x,y,z+2) then
                set_pos(x,y,z+1, "happy_exit_particle_hall")
            end
        end
    end end end

    -- Create entrance
    set_pos(5,5,10, "plug")
    set_pos(5,5,11, "plug")
    set_pos(5,5,9, "happy_exit_particle_entrance")

    -- Create treasure rooms (any dead end on the bottom floor will be a treasure room)
    for x = 5,10,2 do
    for y = 5,10,2 do
        if maze_num_edges_from_vertex(x,y,5) == 1 then
            set_pos(x,y,5, "happy_exit_particle_treasure")
        end
    end end

    -- Create pink sphere and shrink ring
    set_pos(10,10,12, "e")
    add_bent(10,10,12, "bent_base_ring_pink_dest")
    set_pos(5,5,12, "e")
    add_bent(5,5,12, "bent_base_ring_green")
end