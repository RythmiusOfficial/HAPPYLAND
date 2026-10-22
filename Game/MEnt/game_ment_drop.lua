--Right now, much of this functionality
--is in xar_ment_helpers.lua

function p.drop_general_helper_bent(
    level, lp,
    drop_bent,
    drop_bent_param_i,
    drop_bent_param_s)
--
    local bp = std.lp_to_bp(lp)
    local rl = 5.0 * 60.0 --5 minutes.
    --
    ga_bent_add(level, bp, drop_bent, rl)
    ga_bent_set_param_i(level, bp, drop_bent_param_i, rl)
    ga_bent_set_param_s(level, bp, drop_bent_param_s, rl)
end

function p.drop_general_helper_box(
    level, lp,
    drop_bent,
    drop_bent_param_i,
    drop_bent_param_s,
    drop_extra_levels,
    drop_box_txt)
--
    ga_debug_push("game_ment_drop.drop_general_helper_box")

    ga_ment_start(
        level, lp,
        "ment_general_drop_box")
    -- ga_ment_init_set_f("ttl", 60.0 * 5.0) --5 minutes
    ga_ment_init_set_f("ttl", 60.0 * 60.0) --1 hour. (Making it longer).
    ga_ment_init_set_s("drop_bent", drop_bent)
    ga_ment_init_set_i("drop_bent_param_i", drop_bent_param_i)
    ga_ment_init_set_s("drop_bent_param_s", drop_bent_param_s)
    ga_ment_init_set_i("drop_extra_levels", drop_extra_levels)
    ga_ment_init_set_s("identity_str", drop_box_txt)
    ga_ment_end()

    ga_debug_pop("game_ment_drop.drop_general_helper_box")
end

--Should be created by an entity on the given level.
--Usually, level should be the start level of the ment.
--Called when an ment dies,
--also on the too_fine level when a box becomes too fine.
function p.drop_general(
    level, lp,
    drop_bent,
    drop_bent_param_i,
    drop_bent_param_s,
    drop_extra_levels,
    drop_box_allow,
    drop_box_txt,
    fireworks)
--
    if drop_bent == "" then return end

    local viewer_level = ga_get_viewer_level()
    local zero_level_diff = ( viewer_level - level == 0 )
    local zero_extra_levels = ( drop_extra_levels == 0 )

    if drop_box_allow then
        if zero_level_diff and zero_extra_levels then
            --Drop a bent.
            p.drop_general_helper_bent(
                level, lp,
                drop_bent,
                drop_bent_param_i,
                drop_bent_param_s)
        else
            --Drop a box.
            p.drop_general_helper_box(
                level, lp,
                drop_bent,
                drop_bent_param_i,
                drop_bent_param_s,
                drop_extra_levels,
                drop_box_txt)
        end
    else
        if zero_extra_levels then
            --Drop a bent.
            p.drop_general_helper_bent(
                level, lp,
                drop_bent,
                drop_bent_param_i,
                drop_bent_param_s)
        else
            --Dropping nothing.
        end
    end

    if( fireworks ) then
        local args = {}
        args.level = level
        args.pos = lp
        args.ttl_min = 1.0
        args.ttl_max = 3.0
        args.size_min = 1.0
        args.size_max = 1.0
        args.color = std.vec(1.0, 1.0, 0.0)
        args.fade_time_min = 1.0
        args.fade_time_max = 1.0
        args.speed_min = 2.0
        args.speed_max = 6.0
        args.tex = "particle_2"
        args.radius_min = 1.0
        args.radius_max = 1.0
        args.num = 50
        args.use_min_dist = false
        ga_particle_explosion(args)

        ga_play_sound("drop_level")
    end
end

--Should I add more functions?
