--File: bent_open_universe_door.lua

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Open Door With Universe Key"
end

function p.__on_use(level, bp)
    p.remove_door(level, bp)
end

--Could put elsewhere.
function p.remove_door(level, bp)
    local key_time = ga_get_f("xar.key_time.universe")
    if( key_time <= 0.01 ) then
        ga_play_sound("error")
        return
    end
    --
    ga_play_sound("toll_door")
    local vcp = ga_bp_to_parent_vcp(bp)

    local remove_bents = {}
    remove_bents["bent_open_universe_door"] = true

    local remove_bts = {}
    remove_bts["XAR_DOOR_UNIVERSE"] = true
    --remove_bts["XAR_DOOR_GREEN_GLASS"] = true

    for xi = 0,15 do
    for yi = 0,15 do
    for zi = 0,15 do
        local lbp = std.bp(xi,yi,zi)
        local bp2 = std.lbp_to_bp(vcp, lbp)
        --
        local block_type = ga_block_get(level, bp2)
        if( remove_bts[block_type] ) then
            --Removing the block.
            ga_block_change_perm(level, bp2, "XAR_EMPTY_BORING")
        end
        --
        local bent_type = ga_bent_get_type(level, bp2)
        if( remove_bents[bent_type] ) then
            --Removing the bent used to open the door.
            ga_bent_remove_perm(level, bp2)
        end
    end end end
end
