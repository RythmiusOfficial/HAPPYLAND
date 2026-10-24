function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_green"
end

-- The idea is that the hollow air will be made entirely of holes first and then perform checks to see if the block to the left
-- is a tube. If not, then it will turn it back into r_green.
function p.__main()
    set_default_block("happy_tube_air")
    local above_bt = get_input_adj_bt(0,0,1)
    local left_bt = get_input_adj_bt(1,0,0)
    
    -- Create hollow shell
    std.create_shell("happy_med_grass_hollow")
    local max_z = 15

    -- Check if block above is NOT a 'happy_med_grass_hollow' and apply roof
    if above_bt ~= "block_happy_med_grass_hollow" then
        max_z = 14
    end
    create_rect("happy_air", 1,1,0, 14,14,max_z)

    -- Create hole to lead inside hollow grass
    if left_bt == "block_happy_grass_tube_1" then
        for y = 0,15 do
        for z = 0,15 do
            set_pos(15,y,z, "happy_grass_tube_2")
        end end
    end

    print(above_bt)
    print(left_bt)
end 