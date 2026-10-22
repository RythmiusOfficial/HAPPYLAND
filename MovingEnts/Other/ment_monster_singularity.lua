-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 0.5)
    ia_ment_set_builtin_var_s(id, "__mesh", "") --Dummy.
    ia_ment_new_var_i(id, "health", 10000000, 60.0) --10 million.
    ia_ment_new_static_var_f(id, "xp_mod", 6) --Very High!
    ia_ment_new_static_var_f(id, "dps", 1000.0)
    ia_ment_new_static_var_s(id, "sound_death", "die_singularity")
    ia_ment_new_static_var_s(id, "sound_hurt", "hurt_deep_ahh")
    ia_ment_new_static_var_f(id, "sound_hurt_period", 0.6)
    ia_ment_new_static_var_s(id, "identity_str", "Singularity")
    --
    ia_ment_new_static_var_s(id, "die_drop_bent", "bent_key_green")
    ia_ment_new_static_var_i(id, "die_drop_bent_param_i", 60)
    ia_ment_new_static_var_s(id, "die_drop_bent_param_s", "supermassive_blackhole_3")
    ia_ment_new_static_var_s(id, "die_drop_box_txt", "Green Key")
    ia_ment_new_static_var_b(id, "die_drop_box_allow", true)
    ia_ment_new_static_var_i(id, "die_drop_extra_levels", 1)
    --
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_f(id, "shoot_period", 1.0)
    ia_ment_new_static_var_b(id, "shoot_period_lvlinv", true)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_singularity_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 100000000.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 1.0)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 1000)
    --
    ia_ment_new_static_var_b(id, "damage_aura_has", true)
    ia_ment_new_static_var_f(id, "damage_aura_duration", 2.0)
    ia_ment_new_static_var_i(id, "damage_aura_damage", 50)
    ia_ment_new_static_var_f(id, "damage_aura_radius", 32.0)
    ia_ment_new_static_var_b(id, "damage_aura_only_same_level", false)
    ia_ment_new_var_f(id, "damage_aura_next_time", 0.0, 60.0)
    --
    ia_ment_new_var_b(id, "tele_requested", false, 5 * 60.0) --Weird.
    ia_ment_new_var_f(id, "tele_time", -1.0, 5 * 60.0)       --Weird.
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.__on_add_to_live_world(inst_id)
    game_ment_add_to_live.monster(inst_id)
end

function p.__on_alarm(inst_id, alarm_name)
    game_ment_alarms.monster(inst_id, alarm_name)
end

function p.__on_render(inst_id)
    --The radius of the ment on the ment's level.
    local ment_radius = ga_ment_get_radius(inst_id)
    ga_render_matrix_scaled(ment_radius, ment_radius, ment_radius)
    --
    --The rest is slightly different from green shrinker rings.
    local cur_time = ga_get_game_time()
    local speed_mod = 1.0
    --
    local angle1 = cur_time * 50.0 * speed_mod
    local axis1 = std.vec(1.0, 0.0, 0.0)
    ga_render_matrix_rotated(angle1, axis1)
    ga_render_mesh("MonsterSingularityRingLarge")
    --
    local angle2 = cur_time * 90.0 * speed_mod
    local axis2 = std.vec(0.0, 1.0, 0.0)
    ga_render_matrix_rotated(angle2, axis2)
    ga_render_mesh("MonsterSingularityRingMed")
    --
    local angle3 = cur_time * 200.0 * speed_mod
    local axis3 = std.vec(1.0, 0.0, 0.0)
    ga_render_matrix_rotated(angle3, axis3)
    ga_render_mesh("MonsterSingularityRingSmall")
end

--This is called by game_ment_hit.
function p.xar_process_got_hit(args, exceptions)
    -- ga_print("the singularity is being hit")
    local inst_id = args.target_inst_id

    local team_id_1 = ga_ment_get_i(args.source_inst_id, "__team_id_source")
    local team_id_2 = ga_ment_get_i(args.target_inst_id, "__team_id_target")
    if( team_id_1 ~= team_id_2 ) then
        p.request_tele_maybe(inst_id)
    end

    local ret = game_ment_hit.default_xar_process_got_hit(args, exceptions)
    return ret
end

function p.request_tele_maybe(inst_id)
    if ga_ment_get_b(inst_id, "tele_requested") then return end
    ga_ment_set_b(inst_id, "tele_requested", true)

    local game_time = ga_get_game_time()
    local tele_delay = 1.0
    local tele_time = game_time + tele_delay
    ga_ment_set_f(inst_id, "tele_time", tele_time)
end

function p.get_base_chunk_id(inst_id)
    local start_level = ga_ment_get_i(inst_id, "__start_level")
    local cur_chunk_id = ga_ment_get_chunk_id(inst_id)
    return ga_chunk_id_to_ancestor_chunk_id(cur_chunk_id, start_level)
end

function p.__on_update(inst_id)
    p.tele_maybe(inst_id)
end

function p.tele_maybe(inst_id)
    if not ga_ment_get_b(inst_id, "tele_requested") then return end
    local game_time = ga_get_game_time()
    local tele_time = ga_ment_get_f(inst_id, "tele_time")
    if( game_time < tele_time ) then return end
    --Actually need to teleport.

    --So can teleport again.
    ga_ment_set_b(inst_id, "tele_requested", false)

    --The chunk we will be teleporting within.
    local base_chunk_id = p.get_base_chunk_id(inst_id)

    ga_srand(ga_get_sys_time())
    local num_tries = 100
    for i = 1,num_tries do
        local x = ga_randi(4,10) --Fragile.
        local y = ga_randi(4,10) --Fragile.
        local z = ga_randi(3,9)  --Fragile.
        local lbp = std.bp(x,y,z)
        local bt = ga_chunk_id_and_lbp_to_bt(base_chunk_id, lbp)
        if( bt == "XAR_BLACK_HOLE_BIG_8_AIR" ) then --Fragile.
            ga_play_sound("waypoint_travel")
            local offset = std.block_center(lbp)
            ga_ment_tele(inst_id, base_chunk_id, offset)
            return
        end
    end
    --It failed (rare).
end

--This is called by game_ment_take_damage (magically).
function p.took_damage(inst_id, damage)
    p.request_tele_maybe(inst_id)
end
