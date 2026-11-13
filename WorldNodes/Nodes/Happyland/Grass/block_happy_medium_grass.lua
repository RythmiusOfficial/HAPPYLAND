function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("happy_air")

    local chance = 12
    local msg = ""

    -- Create Small Grass chunks on the floor
    create_rect("happy_small_grass", 0,0,0, 15,15,0)
    
    -- Create grass and Treasure Flowers (only if the grass is hollow)
    for x = 0,14 do
    for y = 0,15 do
        if randi(1,chance) == 1 then
            local hollow_chance = randf()
            local info_chance = randf()
            local shrink_chance = randf()
            local len = randi(3,11)
            local info = false
            for z = 0,(len-1) do
                if hollow_chance <= 0.11 then -- 11% chance!
                    set_pos(x,y,z, "happy_med_grass_hollow")
                    set_pos(x,y,len, "happy_treasure_flower")
                elseif info_chance <= 0.02 then -- 2% chance!
                    set_pos(x,y,z, "r_white")
                    msg = "You are currently above ^x00ff00Medium Grass!^!\n\n"
                        .."If you shrink here, you can find ^x00ff00Small Grass^! growing on the floor."
                    add_bent_s(x,y,len+1, "bent_base_txt", msg)
                    info = true
                    if randi(1,2) == 1 then
                        set_pos(x,y,len-1, "hollow_info")
                    else
                        set_pos(x,y,len-1, "r_info")
                    end
                elseif shrink_chance <= 0.01 then -- 1% chance!
                    add_bent(x,y,0, "bent_base_ring_green_danger")
                else
                    set_pos(x,y,z, "r_green")
                end
                if not info then
                    set_pos(x+1,y,z, "happy_grass_tube_0")
                end
            end
        end
    end end
end