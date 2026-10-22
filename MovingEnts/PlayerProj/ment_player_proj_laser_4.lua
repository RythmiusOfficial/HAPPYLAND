-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_f(id, "__ttl", 1.0)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 2)
    ia_ment_set_builtin_var_f(id, "__radius", 0.001)
    ia_ment_set_builtin_var_s(id, "__mesh", "dummy")
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

    --Ring effect.
    local start_level = ga_ment_get_i(source_inst_id, "__start_level")
    local sllp = ga_convert_lp(level, start_level, lp).value
    p.ring_effect(start_level, sllp, normal)

    local target_level = ga_ment_get_i(target_inst_id, "__start_level")
    local target_lp = ga_convert_lp(level, target_level, lp).value

    if( ret.killed ) then p.laser_explosion(target_level, target_lp, target_inst_id) end
    -- if( ret.killed ) then p.laser_explosion(level, lp, target_inst_id) end

    return ret.terminal_hit
end

function p.laser_explosion(level, lp, target_inst_id)
    ga_print("laser 2 explosion")
    ga_print("  level = " .. tostring(level))
    local radius = 10000
    local ents = ga_ment_sphere_query(
        level, level, level,
        lp, radius)
    local gun = 3
    local mode = 1 --Might want to change.
    local damage = game_wep_modes.get_curved_shot_damage(gun, mode)
    local count = 0
    for k,v in pairs(ents) do
        local target_inst_id2 = v.inst_id
        if target_inst_id2 ~= target_inst_id then
            local getting_hit_type = ga_ment_get_s(target_inst_id2, "getting_hit_type")
            if getting_hit_type == "enemy" then
                count = count + 1
                if count >= 100 then break end
                --
                local target_lp = ga_ment_get_lp(target_inst_id2)
                --
                ga_ment_start(level, lp, "ment_player_proj_laser_1_lite")
                local dir = std.vec_sub(target_lp, lp)
                std.normalize(dir)
                local speed = 100000
                local vel = std.vec_scale(dir, speed)
                ga_ment_init_set_v("__vel", vel)
                ga_ment_init_set_i("damage", damage)
                ga_ment_init_set_i("ignore_ment_inst_id", target_inst_id)
                ga_ment_init_set_b("no_ring", true)
                ga_ment_end()
            end
        end
    end
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
    args.ttl_min = 1.0 * factor
    args.ttl_max = 2.0 * factor
    local size = 0.1 * factor
    if diff == 1 then size = size * 2.0 end
    if diff == 2 then size = size * 5.0 end
    args.size_min = size
    args.size_max = size
    args.color = std.vec(0.0, 1.0, 0.0)
    args.fade_time_min = 1.0 * factor
    args.fade_time_max = 1.0 * factor
    args.speed_min = 0.0
    args.speed_max = 0.0
    args.tex = "particle_2"
    args.radius_min = 0.0
    args.radius_max = 0.0
    args.avg_len = 0.5
    args.use_min_dist = false
    ga_particle_trail(args)
end

function p.__on_block_hit(
    inst_id,
    level, bp, lp,
    normal_side, normal)
--
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local sllp = ga_convert_lp(level, start_level, lp).value

    p.ring_effect(start_level, sllp, normal)

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
    args.color = std.vec(0.0, 1.0, 0.0)
    args.fade_time_min = 1.0
    args.fade_time_max = 1.0
    args.tex = "particle_2"
    args.radius = 1.0
    args.speed = 4.0
    args.num = 100
    args.use_min_dist = false
    ga_particle_ring(args)
end
