function p.blood_hurt(inst_id, damage)
    local num_blood = 1 + math.floor(p.num_blood_helper(damage) / 2)

    local fast = true
    local from_center = false
    p.blood_several(inst_id, num_blood, fast, from_center)
end

function p.num_blood_helper(health)
    if( health < 100 ) then
        return health / 10; --Max 10.
    elseif( health < 1000 ) then
        local diff = health - 100
        return 10 + math.floor(diff/20) --Max = 10 + 45 = 55.
    elseif( health < 10000 ) then
        local diff = health - 1000
        return 55 + math.floor(diff/100) --Max = 55 + 90 = 145.
    elseif( health < 100000 ) then
        local diff = health - 10000
        return 145 + math.floor(diff/1000) --Max = 145 + 90 = 235.
    elseif( health < 1000000 ) then
        local diff = health - 100000
        return 235 + math.floor(diff/10000) --Max = 235 + 90 = 325.
    else
        return 325
    end
end

function p.blood_several(inst_id, num_blood, fast, from_center)
    --Scaling factor
    local speed_scale = 1.0
    if( fast ) then speed_scale = 2.0 end

    local level = ga_ment_get_i(inst_id, "__start_level")
    local sllp = ga_ment_get_sllp(inst_id)
    local radius = ga_ment_get_f(inst_id, "__radius")

    local ttl_scale = 1.0
    local fade_time_scale = 1.0

    local viewer_level = ga_get_viewer_level()
    local level_diff = viewer_level - level
    if level_diff >= 1 then
        ttl_scale = ttl_scale / 10.0
        fade_time_scale = fade_time_scale / 10.0
        speed_scale = speed_scale * 10.0
        if level_diff >= 2 then
            ttl_scale = ttl_scale / 10.0
            fade_time_scale = fade_time_scale / 10.0
            speed_scale = speed_scale * 10.0
        end
    end

    local args = {}
    args.level = level
    args.pos = sllp
    args.ttl_min = ttl_scale*2.0
    args.ttl_max = ttl_scale*3.0
    args.size_min = 0.5
    args.size_max = 0.5
    args.color = std.vec(1.0, 0.0, 0.0)
    args.fade_time_min = fade_time_scale
    args.fade_time_max = fade_time_scale
    args.speed_min = speed_scale*1.5
    args.speed_max = speed_scale*3.0
    args.tex = "particle_1"
    args.radius_min = radius
    args.radius_max = radius
    args.num = num_blood
    args.use_min_dist = true --No blood too close to viewer.
    ga_particle_explosion(args)
end

function p.die_explosion(inst_id)
    local ment_type = ga_ment_get_type(inst_id)
    local max_health = game_ment_health.get_ment_max_health(inst_id)

    local radius = ga_ment_get_f(inst_id, "__radius")
    radius = radius * 0.25

    local level = ga_ment_get_i(inst_id, "__start_level")
    local sllp = ga_ment_get_sllp(inst_id)

    local num_blood = math.floor(2 * p.num_blood_helper(max_health))
    if( ga_ment_type_var_exists(ment_type, "blood_die_override") ) then
        num_blood = ga_ment_get_i(inst_id, "blood_die_override")
    end

    local ttl_scale = 1.0
    local fade_time_scale = 1.0
    local speed_scale = 1.0

    local viewer_level = ga_get_viewer_level()
    local level_diff = viewer_level - level
    if level_diff >= 1 then
        ttl_scale = ttl_scale / 10.0
        fade_time_scale = fade_time_scale / 10.0
        speed_scale = speed_scale * 10.0
        if level_diff >= 2 then
            ttl_scale = ttl_scale / 10.0
            fade_time_scale = fade_time_scale / 10.0
            speed_scale = speed_scale * 10.0
        end
    end

    local args = {}
    args.level = level
    args.pos = sllp
    args.ttl_min = ttl_scale*2.0
    args.ttl_max = ttl_scale*3.0
    args.size_min = 0.5
    args.size_max = 0.5
    args.color = std.vec(1.0, 0.0, 0.0)
    args.fade_time_min = fade_time_scale
    args.fade_time_max = fade_time_scale
    args.speed_min = speed_scale*1.5
    args.speed_max = speed_scale*3.0
    args.tex = "particle_1"
    args.radius_min = radius
    args.radius_max = radius
    args.num = num_blood
    args.use_min_dist = true --No blood too close to viewer.
    ga_particle_explosion(args)
end
