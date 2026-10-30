function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green_x"
end

function p.__main()
    set_default_block("e")
    local furn_type = randi(1,7) -- 4 used, 3 unused; results in a 57% chance of there being a furnishing in the room
    local resident_chance = randf()
    local resident = randi(1,5)
    local resident_name = randi(1,20)
    local msg = ""
    local msg_num = randi(1,7)

    local chand_len = randi(4,7)

    local t_leg_h = randi(2,6)
    local table_w = randi(3,7) -- x
    local table_l = randi(3,7) -- y
    local t_leg_w = math.floor(table_w/2) -- x leg offset amt
    local t_leg_l = math.floor(table_l/2) -- y leg offset amt
    local t_off_x = randi(1+t_leg_w,14-t_leg_w) -- origin offset x
    local t_off_y = randi(1+t_leg_l,14-t_leg_l) -- origin offset y

    local rug_w = randi(3,7)
    local rug_l = randi(3,7)
    local rw = math.floor(rug_w/2) -- x offset amt
    local rl = math.floor(rug_l/2) -- y offset amt
    local r_off_x = randi(0+rw,15-rw) -- origin offset x
    local r_off_y = randi(0+rl,15-rl) -- origin offset y

    local xpos = get_input_adj_bt(1,0,0)
    local xneg = get_input_adj_bt(-1,0,0)
    local ypos = get_input_adj_bt(0,1,0)
    local yneg = get_input_adj_bt(0,-1,0)
    local zneg = get_input_adj_bt(0,0,-1)

    -- Create room
    std.create_shell("r_green_x")
    
    -- Create holes - x
    if xpos == "block_happy_tall_grass_a_hall" or (xpos == "block_happy_air" and zneg ~= "block_happy_tall_grass_a_room") then
        create_rect("r_black", 15,5,5, 15,10,10)
        if xpos == "block_happy_air" then
            create_rect("anti_plug", 15,6,6, 15,9,9)
        else
            create_rect("happy_air", 15,6,6, 15,9,9)
        end
    end
    if xneg == "block_happy_tall_grass_a_hall" or (xneg == "block_happy_air" and zneg ~= "block_happy_tall_grass_a_room") then
        create_rect("r_black", 0,5,5, 0,10,10)
        if xneg == "block_happy_air" then
            create_rect("anti_plug", 0,6,6, 0,9,9)
        else
            create_rect("happy_air", 0,6,6, 0,9,9)
        end
    end
    
    -- Create holes - y
    if ypos == "block_happy_tall_grass_a_hall" or (ypos == "block_happy_air" and zneg ~= "block_happy_tall_grass_a_room") then
        create_rect("r_black", 5,15,5, 10,15,10)
        if ypos == "block_happy_air" then
            create_rect("anti_plug", 6,15,6, 9,15,9)
        else
            create_rect("happy_air", 6,15,6, 9,15,9)
        end
    end
    if yneg == "block_happy_tall_grass_a_hall" or (yneg == "block_happy_air" and zneg ~= "block_happy_tall_grass_a_room") then
        create_rect("r_black", 5,0,5, 10,0,10)
        if yneg == "block_happy_air" then
            create_rect("anti_plug", 6,0,6, 9,0,9)
        else
            create_rect("happy_air", 6,0,6, 9,0,9)
        end
    end

    -- Create furniture - chandelier, purple recliner, table, rug
    if furn_type == 1 then -- Chandelier
        -- stem
        create_rect("chain", 7,7,(15-chand_len), 7,7,15)

        -- metal layer 1
        create_rect("r_metal", 6,5,(15-chand_len), 8,5,(15-chand_len))
        create_rect("r_metal", 6,9,(15-chand_len), 8,9,(15-chand_len))
        create_rect("r_metal", 5,6,(15-chand_len), 5,8,(15-chand_len))
        create_rect("r_metal", 9,6,(15-chand_len), 9,8,(15-chand_len))

        -- create bulb
        set_pos(7,7,(15-chand_len-1), "happy_chandelier_bulb")
    end

    if furn_type == 2 then -- Purple Recliner
        -- legs
        set_pos(10,6,1, "r_brown_concrete")
        set_pos(13,6,1, "r_brown_concrete")
        set_pos(10,9,1, "r_brown_concrete")
        set_pos(13,9,1, "r_brown_concrete")

        -- bottom layer
        create_rect("r_purple_bdless", 8,6,2, 13,9,2)

        -- arms
        create_rect("r_purple_bdless", 10,5,2, 11,5,3)
        create_rect("r_purple_bdless", 10,10,2, 11,10,3)

        -- pillows
        create_rect("r_white_bdless", 12,6,3, 12,9,3)

        -- backing
        create_rect("r_purple_bdless", 13,6,2, 13,9,4)

        -- shrink ring
        create_rect("e", 12,7,1, 12,8,1)
        add_bent(12,7,1, "bent_base_ring_green_danger")
    end

    if furn_type == 3 then -- Table
        -- legs - haha have fun trying to read this
        create_rect("r_brown_concrete", (t_off_x-t_leg_w),(t_off_y-t_leg_l),0, (t_off_x-t_leg_w),(t_off_y-t_leg_l),t_leg_h) -- (--)
        create_rect("r_brown_concrete", (t_off_x-t_leg_w),(t_off_y+t_leg_l),0, (t_off_x-t_leg_w),(t_off_y+t_leg_l),t_leg_h) -- (-+)
        create_rect("r_brown_concrete", (t_off_x+t_leg_w),(t_off_y+t_leg_l),0, (t_off_x+t_leg_w),(t_off_y+t_leg_l),t_leg_h) -- (++)
        create_rect("r_brown_concrete", (t_off_x+t_leg_w),(t_off_y-t_leg_l),0, (t_off_x+t_leg_w),(t_off_y-t_leg_l),t_leg_h) -- (+-)

        -- tabletop
        create_rect("r_brown_concrete", (t_off_x-t_leg_w),(t_off_y-t_leg_l),(t_leg_h+1), (t_off_x+t_leg_w),(t_off_y+t_leg_l),(t_leg_h+1))

        -- text boxes
        if msg_num == 1 then
            msg = "(1/7)\n\n"
                .."You are currently in a ^x00ff00Tall Grass Apartment.^!\n"
                .."LIST OF FURNITURE:\n\n"
                .."^xffff00    Chandeliers:^! Don't fly too close to Chandeliers.  "
                .."A ^xff0000Pool Ball^! resides within it.\n\n"
                .."^x800080    Purple Recliners:^! Comfy! The residents seem to enjoy them...\n\n"
                .."^x964b00    Tables:^! Tables hold various information on the Apartment and other locations in Happy Land.\n\n"
                .."^xff0000    Rug:^! Shrinking into a rug reveals gold that increases in value the deeper you go. "
                .."However, the ^xff0000Rats also get stronger.^!"
        end
        if msg_num == 2 then
            msg = "(2/7)\n\n"
                .."There is a ^xffff00secret^! in Medium Grass chunks. "
                .."Sometimes, Medium Grass can grow Treasure Flowers on their tops."
                .."The ones that do have one, have a secret inside.\n\n"
                .."^xff0000But how would you get inside?^!"
        end
        if msg_num == 3 then
            msg = "(3/7)\n\n"
                .."If you haven't yet, you can find Cannon upgrades inside of ^x00ff00Platters.^! "
                .."Platters can be found on the branches of Treasure Flowers and can be entered through a hole near the bottom of the stem."
        end
        if msg_num == 4 then
            msg = "(4/7)\n\n"
                .."The residents here can be found in their rooms about 20% of the time, "
                .."consisting of Heavy Marines, Menaces, Blood Boys, Orcs, and Demons. "
                .."They also ^xff0000don't really like intruders,^! because no one really enjoys home invasions.\n\n"
                .."...except for maybe the Blood Boys; they'd open their doors to EVERY sketchy salesman."
        end
        if msg_num == 5 then
            msg = "(5/7)\n\n"
                .."You wanna know what would be funny? "
                .."Leaving this worthless paper on the table for any home invaders to read!"
        end
        if msg_num == 6 then
            msg = "(6/7)\n\n"
                .."The treasure room of a Tall Grass Apartment only spawns on ^xff0000Floor 6!^!"
                .."In order to reach the treasure, you need to travel up the Brown Staircase chunks that are guarded with ^xff0000Apartment Key Guards.^! "
                .."To get past these, you need to find a key in one of the rooms and bring it back to access the next Floor.\n\n"
                .."Also, ^xff0000try not to kill the Residents.^!"
        end
        if msg_num == 7 then
            msg = "(7/7)\n\n"
                .."The Landlord hires only so many chimney sweepers, so ^xff0000not every Apartment has their chimney swept...^!"
        end

        add_bent_s(t_off_x,t_off_y,(t_leg_h+2), "bent_base_txt", msg) 
    end

    if furn_type == 4 then -- Rug
        -- create_rect("rug", (r_off_x-rw),(r_off_y-rl),0, (r_off_x+rw),(r_off_y+rl),0)
    end

    -- Determine resident names
    if resident_name == 1 then resident_name = "Jake" end
    if resident_name == 2 then resident_name = "Francis" end
    if resident_name == 3 then resident_name = "Jeremy" end
    if resident_name == 4 then resident_name = "Bob" end
    if resident_name == 5 then resident_name = "Sarah" end
    if resident_name == 6 then resident_name = "Alex" end
    if resident_name == 7 then resident_name = "James" end
    if resident_name == 8 then resident_name = "Terry" end
    if resident_name == 9 then resident_name = "Patrick" end
    if resident_name == 10 then resident_name = "Samantha" end
    if resident_name == 11 then resident_name = "Pauline" end
    if resident_name == 12 then resident_name = "Evil" end
    if resident_name == 13 then resident_name = "May" end
    if resident_name == 14 then resident_name = "Casey" end
    if resident_name == 15 then resident_name = "Carter" end
    if resident_name == 16 then resident_name = "Peter" end
    if resident_name == 17 then resident_name = "Diane" end
    if resident_name == 18 then resident_name = "Kate" end
    if resident_name == 19 then resident_name = "Zach" end
    if resident_name == 20 then resident_name = "Winston" end

    -- Create residents
    if resident_chance <= 0.35 then -- 35% chance!
        if resident == 1 then
            ment_start(7,7,7, "ment_monster_menace_resident")
            ment_set_offset(randi(2,13),randi(2,13),randi(2,13))
            ment_set_s("identity_str", "Menace - Resident " .. resident_name)
            ment_end()
        end
        if resident == 2 then
            ment_start(7,7,7, "ment_monster_marine_heavy_resident")
            ment_set_offset(randi(2,13),randi(2,13),randi(2,13))
            ment_set_s("identity_str", "Heavy Marine - Resident " .. resident_name)
            ment_end()
        end
        if resident == 3 then
            ment_start(7,7,7, "ment_monster_blood_boy_resident")
            ment_set_offset(randi(2,13),randi(2,13),randi(2,13))
            ment_set_s("identity_str", "Blood Boy - Resident " .. resident_name)
            ment_end()
        end
        if resident == 4 then
            ment_start(7,7,7, "ment_monster_orc_resident")
            ment_set_offset(randi(2,13),randi(2,13),randi(2,13))
            ment_set_s("identity_str", "Orc - Resident " .. resident_name)
            ment_end()
        end
        if resident == 5 then
            ment_start(7,7,7, "ment_monster_demon_resident")
            ment_set_offset(randi(2,13),randi(2,13),randi(2,13))
            ment_set_s("identity_str", "Demon - Resident " .. resident_name)
            ment_end()
        end
    end
end