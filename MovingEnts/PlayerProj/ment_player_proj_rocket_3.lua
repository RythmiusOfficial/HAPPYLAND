-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 2)
    ia_ment_set_builtin_var_f(id, "__radius", 3.0)
    ia_ment_set_builtin_var_b(id, "__turn_around_vel", true)
    ia_ment_set_builtin_var_f(id, "__turn_speed", 6.0) --Radians per second.
    ia_ment_set_builtin_var_s(id, "__mesh", "rocket3")
    ia_ment_set_builtin_var_f(id, "__max_screen_size", 0.25)
    ia_ment_set_builtin_var_f(id, "__max_screen_size_time_len", 1.0)
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
    local terminal = ret.terminal_hit

    --In side this function, at some point a class
    --called ret is created, but this shadows the previous ret.
    if terminal then
        p.explode(args.source_inst_id, level, lp)
    end

    return terminal
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
    args.ttl_min = factor
    args.ttl_max = factor
    local size = 0.5 * factor
    args.size_min = size
    args.size_max = size
    args.color = std.vec(1.0, 0.0, 0.0)
    args.fade_time_min = factor
    args.fade_time_max = factor
    args.speed_min = 0.0
    args.speed_max = 0.0
    args.tex = "particle_1"
    args.radius_min = 0.0
    args.radius_max = 0.0
    args.avg_len = 2.0
    args.use_min_dist = true --No smoke to close to player.
    ga_particle_trail(args)
end

function p.__on_block_hit(
    inst_id,
    level, bp, lp,
    normal_side, normal)
--
    p.explode(inst_id, level, lp)

    return true
end

function p.explode(inst_id, level, lp)
    ga_play_sound("rocket_explode")

    --Cannot get the sllp the usual way because
    --this could be during a ment move operation./
    --(PROBABLY SHOULD UPDATE MENT POS DURING THE MOVE?!?!?)
    --Maybe have a "moving_sllp" variable which is updated
    --during a move, and the ga_ment_get_sllp function gets
    --that var during a move.
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local sllp = ga_convert_lp(level, start_level, lp).value

    local radius = game_wep_modes.get_radius(4,3)

    --The scaling of the damage from the player
    --should happen at the last possible moment.
    local damage = ga_ment_get_i(inst_id, "damage")

    local ents = ga_ment_sphere_query(
        start_level, start_level, start_level,
        sllp, radius)
    for k,v in pairs(ents) do
        local target_inst_id = v.inst_id
        local getting_hit_type = ga_ment_get_s(target_inst_id, "getting_hit_type")
        if getting_hit_type == "enemy" then
            game_ment_take_damage.from_ment(inst_id, target_inst_id, damage)
        end
    end

    if( game_flash.flashes_enabled() ) then
        local data = ga_finest_chunk_containing_lp(start_level, sllp)
        if( data.is_valid ) then
            ga_ment_start(data.level, data.lp, "ment_rocket_3_explosion")
            ga_ment_init_set_f("launch_level", start_level)
            ga_ment_end()
        end
    end
end
