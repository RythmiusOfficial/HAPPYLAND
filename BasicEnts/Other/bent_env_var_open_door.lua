function p.get_var_name(level, bp)
    return ga_bent_get_param_s(level, bp)
end

function p.get_can_open(level, bp)
    local var = p.get_var_name(level, bp)
    if not ga_exists(var) then return false end --Uh oh!
    return ga_get_b(var)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    --Saftey check.
    local var = p.get_var_name(level, bp)
    if not ga_exists(var) then
        return "*** Error: var not found: " .. var
    end
    --
    if p.get_can_open(level,bp) then
        return "^x00ff00Open Door"
    else
        return "^xff0000Door Is Locked"
    end
end

function p.__on_use(level, bp)
    if p.get_can_open(level,bp) then
        p.remove_door(level, bp)
    else
        ga_play_sound("error")
    end
end

function p.remove_door(level, bp)
    ga_play_sound("toll_door")

    local vcp = ga_bp_to_parent_vcp(bp)

    for xi = 0,15 do
    for yi = 0,15 do
    for zi = 0,15 do
        local lbp = std.bp(xi,yi,zi)
        local bp2 = std.lbp_to_bp(vcp, lbp)
        --
        local block_type = ga_block_get(level, bp2)
        if( block_type == "XAR_DOOR" ) then
            --Removing the block.
            ga_block_change_perm(level, bp2, "XAR_EMPTY_BORING")
        end
        --
        local bent_type = ga_bent_get_type(level, bp2)
        if( bent_type == "bent_env_var_open_door" ) then
            --Removing the box used to open the door.
            ga_bent_remove_perm(level, bp2)
        end
    end end end
end
