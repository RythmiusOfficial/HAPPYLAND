--Note: game_ment_hit.luia does not use this script.

function p.from_ment(
    source_inst_id,
    target_inst_id,
    damage)
--
    --Registering the player from the player.
    game_dps_out.add(damage)

    local args = {}
    args.source_inst_id = source_inst_id
    args.target_inst_id = target_inst_id
    args.damage = damage

    return p.from_ment_default(args)
end

--Should mirror "take_damage_from_ment" functions
--defined in individual ment modules.
--Args should have members:
--source_inst_id,
--target_inst_id,
--damage
function p.from_ment_default(args)
    local ret = {}
    ret.damage_taken = 0

    local target_type_name = ga_ment_get_type(args.target_inst_id)
    local source_type_name = ga_ment_get_type(args.source_inst_id)
    if not game_ment_health.get_ment_has_health(args.target_inst_id) then
        return ret
    end

    local damage = args.damage
    local team_id_source = ga_ment_get_static_i(source_type_name, "__team_id_source")
    local team_id_target = ga_ment_get_static_i(target_type_name, "__team_id_target")
    if( team_id_source == 1 ) then
        damage = game_damage.calc_damage_from_player(damage, true)
    end
    if( team_id_target == 1 ) then
        damage = game_damage.calc_damage_to_player(damage)
    end

    --Could handle more generally, but this is fine.
    if( target_type_name == "marker_short" or
        target_type_name == "marker_long" )
    then
        if( source_type_name ~= "player_proj_plasma_1" and
            source_type_name ~= "player_proj_plasma_2" )
        then
            return
        end
    end

    --Damage in modifier.
    if( _G[target_type_name]["xar_get_level_mod_damage_in"] ) then
        local source_start_lev = ga_ment_get_i(args.source_inst_id, "__start_level")
        local target_start_lev = ga_ment_get_i(args.target_inst_id, "__start_level")
        local delta = source_start_lev - target_start_lev
        local modifier = _G[target_type_name]["xar_get_level_mod_damage_in"](delta)
        damage = math.floor(modifier * damage)
    end

    local target_health_before = game_ment_health.get_ment_health(args.target_inst_id)
    local target_health_after = math.floor(target_health_before - damage)
    game_ment_health.set_ment_health(args.target_inst_id, target_health_after)

    --Damage taken return value.
    if( target_health_after >= 0 ) then
        ret.damage_taken = damage
    else
        ret.damage_taken = target_health_before
    end

    --Calling a listener.
    local mod_name = ga_ment_get_type(args.target_inst_id)
    local func_name = "took_damage"
    if( _G[mod_name] and
        _G[mod_name][func_name] )
    then
        --Calling the function in the ment script.
        _G[mod_name][func_name](args.target_inst_id, damage)
    else
        --The function does not exist.
        --This is normal.
    end

    return ret
end

--Should I add other functions?
