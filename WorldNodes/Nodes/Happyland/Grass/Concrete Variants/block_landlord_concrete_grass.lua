function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("landlord_office_air")

    local chance = 12
    local msg = ""
    local level = get_level()
    local fertile = get_input_path_block_b(level, "fertile")

    -- Create more concrete grass chunks on the floor
    create_rect("landlord_concrete_grass", 0,0,0, 15,15,0)
    
    -- Create grass
    for x = 0,14 do
    for y = 0,15 do
        if randi(1,chance) == 1 then
            local info_chance = randf()
            local shrink_chance = randf()
            local len = randi(3,11)
            for z = 0,(len-1) do
                if info_chance <= 0.02 then -- 2% chance!
                    set_pos(x,y,z, "r_white")
                    if fertile then
                        msg = "You are currently above a FERTILE chunk of ^x00ff00Concrete Grass^! "
                            .."Multiple things can spawn here, such as Concrete Platters and Concrete Treasure Flowers.\n\n"
                            .."^x00ff00Concrete Platters,^! similarly to their regular counterpart, have a battle shaft in the central stem. "
                            .."The treasure room, however, is a large ammo refill that you can use to survive the Office.\n\n"
                            .."Because you're in a FERTILE chunk of Concrete Grass, ^x00ff00Concrete Treasure Flowers^! can spawn here. "
                            .."They are depicted as a stoney variant of a Treasure Flower with a dark gray bulb.\n\n"
                            .."Using the keys the Concrete Treasure Flower provides, you can exit the Office to meet ^xff0000The Landlord.^!"
                    else
                        msg = "You are currently above an INFERTILE chunk of ^x00ff00Concrete Grass^! "
                            .."Multiple things can spawn here, such as Concrete Platters and Concrete Treasure Flowers.\n\n"
                            .."^x00ff00Concrete Platters,^! similarly to their regular counterpart, have a battle shaft in the central stem. "
                            .."The treasure room, however, is a large ammo refill that you can use to survive the Office.\n\n"
                            .."^x00ff00Concrete Treasure Flowers^! contain a long Apartment Key and can only spawn in FERTILE chunks of Concrete Grass.\n\n"
                            .."The only place to find a FERTILE chunk is on the central pillar in the Board Room of this Office. "
                            .."Continuing down the hallways will eventually lead you to the room."
                    end
                    add_bent_s(x,y,len+1, "bent_base_txt", msg)
                    set_pos(x,y,len-1, "r_info")
                elseif shrink_chance <= 0.01 then -- 1% chance!
                    add_bent(x,y,0, "bent_base_ring_green_danger")
                else
                    set_pos(x,y,z, "r_concrete_x")
                    if randi(1,200) == 1 then
                        set_pos(x,y,len, "expander_solid")
                    end
                end
            end
        end
    end end
end

function p.__type_init(id)
    ia_block_new_var_b(id, "fertile", false)
end