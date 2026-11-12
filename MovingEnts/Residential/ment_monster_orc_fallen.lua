-------------------------------------------------
--       Rendering, Geometry, and Motion
-------------------------------------------------

function p.get_solid_wrt_player() return true end
function p.get_turn_towards_player_speed() return 0.5 end

-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id) --Ok.
    ia_ment_set_builtin_var_f(id, "__radius", 2.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterOrcFallen")
    ia_ment_set_builtin_var_i(id, "__team_id_source", 0)
    ia_ment_set_builtin_var_i(id, "__team_id_target", 0)
    ia_ment_new_static_var_s(id, "identity_str", "O R C")
    ia_ment_new_static_var_b(id, "identity_str_no_health", true)
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