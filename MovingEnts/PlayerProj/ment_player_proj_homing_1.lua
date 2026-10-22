-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_f(id, "__ttl", 10.0)
    ia_ment_set_builtin_var_f(id, "__radius", 0.2)
    ia_ment_set_builtin_var_s(id, "__mesh", "homing")
    ia_ment_set_builtin_var_b(id, "__homing", true)
    ia_ment_set_builtin_var_b(id, "__homing_player_vis_test", true); --Expensive.
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

    if( ret.killed ) then 
        local target_level = ga_ment_get_i(target_inst_id, "__start_level")
        local target_lp = ga_convert_lp(level, target_level, lp).value
        p.explosion(target_level, target_lp, target_inst_id)
    end

    --Could play a sound.

    return ret.terminal_hit
end

function p.__on_level_travel(
    inst_id, level,
    start_vec, end_vec)

    local args = {}
    args.level = level
    args.pos_start = start_vec
    args.pos_end = end_vec
    args.ttl_min = 1.0
    args.ttl_max = 2.0
    local size = 0.5
    args.size_min = size
    args.size_max = size
    args.color = std.vec(1.0, 0.0, 0.0)
    args.fade_time_min = 1.0
    args.fade_time_max = 1.0
    args.speed_min = 0.0
    args.speed_max = 0.0
    args.tex = "particle_1"
    args.radius_min = 0.0
    args.radius_max = 0.0
    args.avg_len = 1.0
    args.use_min_dist = true
    ga_particle_trail(args)
end

function p.explosion(level, lp, target_inst_id)
    -- ga_print("laser 2 explosion")
    -- ga_print("  level = " .. tostring(level))
    local radius = 10000
    local ents = ga_ment_sphere_query(
        level, level, level,
        lp, radius)
    local gun = 6
    local mode = 1 --MAY NEED TO CHANGE!!!!!!!!!!!!!!!!!!!!!!!!!!!
    local damage = game_wep_modes.get_curved_damage(gun, mode)
    local count = 0
    for k,v in pairs(ents) do
        local target_inst_id2 = v.inst_id
        if target_inst_id2 ~= target_inst_id then
            local getting_hit_type = ga_ment_get_s(target_inst_id2, "getting_hit_type")
            if getting_hit_type == "enemy" then
                count = count + 1
                if count >= 30 then break end
                --
                local target_lp = ga_ment_get_lp(target_inst_id2)
                --
                ga_ment_start(level, lp, "ment_player_proj_minigun_1")
                local dir = std.vec_sub(target_lp, lp)
                std.normalize(dir)
                local speed = 100000
                local vel = std.vec_scale(dir, speed)
                ga_ment_init_set_v("__vel", vel)
                ga_ment_init_set_i("damage", damage)
                ga_ment_init_set_i("ignore_ment_inst_id", target_inst_id)
                ga_ment_end()
            end
        end
    end
end
