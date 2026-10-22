    -------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_f(id, "__ttl", 10.0)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 2)
    ia_ment_set_builtin_var_f(id, "__radius", 0.1)
    ia_ment_set_builtin_var_s(id, "__mesh", "minigun2")
    ia_ment_new_static_var_b(id, "identifies", true)
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

--Yellow trail.
function p.__on_level_travel(
    inst_id, level,
    start_vec,
    end_vec)
    --Getting level info.
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local diff = start_level - level

    if diff > 0 then return end

    local args = {}
    args.level = level
    args.pos_start = start_vec
    args.pos_end = end_vec
    args.ttl_min = 0.5
    args.ttl_max = 0.5
    args.size_min = 0.1
    args.size_max = 0.1
    args.color = std.vec(1.0, 1.0, 0.0)
    args.fade_time_min = 0.5
    args.fade_time_max = 0.5
    args.speed_min = 0.0
    args.speed_max = 0.0
    args.tex = "particle_2"
    args.radius_min = 0.0
    args.radius_max = 0.0
    args.avg_len = 1.0
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

    -- local diff = start_level - level

    -- ga_print("ment_player_proj_plasma_6.__on_block_hit: start_level = " .. tostring(start_level))
    -- ga_print("ment_player_proj_plasma_6.__on_block_hit: level = " .. tostring(level))
    -- ga_print("ment_player_proj_plasma_6.__on_block_hit: sllp = " .. std.vec_to_str(sllp))

    p.ring_effect(start_level, sllp, normal)
    -- p.ring_effect(level, lp, normal, diff)

    return true
end

function p.ring_effect(level, lp, normal)
    p.ring_effect_particles(level, lp, normal)
    p.ring_effect_projectiles(level, lp, normal)
end

function p.ring_effect_particles(level, lp, normal)
    local mod_lp = std.vec_add(lp, std.vec_scale(normal,0.5))

    local args = {}
    args.level = level
    args.pos = mod_lp
    args.normal = normal
    args.ttl_min = 1.0
    args.ttl_max = 2.0
    args.size_min = 2.0
    args.size_max = 2.0
    -- args.size_min = 0.4
    -- args.size_max = 0.6
    args.color = std.vec(1.0, 1.0, 0.0)
    args.fade_time_min = 1.0
    args.fade_time_max = 1.0
    args.tex = "particle_2"
    args.radius = 1.0
    -- args.speed = 2.0
    args.speed = 10.0
    args.num = 100
    args.use_min_dist = false
    ga_particle_ring(args)
end

function p.ring_effect_projectiles(level, lp, normal)
    --Todo: Change the ga_ment_start function so that it
    --moves the ment to the finest level that contains the lp
    --(even if there is no chunk containing the lp on the level
    --given to the ga_ment_start function).
    --
    -- local level2 = level
    -- local lp2 = lp
    -- local data = ga_finest_chunk_containing_lp(level, lp)
    -- if( not data.is_valid ) then return end --Should not happen.
    -- if( data.level ~= level ) then
    --     level2 = data.level
    --     lp2    = data.lp
    -- end
    --
    local off_1 = std.vec_scale(normal, 0.1)
    local start_pos = std.vec_add(lp, off_1)
    --
    --Todo: Use a helper function.
    local rand_vec = std.vec(
        ga_randf() - 0.5,
        ga_randf() - 0.5,
        ga_randf() - 0.5)
    -- std.normalize(rand_vec)
    local axis_1 = std.cross(rand_vec, normal)
    std.normalize(axis_1)
    local axis_2 = std.cross(axis_1, normal)
    std.normalize(axis_2) --Redundant.
    --
    local num = 30
    for i = 1,num do
        local theta = 2 * 3.14159 * (i / num)
        local dir =
            std.vec_add(
                std.vec_scale(axis_1, math.cos(theta)),
                std.vec_scale(axis_2, math.sin(theta)) )
        std.normalize(dir) --Redundant.
        local speed = 100000
        local vel = std.vec_scale(dir, speed)
        ga_ment_start(level, start_pos, "ment_player_proj_plasma_6_2")
        ga_ment_init_set_v("__vel", vel)
        ga_ment_end()
    end
end
