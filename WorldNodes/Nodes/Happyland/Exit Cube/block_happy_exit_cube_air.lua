function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("happy_exit_cube_air")

    local chance = 700
    local placed = false

    -- Create either a Particle, Menace, or another Exit Cube
    for x = 0,15 do
    for y = 0,15 do
    for z = 0,14 do
        if placed == false then
            if randi(1,chance) == 1 then
                set_pos(x,y,z, "happy_exit_air_part")
                add_bent(x,y,z+1, "bent_base_ring_green")
                placed = true
            end
            if randi(1,chance*9) == 1 then
                ment_start(x,y,z, "ment_monster_menace")
                ment_set_offset(x,y,z)
                ment_end()
                placed = true
            end
            if randi(1,chance) == 1 then
                set_pos(x,y,z, "happy_exit_cube")
                placed = true
            end
        end
    end end end 
end
