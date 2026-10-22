-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 4)
    ia_ment_set_builtin_var_f(id, "__radius", 0.001)
    ia_ment_set_builtin_var_s(id, "__mesh", "dummy")
    ia_ment_new_static_var_b(id, "identifies", true)
    ia_ment_new_var_i(id, "last_hit_ment_inst_id", -1, 60.0) --Weird.
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.__on_ment_hit(
    source_inst_id,
    target_inst_id,
    level, lp, normal)
--
    if( not ment_player_proj_railgun_1.multiple_hit_check(
        source_inst_id, target_inst_id) )
    then
        --The source ment does not stop,
        --but it also does not deal damage.
        return false
    end

    local args = {}
    args.source_inst_id = source_inst_id
    args.target_inst_id = target_inst_id
    args.level = level
    args.lp = lp
    args.normal = normal
    --
    local ret = game_ment_hit.process_hit_and_got_hit(args)

    --In the old way,
    --the railgun goes through iff it kills the monster.
    -- local terminal_hit = ret.terminal_hit
    -- if( ret.killed ) then terminal_hit = false end

    --In the new way, it always goes through.
    local terminal_hit = false

    return terminal_hit
    -- return ret.terminal_hit
end

function p.__on_level_travel(
    inst_id, level,
    start_vec,
    end_vec)
    --Getting level info.
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local factor = ga_level_scale_factor(start_level, level).value
    local diff = start_level - level

    local args = {}
    args.level = level
    args.pos_start = start_vec
    args.pos_end = end_vec
    args.ttl_min = 2.0 * factor
    args.ttl_max = 3.0 * factor
    local size = 1.0 * factor
    if diff == 1 then size = size * 2.0 end
    if diff == 2 then size = size * 5.0 end
    args.size_min = size
    args.size_max = size
    args.color = std.vec(0.0, 1.0, 1.0)
    args.fade_time_min = 1.0 * factor
    args.fade_time_max = 1.0 * factor
    args.speed_min = 2.0
    args.speed_max = 2.0
    args.tex = "particle_2"
    args.radius_min = 0.5 * factor
    args.radius_max = 0.5 * factor
    args.avg_len = 1.0
    args.use_min_dist = true --No smoke to close to player.
    ga_particle_trail(args)
end

function p.xar_process_hit(args)
    local exceptions = {}
    local ret = game_ment_hit.process_got_hit(args, exceptions)
    --
    -- ga_print("returned damage dealt: " .. tostring(ret.damage_dealt))
    local max_health = ga_get_i("xar.player.health.max")
    local health = ga_get_i("xar.player.health.amount")
    if( health < max_health*2 ) then
        health = health + math.floor(ret.damage_dealt / 4)
        if( health > max_health*2 ) then health = max_health*2 end
        ga_set_i("xar.player.health.amount", health)
    end
    return ret
end
