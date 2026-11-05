function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

-- What if i made the air a semi-transparent gray to make it appear more like smoke?
-- :0 peak idea; do this later PLEASEEEEE
function p.__main() 
    set_default_block("block_smoke")

    local chance = 700
    local placed = false

    -- Create either a Smoke Particle, Dust Block, or a Solid Expander
    for x = 0,15 do
    for y = 0,15 do
    for z = 0,14 do
        if placed == false then
            if randi(1,chance) == 1 then
                set_pos(x,y,z, "happy_smoke_air_part")
                add_bent(x,y,z+1, "bent_base_ring_green")
                placed = true
            end
            if randi(1,chance) == 1 then
                set_pos(x,y,z, "dust")
                placed = true
            end
            if randi(1,chance*1.5) == 1 then
                set_pos(x,y,z, "expander_solid")
                placed = true
            end
        end
    end end end 
end