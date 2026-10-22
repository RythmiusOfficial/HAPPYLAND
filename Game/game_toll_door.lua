--This can be called from the outside.
function p.remove_toll_door()
    --Removing the door from the chunk.
    local level = ga_get_i("temp.xar.ent.pay_toll.level")
    local x = ga_get_i("temp.xar.ent.pay_toll.bp.x")
    local y = ga_get_i("temp.xar.ent.pay_toll.bp.y")
    local z = ga_get_i("temp.xar.ent.pay_toll.bp.z")
    local bp1 = std.bp(x,y,z)
    p.remove_door_from_chunk(level, bp1)

    --Maybe removing the door from the parent of the chunk.
    if( ga_b_exists_and_true("temp.xar.ent.pay_toll.level_minus_1") ) then
        local bp2 = ga_bp_to_parent_bp(level, bp1) --bp2 is the parent of bp1.
        p.remove_door_from_chunk(level-1, bp2)

        if( ga_b_exists_and_true("temp.xar.ent.pay_toll.level_minus_2") ) then
            local bp3 = ga_bp_to_parent_bp(level-1, bp2)
            p.remove_door_from_chunk(level-2, bp3)
        end
    end
end

--Helper function
function p.remove_door_from_chunk(level, bp)
    --Dealing with gold.
    local price = ga_get_i("temp.xar.ent.pay_toll.price")
    local gold_in_inv = ga_get_i("xar.player.gold.amount")
    if( gold_in_inv < price ) then
        game_msg.add("You do not have enough gold to open the door")
        ga_play_sound("error")
        return
    end
    ga_play_sound("toll_door")
    gold_in_inv = gold_in_inv - price
    ga_set_i("xar.player.gold.amount", gold_in_inv)
    
    local vcp = ga_bp_to_parent_vcp(bp)

    local remove_bts = {}
    remove_bts["XAR_TOLL_DOOR"] = true
    remove_bts["XAR_TOLL_DOOR_SOLID"] = true
    remove_bts["XAR_TOLL_DOOR_TO_ASCEND"] = true
    remove_bts["XAR_SOLID_HOLE"] = true
    remove_bts["XAR_TOLL_SECRET_1"] = true

    local remove_bents = {}
    remove_bents["bent_pay_toll"] = true
    remove_bents["bent_pay_toll_parent"] = true
    remove_bents["bent_pay_toll_parent2"] = true

    --Some of the block types which are removed are special.
    local replace_bts = {}
    replace_bts["XAR_TOLL_DOOR_TO_ASCEND"] = "XAR_SPACE_MID_ASCEND_HIDDEN"

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
            --Maybe doing something more.
            local replace_with = replace_bts[block_type]
            if( replace_with ~= nil ) then
                ga_block_change_perm(level, bp2, replace_with)
            end
        end
        --
        local bent_type = ga_bent_get_type(level, bp2)
        if( remove_bents[bent_type] ) then
            --Removing the box used to pay the toll.
            ga_bent_remove_perm(level, bp2)
        end
    end end end
end
