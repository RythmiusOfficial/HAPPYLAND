function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("landlord_office_air")
    local conformity = 160000
    local assimilation = 4800000
    local integration = 20000000
    local chance = randi(1,5)
    local ment = false

    -- Create enemies
    for x = 2,13 do
    for y = 2,13 do
    for z = 2,13 do
        if chance == 1 then
        if ment == false then
        if randi(1,conformity) == 1 then
            ment_start(x,y,z, "ment_monster_agent_conformed")
            ment_set_offset(x,y,z)
            ment_end()
            ment = true
        elseif randi(1,assimilation) == 1 then
            ment_start(x,y,z, "ment_monster_agent_assimilated")
            ment_set_offset(x,y,z)
            ment_end()
            ment = true
        elseif randi(1,integration) ==  1 then
            ment_start(x,y,z, "ment_monster_agent_integrated")
            ment_set_offset(x,y,z)
            ment_end()
            ment = true
        end end end
    end end end
end