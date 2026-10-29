function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("happy_tube_air")

    local right_bt = get_input_adj_bt(-1,0,0)

    local g_cube = false
    local s_cube = false
    local marine = false

    amount_chance = 25

    for i = 1,7 do
        -- Set x and y to max 14 to make room for the Start Hooks block
        local x = randi(0,14)
        local y = randi(0,14)
        local z = randi(0,15)

        -- Green Cube
        if randi(1,amount_chance) == 1 then
            -- Check to see if the block type has already been generated in the current chunk.
            if g_cube == false then
                set_pos(x,y,z, "r_green")
                set_pos(x+1,y,z, "happy_start_hooks")
                -- We can set the x and y value maxes back to 15 because we aren’t generating...
                -- Green Cubes any longer (which require the Hook block in front).
                x = randi(0,15)
                y = randi(0,15)
                z = randi(0,15)
                -- Set the block type to 'used'     
                g_cube = true
            end
        end

        -- Shrink ring
        if randi(1,amount_chance) == 1 then
            if s_cube == false then
                add_bent(x,y,z, "bent_base_ring_green_danger")
                x = randi(0,15)
                y = randi(0,15)
                z = randi(0,15)
                -- Set to 'used'
                s_cube = true
            end
        end

        -- Light Marines
        if randi(1,(amount_chance*4)) == 1 then
            if marine == false then
                ment_start(x,y,z, "ment_monster_marine_light")
                ment_set_offset(x,y,z)
                ment_end()
                x = randi(0,15)
                y = randi(0,15)
                z = randi(0,15)
                -- Set to 'used'
                marine = true
            end
        end
    end
end