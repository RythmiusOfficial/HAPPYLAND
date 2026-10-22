function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    if p.door_is_shut(level, bp) then
        return "Reset door"
    else
        return "Door is ready to go through"
    end
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

--Slow.
--Could make faster by using a chunk variable.
function p.door_is_shut(level, bp)
    local vcp = ga_bp_to_parent_vcp(bp)
    for xi = 0,15 do
    for yi = 0,15 do
    for zi = 0,15 do
        local lbp = std.bp(xi,yi,zi)
        local bp2 = std.lbp_to_bp(vcp, lbp)
        --
        local block_type = ga_block_get(level, bp2)
        if( block_type == "XAR_ARCADE_DOOR_SHUT_SOLID" ) then
            return true
        end
    end end end
    return false
end

--Opening the door (if it is shut).
function p.payload(level, bp)
    if not p.door_is_shut(level, bp) then return end

    ga_play_sound("use")
    
    local vcp = ga_bp_to_parent_vcp(bp)
    for xi = 0,15 do
    for yi = 0,15 do
    for zi = 0,15 do
        local lbp = std.bp(xi,yi,zi)
        local bp2 = std.lbp_to_bp(vcp, lbp)
        --
        local block_type = ga_block_get(level, bp2)
        if( block_type == "XAR_ARCADE_DOOR_ENTER_EMPTY" ) then
            --Adding the block.
            ga_block_change_perm(level, bp2, "XAR_ARCADE_DOOR_ENTER_SOLID")
        end
        if( block_type == "XAR_ARCADE_DOOR_EXIT_EMPTY" ) then
            --Adding the block.
            ga_block_change_perm(level, bp2, "XAR_ARCADE_DOOR_EXIT_SOLID")
        end
        if( block_type == "XAR_ARCADE_DOOR_SHUT_SOLID" ) then
            --Removing the block.
            ga_block_change_perm(level, bp2, "XAR_ARCADE_DOOR_SHUT_EMPTY")
        end
    end end end
end
