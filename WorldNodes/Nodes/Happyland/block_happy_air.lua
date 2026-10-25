function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("happy_air")

    g_cube = false
    e_cube = false
    p_cube = false
    t_cube = false
    s_cube = false
    goblin = false
    
    amount_chance = 40

	-- Create up to four random blocks in the sky from the list: green, gray, plasma, text, shrink
    for i = 1,4 do
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
        
        -- Gray Exit Cube
        if randi(1,amount_chance) == 1 then
            if e_cube == false then
                set_pos(x,y,z, "happy_exit_cube")
                x = randi(0,15)
                y = randi(0,15)
                z = randi(0,15)
                -- Set to 'used'
                e_cube = true
            end
        end

        -- Plasma ammo
        if randi(1,amount_chance+20) == 1 then
            if p_cube == false then
                add_bent(x,y,z, "bent_ammo_gun_1")
                x = randi(0,15)
                y = randi(0,15)
                z = randi(0,15)
                -- Set to 'used'
                p_cube = true
            end
        end

        -- Text box
        if randi(1,amount_chance+30) == 1 then
            if t_cube == false then
                local msg = "Lost?\n\n"
                         .. "The gray cubes turn into teleportation sta-\n\n"
                         .. "No. No they don't.\n"
                         .. "^xff0000Not anymore...^!"
                add_bent_s(x,y,z, "bent_base_txt", msg)
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

        -- Goblins
        if randi(1,(amount_chance*3)) == 1 then
            if goblin == false then
                ment_start(x,y,z, "ment_monster_goblin")
                ment_set_offset(x,y,z)
                ment_end()
                x = randi(0,15)
                y = randi(0,15)
                z = randi(0,15)
                -- Set to 'used'
                goblin = true
            end
        end
    end
end