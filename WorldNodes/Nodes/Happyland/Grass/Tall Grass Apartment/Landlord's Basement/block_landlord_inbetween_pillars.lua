function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("e")
    local radius = randi(1,10)
    local scatter = 0

    local x = randi(0,16-radius)
    local y = randi(0,16-radius)

    if get_input_adj_bt(0,0,1) ~= "block_landlord_b_room_tunnel" then
        create_rect("r_concrete_x", x,y,0, x+(radius-1),y+(radius-1),15)

        -- add a peppered look to the pillars for interest
        for i = x,x+(radius-1) do
        for j = y,y+(radius-1) do
        for k = 0,15 do
            scatter = randi(1,3)
            if scatter == 1 then
                set_pos(i,j,k, "r_dark_gray")
            end
        end end end
    end
end