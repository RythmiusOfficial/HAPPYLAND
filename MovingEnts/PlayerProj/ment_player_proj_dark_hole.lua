-------------------------------------------------
--              Damage AND Health
-------------------------------------------------

function p.xar_get_level_mod_damage_out(delta)
    if (delta == 0) then return 0.0 end
    return 1.0
end

-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 2)
    ia_ment_set_builtin_var_f(id, "__radius", 8.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "dark_hole")
    ia_ment_new_static_var_b(id, "identifies", true)
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.__on_ment_hit(
    source_inst_id,
    target_inst_id,
    level, lp, normal)
--
    --Special dark hole check.
    local source_start_level = ga_ment_get_i(source_inst_id, "__start_level")
    local target_start_level = ga_ment_get_i(target_inst_id, "__start_level")
    if( source_start_level == target_start_level ) then return false end
--
    local args = {}
    args.source_inst_id = source_inst_id
    args.target_inst_id = target_inst_id
    args.level = level
    args.lp = lp
    args.normal = normal
    --
    local ret = game_ment_hit.process_hit_and_got_hit(args)
    local terminal = ret.terminal_hit
    
    if terminal then
        p.explode(source_inst_id, level, lp)
    end

    return terminal
end

function p.xar_process_hit(args)
    local exceptions = {}
    exceptions.no_blood = true
    exceptions.no_hurt_sound = true
    local ret = game_ment_hit.process_got_hit(args, exceptions)
    p.hit_by_dark_hole(args.target_inst_id, ret.killed)
    return ret
end

function p.hit_by_dark_hole(target_inst_id, killed)
    if( killed ) then
        local target_type = ga_ment_get_type(target_inst_id)
        if ga_ment_get_s(target_inst_id, "__death_anim") == "" then
            ga_ment_set_s(target_inst_id, "__death_anim", "dark_hole")
            local game_time = ga_get_game_time()
            ga_ment_set_f(target_inst_id, "__death_anim_start", game_time)
            ga_ment_set_f(target_inst_id, "__death_anim_end", game_time + 2.5)
            ga_play_sound("dark_hole_die")
        end
    else
        -- ga_print("ment_player_proj_dark_hole.hit_by_dark_hole")
        local target_team_id = ga_ment_get_i(target_inst_id, "__team_id_source")
        if target_team_id == 1 then return end --It is a friendly unit.
        -- ga_print("target's source id = " .. tostring(target_team_id))
        ga_play_sound("dark_hole_hit")
    end
end

function p.__on_block_hit(
    inst_id,
    level, bp, lp,
    normal_side, normal)
--
    p.explode(inst_id, level, lp)

    return true
end

function p.explode(
    inst_id,
    level, lp)
--
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    if( level >= start_level ) then return end
    --
    local damage = ga_ment_get_i(inst_id, "damage")
    -- ga_print("player_proj_dark_hole.explode: damage = " .. tostring(damage))
    --
    local radius = 500
    local ents = ga_ment_sphere_query(
        level, level, start_level-1,
        lp, radius)
    --The ents are sorted by dist to lp.
    -- ga_print("Printing results from ga_ment_sphere_query")
    local count = 0
    for k,v in pairs(ents) do
        -- ga_print("key = " .. tostring(k))
        local target_inst_id = v.inst_id
        local target_type = ga_ment_get_type(target_inst_id)
        local getting_hit_type = ga_ment_get_s(target_inst_id, "getting_hit_type")
        if( getting_hit_type == "enemy" and
            ga_ment_var_exists(target_inst_id, "health") and --Added Oct 24, 2021.
            ga_ment_get_i(target_inst_id, "health") > 0 )
        then
            count = count + 1
            local adjusted_damage = damage * (1.0 / count)
            game_ment_take_damage.from_ment(
                inst_id, target_inst_id, adjusted_damage)
            local health_after = game_ment_health.get_ment_health(target_inst_id)
            local killed = false
            if( health_after <= 0 ) then killed = true end
            p.hit_by_dark_hole(target_inst_id, killed)
        end
    end
    -- ga_exit()
    -- ga_print("player_proj_dark_hole_explode")
end
