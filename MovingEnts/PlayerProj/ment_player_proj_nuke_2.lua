-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 2)
    ia_ment_set_builtin_var_f(id, "__radius", 20.0)
    ia_ment_set_builtin_var_b(id, "__turn_around_vel", true)
    ia_ment_set_builtin_var_f(id, "__turn_speed", 2.0) --Radians per second.
    ia_ment_set_builtin_var_s(id, "__mesh", "nuke2")
    ia_ment_set_builtin_var_f(id, "__max_screen_size", 0.75)
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
    local valid_hit = ret.terminal_hit
    --
    if valid_hit then
        game_ment_identify.maybe(target_inst_id)
        p.explode(source_inst_id, level, lp)
    end

    return valid_hit
end

function p.__on_block_hit(
    inst_id,
    level, bp, lp,
    normal_side, normal)
--
    -- lp = std.vec(lp_x, lp_y, lp_z)

    p.explode(inst_id, level, lp)

    return true
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
    args.ttl_min = 3.0 * factor
    args.ttl_max = 5.0 * factor
    local size = 1.0 * factor
    if diff == 1 then size = size * 2.0 end
    if diff == 2 then size = size * 5.0 end
    args.size_min = size
    args.size_max = size
    args.color = std.vec(0.0, 1.0, 0.5)
    args.fade_time_min = 1.0 * factor
    args.fade_time_max = 5.0 * factor
    args.speed_min = 0.0
    args.speed_max = 0.0
    args.tex = "particle_2"
    args.radius_min = 0.0
    args.radius_max = 0.0
    args.avg_len = 1.0
    args.use_min_dist = true --No smoke to close to player.
    ga_particle_trail(args)
end

--Helper function.
function p.explode(inst_id, level, lp)
    ga_play_sound("nuke_hit_secondary")

    local flash_color = std.vec(1.0, 1.0, 1.0)
    local flash_alpha = 0.5
    local flash_duration = 1.0
    game_flash.add_flash_now(
        flash_color,
        flash_alpha,
        flash_duration)

    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local sllp = ga_convert_lp(level, start_level, lp).value

    local radius = game_wep_modes.get_radius(9,2)
    local damage = game_wep_modes.get_curved_expl_damage(9,2)
    if( damage < 1 ) then return end

    --ga_print("player_proj_nuke_1 radius = " .. tostring(radius))
    --ga_print("  damage = " .. tostring(damage))

    local min_level = start_level - 3
    local max_level = start_level

    local ents = ga_ment_sphere_query(
        start_level, min_level, max_level,
        sllp, radius)
    for k,v in pairs(ents) do
        target_inst_id = v.inst_id
        getting_hit_type = ga_ment_get_s(target_inst_id, "getting_hit_type")
        if getting_hit_type == "enemy" then
            game_ment_take_damage.from_ment(inst_id, target_inst_id, damage)
        end
    end

    --Creating explosion graphical ment effect.
    if( game_flash.flashes_enabled() ) then
        local data = ga_finest_chunk_containing_lp(start_level, sllp)
        if( data.is_valid ) then
            ga_ment_start(data.level, data.lp, "ment_nuke_2_explosion")
            ga_ment_init_set_f("launch_level", start_level)
            ga_ment_end()
        end
    end
end
