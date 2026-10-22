function p.get_ment_is_frozen(inst_id)
    return ga_ment_b_exists_and_true(inst_id, "frozen")
end

--Monsters that are freeze immune are actually
--only stunned for this amount of time.
function p.get_short_stun_len()
    return 1.0
end

function p.add_to_live(inst_id)
    p.add_to_live_helper(inst_id)

    p.freeze_end_maybe(inst_id)
end

function p.add_to_live_helper(inst_id)
    local type_name = ga_ment_get_type(inst_id)
    if( not ga_ment_type_var_exists(type_name, "freeze_endtime") ) then return end
    local freeze_end = ga_ment_get_f(inst_id, "freeze_endtime")
    local game_time = ga_get_game_time()

    --Seeing if need to reset unfreeze alarm.
    if( freeze_end < game_time ) then return end --Right?
    ga_ment_set_alarm(inst_id, freeze_end, "freeze_end")
end

function p.laser_initial_hit(inst_id, freeze_length, stacking)
    local type_name = ga_ment_get_type(inst_id)

    --Making sure it can be frozen.
    if( ga_ment_static_b_exists_and_true(type_name, "freeze_immune_true") ) then
        --Cannot be frozen at all.
        return
    end
    if( ga_ment_static_b_exists_and_true(type_name, "freeze_immune") ) then
        --Can only freeze for one second.
        freeze_length = p.get_short_stun_len()
    end
    if( ga_ment_get_i(inst_id, "__team_id_target") ~= 2 ) then return end
    if( not ga_ment_type_var_exists(type_name, "frozen") ) then return end

    --Doing freeze effect.

    ga_ment_set_b(inst_id, "frozen", true)

    --Changing the texture to blue.
    --Worry about revert time?
    --Maybe all ment vars should have a 1 hour revert time.
    ga_ment_set_s(inst_id, "__tex_override", "ice")

    --Freezing the turning and vel of the ment.
    ga_ment_set_b(inst_id, "__turning_disabled", true)
    ga_ment_set_b(inst_id, "__vel_disabled", true)
    --The same comment as in __tex_override applies here.

    --Determining the unfreeze time.
    local game_time = ga_get_game_time()
    local freeze_end_time = game_time + freeze_length
    if stacking then
        local old_free_end_time = ga_ment_get_f(inst_id, "freeze_endtime")
        if( old_free_end_time > game_time ) then
            --Setting freeze_end_time differently.
            freeze_end_time = old_free_end_time + freeze_length
        end
    end

    --Setting the unfreeze alarm and related vars.
    if( ga_ment_type_var_exists(type_name, "freeze_endtime") ) then
        ga_ment_set_f(inst_id, "freeze_endtime", freeze_end_time)
    end
    ga_ment_set_alarm(inst_id, freeze_end_time + 0.1, "freeze_end")
end

function p.freeze_end_maybe(inst_id)
    --Making sure is frozen.
    local type_name = ga_ment_get_type(inst_id)
    if( ga_ment_type_var_exists(type_name, "frozen") and
        not ga_ment_get_b(inst_id, "frozen") )
    then
        return
    end

    --First, need to make sure the freeze effect
    --has in fact warn off (this is needed
    --because there could have been muliple freezes).
    --Note: the freeze_endtime var should exist,
    --but if not we will end the freeze.
    if( ga_ment_type_var_exists(type_name, "freeze_endtime") ) then
        local game_time = ga_get_game_time()
        local freeze_endtime = ga_ment_get_f(inst_id, "freeze_endtime")
        if( game_time < freeze_endtime - 0.1 ) then return end
    else
        --This is probably a bug:
        --the ment should have a freeze_endtime var
        --if it has a frozen var.
        ga_print("*** Error: ment does not have var freeze_endtime")
        ga_exit()
    end

    --Unfreezing.

    ga_ment_set_b(inst_id, "frozen", false)

    --Refreshing the __tex_override.
    game_ment_tex_override.refresh(inst_id)

    --Unfreezing the turning.
    --SHOULD BE MORE COMPLEX (see if there are other stuns in place)!!!
    ga_ment_set_b(inst_id, "__turning_disabled", false)
    ga_ment_set_b(inst_id, "__vel_disabled", false)
end
