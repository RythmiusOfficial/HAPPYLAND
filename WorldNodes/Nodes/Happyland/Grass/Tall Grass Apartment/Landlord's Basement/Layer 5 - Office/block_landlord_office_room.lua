function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_concrete"
end

function p.__main()
    local level = get_level()
    local room = get_input_path_block_i(level, "room")

    if room == 1 then -- infertile concrete growths
        set_default_block("r_white")
        create_rect("landlord_concrete_growth", 1,1,1, 14,14,14)
        create_rect("landlord_office_air", 2,0,1, 13,13,14)
        set_pos(14,14,1, "landlord_office_room_treasure")

        -- set directions of the growths
        for x = 1,14 do
        for z = 1,14 do
            block_set_i(x,14,z, "dir", 2)
        end end

        for y = 1,14 do
        for z = 1,14 do
            block_set_i(1,y,z, "dir", 3)
        end end

        for y = 1,14 do
        for z = 1,14 do
            block_set_i(14,y,z, "dir", 4)
        end end

    elseif room == 2 then --narrow; dust particles
        set_default_block("r_dark_gray")
        create_rect("landlord_office_air", 6,1,1, 9,15,14)
        create_sprinkles(0,0,0, 15,15,15, 0.05, "dust")
        set_pos(8,6,15, "landlord_office_room_treasure")
        set_pos(8,6,14, "e")
        block_set_i(8,6,15, "room", 2)

    elseif room == 3 then -- lattice
        set_default_block("r_dark_gray")
        create_rect("landlord_office_air", 0,1,1, 14,14,14)
        -- vertical pillars
        for x = 1,13,2 do
        for y = 1,13,2 do
            if randi(1,2) == 1 then
                for z = 1,14 do
                    set_pos(x,y,z, "r_concrete")
                end
            end
        end end

        -- horizontal pillars
        for x = 1,13,2 do
        for y = 1,13,2 do
            if randi(1,2) == 1 then
                for z = 1,14 do
                    set_pos(x,z,y, "r_concrete")
                end
            end
        end end

        set_pos(7,7,7, "landlord_office_room_treasure")
        block_set_i(7,7,7, "room", 3)

    elseif room == 4 then
        -- plugged; large map room
    elseif room == 5 then
        -- plugged; black and dark gray speckled
    elseif room == 6 then -- plugged; cubicle
    elseif room == 7 then -- rug caves 5
        set_default_block("r_concrete_x")
        create_rect("happy_rug_caves_5", 1,1,1, 14,15,14)
        create_rect("e", 1,1,1, 14,1,14)
        create_rect("e", 6,1,6, 9,15,9)
        set_pos(7,1,7, "landlord_office_room_treasure")
        block_set_i(7,1,7, "room", 7)
    elseif room == 8 then 
        -- Electric Fence maze (short)
    elseif room == 9 then -- start hooks
        set_default_block("r_green_deco")
        create_rect("happy_air", 1,1,1, 15,14,14)
        create_rect("r_green", 1,1,1, 1,14,14)
        create_rect("happy_start_hooks", 2,1,1, 2,14,14)
        set_pos(2,7,1, "landlord_office_room_treasure")
        block_set_i(2,7,1, "room", 9)
    elseif room == 10 then -- normal room lol
        set_default_block("r_concrete")
        create_sprinkles(0,0,0, 15,15,15, 0.2, "r_dark_gray")
        create_rect("landlord_office_air", 0,1,1, 14,14,14)
        set_pos(7,7,7, "landlord_office_room_treasure")
        block_set_i(7,7,7, "room", 10)
    end
end

function p.__type_init(id)
    ia_block_new_var_i(id, "room", 1)
end