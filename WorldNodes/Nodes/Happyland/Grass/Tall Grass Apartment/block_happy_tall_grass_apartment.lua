function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green_x"
end

function p.__main()
    set_default_block("happy_air")

    local treasure_chance = randf()

    local width = randi(5,15)
    local length = randi(5,15)
    local w_amt = 16-width
    local l_amt = 16-length
    local aw = math.floor(w_amt/2) -- negative space width
    local al = math.floor(l_amt/2) -- negative space length
    local o_aw = 0 -- odd apartment width
    local o_al = 0 -- odd apartment length

    -- set odd width if width is odd
    if width % 2 == 0 then
        o_aw = aw
    else
        o_aw = aw + 1
    end

    -- set odd width if width is odd
    if length % 2 == 0 then
        o_al = al
    else
        o_al = al + 1
    end

    -- Create tall grass floor
    create_rect("happy_tall_grass", 0,0,0, 15,15,0)
    
    -- Create an airless region that will get carved out
    create_rect("r_green", (0+aw),(0+al),0, (15-o_aw),(15-o_al),2)
 
    -- Create maze vertexes
    maze_start()
    
    for x = (0+aw),(15-o_aw),2 do
    for y = (0+al),(15-o_al),2 do
        maze_add_vertex(x,y,1)
        set_pos(x,y,1, "happy_tall_grass_a_room")
    end end
    
    -- Treasure room
    if treasure_chance <= 0.1 then -- 10% chance
        set_pos(7,7,1, "happy_tall_grass_a_treasure")
    end

    -- Create edges
    for x = (0+aw),(15-o_aw),2 do
    for y = (0+al),(15-o_al),2 do
        if (x+2 <= (15-o_aw)) then
            maze_add_edge(x,y,1, x+2,y,1)
        end
        if (y+2 <= (15-o_al)) then
            maze_add_edge(x,y,1, x,y+2,1)
        end
    end end
 
    maze_end()

    -- Add hallways
    for x = (0+aw),(15-o_aw),2 do
    for y = (0+al),(15-o_al),2 do
        if (x+2 <= (15-o_aw)) then
            if maze_edge_open(x,y,1, x+2,y,1) then
                set_pos(x+1,y,1, "happy_tall_grass_a_hall")
            end
        end
        if (y+2 <= (15-o_al)) then
            if maze_edge_open(x,y,1, x,y+2,1) then
                set_pos(x,y+1,1, "happy_tall_grass_a_hall")
            end
        end
    end end

   -- Chimney (later)
   -- Placeholder
end