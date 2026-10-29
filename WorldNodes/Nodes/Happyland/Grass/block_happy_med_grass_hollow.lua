function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green"
end

-- The idea is that the hollow air will be made entirely of holes first and then perform checks to see if the block to the left
-- is a tube. If not, then it will turn it back into r_green.
function p.__main()
    set_default_block("happy_air")
    local above_bt = get_input_adj_bt(0,0,1)
    local left_bt = get_input_adj_bt(1,0,0)
    local right_bt = get_input_adj_bt(-1,0,0)
    local below_bt = get_input_adj_bt(0,0,-1)

    local msg = ""
    
    -- Create hollow shell
    std.create_shell("happy_med_grass_hollow")
    local max_z = 15

    -- Check if block above is NOT a 'happy_med_grass_hollow' and apply roof
    -- Also check to make sure that the right IS a "happy_med_grass_hollow" to create the hole to enter the main stem
    if above_bt ~= "block_happy_med_grass_hollow" then
        max_z = 14
        if right_bt == "block_happy_med_grass_hollow" then
            if below_bt == "block_happy_med_grass_hollow" then
                create_rect("r_yellow", 0,6,6, 0,9,9)
            else
                create_rect("r_orange", 0,6,6, 0,9,9)
            end
            create_rect("happy_air", 0,7,7, 1,8,8)
        end
        if left_bt == "block_happy_med_grass_hollow" then
            if below_bt == "block_happy_med_grass_hollow" then
                create_rect("r_yellow", 15,6,6, 15,9,9)
            else
                create_rect("r_orange", 15,6,6, 15,9,9)
            end
            create_rect("happy_air", 14,7,7, 15,8,8)
        end

        -- Text box
        if below_bt == "block_happy_med_grass_hollow" then
            msg = "You are now at the top of this ^x00ff00Hollow Medium Grass.^!\n\n"
                      .."In order to reach the treasure, you need to enter the large stem through this Overhead Tunnel System. "
                      .."After doing so, fly to the very bottom and you will find ^x00ff00Large Grass^! and the treasure!\n\n"
                      .."These rings will turn ^xff8000orange^! to indicate when you can begin your descent."
        else
            msg = "You are at the top of the large stem, meaning you can now start your descent to the treasure."
        end
        add_bent_s(2,2,13, "bent_base_txt", msg)
    else

        -- Create internal windows
        if right_bt == "block_happy_tube_air" then
            create_rect("happy_tube_air", 0,6,5, 1,9,9)
            create_rect("r_black", 0,6,5, 0,9,9)
            create_rect("glass", 0,7,6, 0,8,8)
        end
        if left_bt == "block_happy_tube_air" then
            create_rect("happy_tube_air", 14,6,5, 15,9,9)
            create_rect("r_black", 15,6,5, 15,9,9)
            create_rect("glass", 15,7,6, 15,8,8)
        end
    end

    -- Carve out block
    create_rect("happy_tube_air", 1,1,0, 14,14,max_z)

    -- Start Hooks
    create_rect("happy_start_hooks", 1,1,0, 1,14,max_z)
    create_rect("happy_tube_air", 1,6,5, 1,9,9)
    create_rect("happy_tube_air", 14,6,5, 14,9,9)

    -- Create hole to lead inside hollow grass
    if left_bt == "block_happy_grass_tube_1" then
        for y = 1,14 do
        for z = 0,15 do
            set_pos(15,y,z, "happy_grass_tube_2")
            set_pos(14,y,z, "expander")
        end end
    end

    -- Create treasure blocks (and start hooks)
    if below_bt == "block_r_green" then
        create_rect("happy_tall_grass", 1,1,0, 14,14,0)
        set_pos(7,7,0, "happy_med_grass_hollow_treasure")
    end
end 