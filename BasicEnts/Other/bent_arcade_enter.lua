function p.__get_can_use(level, bp)
    return false
end

function p.__get_use_msg(level, bp)
    if bent_arcade_reset_door.door_is_shut(level, bp) then
        return "^xff0000You are in the arcade"
    else
        return "Touch to enter arcade"
    end
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.payload(level, bp)
    game_arcade.set_inside_arcade()
    
    local vcp = ga_bp_to_parent_vcp(bp)

    for xi = 0,15 do
    for yi = 0,15 do
    for zi = 0,15 do
        local lbp = std.bp(xi,yi,zi)
        local bp2 = std.lbp_to_bp(vcp, lbp)
        --
        local block_type = ga_block_get(level, bp2)
        if( block_type == "XAR_ARCADE_DOOR_ENTER_SOLID" ) then
            --Removing the block.
            ga_block_change_perm(level, bp2, "XAR_ARCADE_DOOR_ENTER_EMPTY")
        end
        if( block_type == "XAR_ARCADE_DOOR_SHUT_EMPTY" ) then
            --Adding the block.
            ga_block_change_perm(level, bp2, "XAR_ARCADE_DOOR_SHUT_SOLID")
        end
        -- local bent_type = ga_bent_get_type(level, bp2)
        -- if( bent_type == "bent_arcade_enter" ) then
        --     --Removing the arcade box.
        --     ga_bent_remove_perm(level, bp2)
        -- end
    end end end
end
