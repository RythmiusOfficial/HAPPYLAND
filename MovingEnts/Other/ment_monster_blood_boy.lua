-------------------------------------------------
--       Rendering, Geometry, and Motion
-------------------------------------------------

function p.get_turn_towards_player_speed() return 2.0 end

-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_f(id, "__radius", 1.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterBloodBoy")
    ia_ment_new_var_i(id, "health", 1000000, 60.0)
    ia_ment_new_static_var_f(id, "dps", 1.0)
    ia_ment_new_static_var_s(id, "sound_death", "monster_death") --Not needed because is default.
    ia_ment_new_static_var_s(id, "identity_str", "Blood Boy")
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
