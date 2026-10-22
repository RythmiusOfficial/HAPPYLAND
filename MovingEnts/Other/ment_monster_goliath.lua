-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 4.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterGoliath")
    ia_ment_set_builtin_var_v(id, "__turn_towards_player_axis", std.vec(1,0,0))
    -- ia_ment_set_builtin_var_v(id, "__turn_towards_player_axis", std.vec(0,0,1)) --Debugging.
    ia_ment_new_var_i(id, "health", 200000, 60.0)
    ia_ment_new_static_var_f(id, "dps", 30.0)
    ia_ment_new_static_var_f(id, "xp_mod", 3) --High!
    ia_ment_new_static_var_s(id, "sound_hurt", "hurt_goliath")
    ia_ment_new_static_var_f(id, "sound_hurt_period", 0.95)
    ia_ment_new_static_var_s(id, "sound_death", "die_goliath")
    ia_ment_new_static_var_b(id, "emp_immune", true)
    ia_ment_new_static_var_s(id, "identity_str", "Goliath")
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_f(id, "shoot_period", 1.0)
    ia_ment_new_static_var_b(id, "shoot_period_lvlinv", true)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_spider_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 1000000.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 1.0)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 30)
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.__on_add_to_live_world(inst_id)
    -- ga_print("Goliath: add to live world") --Debugging!!!

    game_ment_add_to_live.monster(inst_id)

    --DEBUGGING!!!
    -- ga_print("\nAdding dummy goliath alarms:")
    -- local cur_time = ga_get_game_time()
    -- local alarm_time = cur_time + 1.0
    -- ga_print("Adding first goliath alarm...")
    -- ga_ment_set_alarm(inst_id, alarm_time, "debug_alarm_name")
    -- ga_print("Adding second goliath alarm...")
    -- ga_ment_set_alarm(inst_id, alarm_time, "debug_alarm_name")
end

function p.__on_alarm(inst_id, alarm_name)
    game_ment_alarms.monster(inst_id, alarm_name)
end

-- -- Debugging.
-- function p.__on_update(inst_id, elapsed_time, elapsed_level_time)
--     -- local type = ga_ment_get_var_type(inst_id, "shoot_period")
--     -- local type = ga_ment_get_var_type(inst_id, "fooooo")
--     -- ga_print("ment_monster_goliath: type = " .. type) --Not a var name.

-- --     ga_print("ment_monster_goliath.__on_update:")
-- --     local chunk_id = ga_ment_get_chunk_id(inst_id)
-- --     local hack_offset = std.vec(8.0, 8.0, 8.0)
-- --     local lp1 = ga_chunk_id_and_offset_to_lp(chunk_id, hack_offset)
-- --     --
-- --     local vcp = ga_chunk_id_to_vcp(chunk_id)
-- --     local lp2 = ga_offset_to_lp(vcp, hack_offset)
-- --     --
-- --     ga_print("lp1 = " .. std.vec_to_str(lp1))
-- --     ga_print("lp2 = " .. std.vec_to_str(lp2))
-- end
