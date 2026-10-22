-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__radius", 2.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterWolf")
    ia_ment_new_var_i(id, "health", 1000000, 60.0)
    ia_ment_new_static_var_f(id, "dps", 1.0)
    ia_ment_new_static_var_s(id, "identity_str", "Infinity Wolf")
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

function p.on_die(inst_id)
    game_ment_die.default(inst_id)

    --Why would you kill an Infinity Wolf?
    --They would never hurt you.
    --Now you must pay the price.
    ga_kill_player()
end

--Debugging.
-- function p.__on_update(inst_id, elapsed_time, elapsed_level_time)
--     p.update_helper_flicker()
-- end

--Debugging.
-- function p.update_helper_flicker()
--     local game_time = ga_get_game_time()
--     local game_time_int = math.floor( game_time )
--     local mesh = "MonsterWolf"
--     if( game_time_int % 2 == 0 ) then
--         mesh = "MonsterMystic"
--     end
--     ga_ment_set_s(inst_id, "__mesh", mesh)
-- end

--Debugging.
-- function p.__on_render(inst_id, radius)
--     p.render_helper(inst_id)
-- end

--Debugging.
-- function p.render_helper(inst_id)
--     local game_time = ga_get_game_time()
--     local game_time_int = math.floor( game_time )
--      if( game_time_int % 2 == 0 ) then
--         --Render nothing
--     else
--         ga_render_ment_typical(inst_id)
--     end
-- end
