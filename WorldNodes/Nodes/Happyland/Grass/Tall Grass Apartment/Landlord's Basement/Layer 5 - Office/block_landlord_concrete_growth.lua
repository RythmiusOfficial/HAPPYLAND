function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("e")
    local len = randi(4,14) - 1
    local level = get_level()
    local direction = get_input_path_block_i(level, "dir") -- 1 is left, 2 is right, 3 is y-left, 4 is y-right
    
    -- create stem
    if direction == 1 then
        create_rect("landlord_concrete_growth", 0,0,0, 15,0,15)
        create_rect("r_concrete", 7,0,7, 8,len,8)
        create_rect("r_concrete", 7,len-1,9, 8,len,10)
        create_rect("landlord_concrete_growth", 7,len+1,7, 8,len+1,10)
        -- no need to set the variable because it automatically defaults it to 1
    end
    if direction == 2 then
        create_rect("landlord_concrete_growth", 0,15,0, 15,15,15)
        for x = 0,15 do
        for z = 0,15 do
            block_set_i(x,15,z, "dir", 2)
        end end
        create_rect("r_concrete", 7,15-len,7, 8,15,8)
        create_rect("r_concrete", 7,15-len,9, 8,(15-len+1),10)
        create_rect("landlord_concrete_growth", 7,(15-len-1),7, 8,(15-len-1),10)
        for x = 7,8 do
        for z = 7,10 do
            block_set_i(x,(15-len-1),z, "dir", 2)
        end end
    end

    -- create y variations of the stem
    if direction == 3 then
        create_rect("landlord_concrete_growth", 0,0,0, 0,15,15)
        for y = 0,15 do
        for z = 0,15 do
            block_set_i(0,y,z, "dir", 3)
        end end
        create_rect("r_concrete", 0,7,7, len,8,8)
        create_rect("r_concrete", len-1,7,9, len,8,10)
        create_rect("landlord_concrete_growth", len+1,7,7, len+1,8,10)
        for y = 7,8 do
        for z = 7,10 do
            block_set_i(len+1,y,z, "dir", 3)
        end end
    end
    if direction == 4 then
        create_rect("landlord_concrete_growth", 15,0,0, 15,15,15)
        for y = 0,15 do
        for z = 0,15 do
            block_set_i(15,y,z, "dir", 4)
        end end
        create_rect("r_concrete", 15-len,7,7, 15,8,8)
        create_rect("r_concrete", 15-len,7,9, (15-len+1),8,10)
        create_rect("landlord_concrete_growth", (15-len-1),7,7, (15-len-1),8,10)
        for y = 7,8 do
        for z = 7,10 do
            block_set_i((15-len-1),y,z, "dir", 4)
        end end
    end
end

function p.__type_init(id)
    ia_block_new_var_i(id, "dir", 1)
    ia_block_new_var_b(id, "fertile", false)
end