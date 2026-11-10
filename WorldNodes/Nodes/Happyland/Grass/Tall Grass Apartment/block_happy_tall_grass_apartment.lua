function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green_x"
end

function p.__main()
    set_default_block("happy_air")

    local floors = 6
    local msg = ""

    local kitchen = randi(1,7) -- 14.3% chance :)

    local w_table = {}
    local l_table = {}

    for x = 7,13,2 do
        table.insert(w_table, x)
    end
    for y = 7,13,2 do
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

    -- Room floor variable setting
    for z = 1,floors do
    for x = (0+aw),(15-o_aw),2 do
    for y = (0+al),(15-o_al),2 do
        block_set_i(x,y,z, "floor_num", z)
    end end end

    -- Staircases
    for z = 1,(floors-1) do
        create_rect("happy_tall_grass_a_staircase", rand_posx,rand_posy,z, rand_posx,rand_posy,z+1)
        
        local cur_x = rand_posx
        local cur_y = rand_posy

        vertex_index_x = randi(1, #vertex_regionx)
        vertex_index_y = randi(1, #vertex_regiony)

        rand_posx = vertex_regionx[vertex_index_x]
        rand_posy = vertex_regiony[vertex_index_y]

        -- checks to see if the staircase below has already been generated in the previous floor below
        while cur_x == rand_posx do
            vertex_index_x = randi(1, #vertex_regionx)
            rand_posx = vertex_regionx[vertex_index_x]
        end
        while cur_y == rand_posy do
            vertex_index_y = randi(1, #vertex_regiony)
            rand_posy = vertex_regiony[vertex_index_y]
        end
    end

    -- Treasure room; can overwrite stairs which might prove to be an issue later; please fix me
    if floors == 6 then
        set_pos(rand_posx,rand_posy,6, "happy_tall_grass_a_treasure")
        if kitchen == 1 then
            block_set_b(rand_posx,rand_posy,6, "kitchen", true)
        end

        vertex_index_x = randi(1, #vertex_regionx)
        vertex_index_y = randi(1, #vertex_regiony)

        rand_posx = vertex_regionx[vertex_index_x]
        rand_posy = vertex_regiony[vertex_index_y]
    end

    -- Pink Dest, shrink, and text box
    add_bent((0+aw-1),(0+al-1),0, "bent_base_ring_pink_dest")
    add_bent((0+aw-1),(0+al+1),0, "bent_base_ring_green_danger")
    msg = "This is a ^x00ff00Tall Grass Apartment^!, a fine establishment hosted by a being known as The Landlord. "
        .."The treasure consists of many upgrades for your Plasma weapon, including a rare Fire Rate upgrade.\n\n"
        .."In order to reach the treasure, you must navigate through each floor of the six-story Apartment. "
        .."To go up a floor, you must find a brown Staircase. These will take you up one floor at at time and are guarded with Apartment Key Guards. "
        .."Further information such as Apartment Key locations can be found on the table furniture that can be found throughout the rooms."
    add_bent_s((0+aw-1),(0+al+3),0, "bent_base_txt", msg)

    -- Chimney
    create_rect("happy_tall_grass_a_chimney", (0+aw+1),(0+al+1),8, (0+aw+1),(0+al+1),10)

    -- Secret Kitchen
    if kitchen == 1 then
        set_pos((0+aw+1),(0+al+1),7, "happy_chimney_tunnel")
        set_pos((0+aw+1),(0+al+1),6, "happy_tall_grass_a_kitchen")
    end
end