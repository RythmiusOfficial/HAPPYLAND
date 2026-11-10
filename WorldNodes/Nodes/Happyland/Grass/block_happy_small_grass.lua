function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("happy_air")

    local chance = 12
    
    -- Create floor grass
    create_rect("happy_small_grass", 0,0,0, 15,15,0)

    -- Create grass
    for x = 0,15 do
    for y = 0,15 do
        if randi(1,chance) == 1 then
            local spawn_chance = randf()
            local info_chance = randf()
            len = randi(3,7)

            for z = 0,(len-1) do
                if info_chance <= 0.02 then -- 2% chance!
                    set_pos(x,y,z, "r_white")
                    msg = "You are currently above ^x00ff00Small Grass!^!\n\n"
                        .."If you shrink here, you can find ^x00ff00Small Grass^! growing on the floor, and ^x00ff00Tall Grass^! growing on the tops of Small Grass blades!\n\n"
                        .."Tall Grass is important because they contain structures known as ^x00ff00Tall Grass Apartments^!, which have lots of upgrades for your Plasma weapon. "
                        .."Apartments appear as green boxes with Xs on them. "
                        .."They also contain a ton of cool areas and ^xc2009elate-game secrets!^!"
                    add_bent_s(x,y,len+1, "bent_base_txt", msg)
                    set_pos(x,y,len, "r_info")
                else
                    set_pos(x,y,z, "r_green")
                    -- Create tall grass on top
                    set_pos(x,y,len, "happy_tall_grass")
                end
            end
        
            -- Create dangerous shrink two blocks above top if spawn chance is satisfied
            if spawn_chance <= 0.02 then -- 2% chance!
                add_bent(x,y,len+2, "bent_base_ring_green_danger")
            end
        end
    end end
end