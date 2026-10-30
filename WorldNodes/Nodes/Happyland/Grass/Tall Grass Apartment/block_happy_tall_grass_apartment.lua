function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green_x"
end

function p.__main()
    set_default_block("happy_air")

    local floors = randi(2,6)

    local w_table = {}
    local l_table = {}

    for x = 5,15,2 do
        table.insert(w_table, x)
    end
    for y = 5,15,2 do
        table.insert(l_table, y)
    end

    local width = randi(1, #w_table)
    local length = randi(1, #l_table)
    local rand_width = w_table[width]
    local rand_length = l_table[length]

    local w_amt = 16-rand_width
    local l_amt = 16-rand_length
    local aw = math.floor(w_amt/2) -- negative space width
    local al = math.floor(l_amt/2) -- negative space length
    local o_aw = aw + 1 -- odd apartment width
    local o_al = al + 1 -- odd apartment length

    local vertex_regionx = {}
    local vertex_regiony = {}

    for x = (0+aw+1),(15-o_aw-1),2 do
        table.insert(vertex_regionx, x)
    end
    for y = (0+al+1),(15-o_al-1),2 do
        table.insert(vertex_regiony, y)
    end

    local vertex_index_x = randi(1, #vertex_regionx)
    local vertex_index_y = randi(1, #vertex_regiony)

    local rand_posx = vertex_regionx[vertex_index_x]
    local rand_posy = vertex_regiony[vertex_index_y]

    -- Create tall grass floor
    create_rect("happy_tall_grass", 0,0,0, 15,15,0)
    
    -- Create an airless region that will get carved out
    create_rect("r_green", (0+aw),(0+al),0, (15-o_aw),(15-o_al),(floors+1))
 
    -- Create maze vertexes
    for z = 1,floors do
        maze_start()
   
        for x = (0+aw),(15-o_aw),2 do
        for y = (0+al),(15-o_al),2 do
            maze_add_vertex(x,y,z)
            set_pos(x,y,z, "happy_tall_grass_a_room")
        end end

        -- Create edges
        for x = (0+aw),(15-o_aw),2 do
        for y = (0+al),(15-o_al),2 do
            if (x+2 <= (15-o_aw)) then
                maze_add_edge(x,y,z, x+2,y,z)
            end
            if (y+2 <= (15-o_al)) then
                maze_add_edge(x,y,z, x,y+2,z)
            end
        end end
 
        maze_end()

        -- Add hallways
        for x = (0+aw),(15-o_aw),2 do
        for y = (0+al),(15-o_al),2 do
            if (x+2 <= (15-o_aw)) then
                if maze_edge_open(x,y,z, x+2,y,z) then
                    set_pos(x+1,y,z, "happy_tall_grass_a_hall")
                end
            end
            if (y+2 <= (15-o_al)) then
                if maze_edge_open(x,y,z, x,y+2,z) then
                    set_pos(x,y+1,z, "happy_tall_grass_a_hall")
                end
            end
        end end
    end

    -- Treasure room; delete its coordinates from the array so the stairs don't overwrite it :(
    if floors == 6 then
        set_pos(rand_posx,rand_posy,6, "happy_tall_grass_a_treasure")
        table.remove(vertex_regionx, vertex_index_x)
        table.remove(vertex_regiony, vertex_index_y)

        vertex_index_x = randi(1, #vertex_regionx)
        vertex_index_y = randi(1, #vertex_regiony)

        rand_posx = vertex_regionx[vertex_index_x]
        rand_posy = vertex_regiony[vertex_index_y]
    end

    -- Staircase
    for z = 1,floors do
        set_pos(rand_posx,rand_posy,z, "happy_tall_grass_a_staircase")
    end

    -- Chimney
    -- Placeholder

    -- Kitchen
    -- Placeholder

    print(table.concat(vertex_regionx))
    print(table.concat(vertex_regiony))
end