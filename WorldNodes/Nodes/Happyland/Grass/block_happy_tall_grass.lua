function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("happy_air")

    local chance = 12
    
    -- Create tall grass floor
    create_rect("happy_tall_grass", 0,0,0, 15,15,0)
    
    -- Create grass and start hooks, and maybe the Apartment
    for x = 0,14 do
    for y = 0,15 do
        if randi(1,chance) == 1 then
            len = randi(3,16)
            local apmt_chance = randf()
            local info_chance = randf()
            if apmt_chance <= 0.08 then -- 8% chance!
                set_pos(x,y,0, "happy_tall_grass_apartment")
            else
                for z = 0,(len-1) do
                    if info_chance <= 0.02 then -- 2% chance!
                        if len < 15 then
                            set_pos(x,y,z, "r_white")
                            msg = "You are currently above ^x00ff00Tall Grass!^!\n\n"
                                .."If you shrink here, you can find ^x00ff00Tall Grass Apartments!^! "
                                .."You can re-enter Happy Land through the \"Start Hooks\" growing on the Left sides of the Tall Grass blades, "
                                .."because it is a bit difficult to escape Tall Grass."
                            add_bent_s(x,y,len+1, "bent_base_txt", msg)
                            if randi(1,3) == 1 then
                                set_pos(x,y,len-1, "hollow_info")
                            else
                                set_pos(x,y,len-1, "r_info")
                            end
                        end
                    else
                        set_pos(x,y,z, "r_green")
                        set_pos(x+1,y,z, "happy_start_hooks")
                    end
                end
            end
        end
    end end
end