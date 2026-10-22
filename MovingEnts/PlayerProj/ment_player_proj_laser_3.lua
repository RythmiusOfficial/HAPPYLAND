-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_f(id, "__ttl", 1.0)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 4)
    ia_ment_set_builtin_var_f(id, "__radius", 0.001)
    ia_ment_set_builtin_var_s(id, "__mesh", "dummy")
    ia_ment_new_static_var_b(id, "identifies", true)
    ia_ment_new_var_b(id, "no_ring", false, 36000.0)
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.__on_ment_hit(
    source_inst_id, --The laser beam ment.
    target_inst_id,
    level, lp, normal)
--
    --Could make this part of game_ment_hit possibly.
    local source_ignore_inst_id = ga_ment_get_i(source_inst_id, "ignore_ment_inst_id")
    if( source_ignore_inst_id == target_inst_id ) then return false end --Passing through target!

    local args = {}
    args.source_inst_id = source_inst_id
    args.target_inst_id = target_inst_id
    args.level = level
    args.lp = lp
    args.normal = normal
    --
    local ret = game_ment_hit.process_hit_and_got_hit(args)
    local valid_hit = ret.terminal_hit

    if not valid_hit then return false end

    --Sheild refilling effect.
    if ret.damage_dealt > 0 then
        local shield_max = ga_get_i("xar.player.shield.max")
        ga_set_i("xar.player.shield.amount", shield_max)
    end

    --Ring effect.
    if not ga_ment_get_b(source_inst_id, "no_ring") then
        local start_level = ga_ment_get_i(source_inst_id, "__start_level")
        local sllp = ga_convert_lp(level, start_level, lp).value
        p.ring_effect(start_level, sllp, normal)
    end

    --Freeze effect.
    local freeze_len = game_wep_modes.get_freeze_length(3,2)
    local stacking = true
    game_ment_freeze.laser_initial_hit(target_inst_id, freeze_len, stacking)
    --Dr. Horrible's Sing Along blog:
    -- With my freeze ray I will stop the world
    -- With my freeze ray I will
    -- Find the time to find the words to...

    return ret.terminal_hit
end

function p.__on_level_travel(
    inst_id, level,
    start_vec,
    end_vec)
    --Getting level info.

    --Level scale factor.
    local viewer_level = ga_get_viewer_level()
    local level_diff = viewer_level - level
    local factor = ga_level_scale_factor(viewer_level, level).value

    local args = {}
    args.level = level
    args.pos_start = start_vec
    args.pos_end = end_vec
    args.ttl_min = 1.0
    args.ttl_max = 2.0
    if level_diff >= 1 then
        args.ttl_min = args.ttl_min * 2.0 * factor
        args.ttl_max = args.ttl_max * 2.0 * factor
    end
    local size = factor * 0.1
    if level_diff == 1 then size = size * 20.0 end
    if level_diff == 2 then size = size * 30.0 end
    args.size_min = size
    args.size_max = size
    args.color = std.vec(1.0, 1.0, 1.0)
    args.fade_time_min = args.ttl_min * 0.5
    args.fade_time_max = args.ttl_min * 0.5
    args.speed_min = 0.0
    args.speed_max = 0.0
    args.tex = "particle_2"
    args.radius_min = 0.0
    args.radius_max = 0.0
    args.avg_len = 0.5
    args.use_min_dist = false
    ga_particle_trail(args)
end

function p.__on_block_hit_nonfertile(
    inst_id,
    level, bp, lp,
    normal_side, normal)
--
    -- ga_print("here in ment_player_proj_laser_1.__on_block_hit_nonfertile")
    -- ga_exit()
    return p.__on_block_hit(
        inst_id,
        level, bp, lp,
        normal_side, normal)
end

function p.__on_block_hit(
    inst_id,
    level, bp, lp,
    normal_side, normal)
--
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local sllp = ga_convert_lp(level, start_level, lp).value

    if not ga_ment_get_b(inst_id, "no_ring") then
        p.ring_effect(start_level, sllp, normal)
    end

    return true
end

function p.ring_effect(level, lp, normal)
    local mod_lp = std.vec_add(lp, std.vec_scale(normal,0.5))

    local args = {}
    args.level = level
    args.pos = mod_lp
    args.normal = normal
    args.ttl_min = 1.0
    args.ttl_max = 2.0
    args.size_min = 0.4
    args.size_max = 0.6
    args.color = std.vec(1.0, 1.0, 1.0)
    args.fade_time_min = 1.0
    args.fade_time_max = 1.0
    args.tex = "particle_2"
    args.radius = 1.0
    args.speed = 4.0
    args.num = 100
    args.use_min_dist = false
    ga_particle_ring(args)
end
