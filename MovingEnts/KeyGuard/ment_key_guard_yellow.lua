-------------------------------------------------
--       Rendering, Geometry, and Motion
-------------------------------------------------

function p.get_solid_wrt_player() return true end
function p.get_turn_towards_player_speed() return 0.5 end

-------------------------------------------------
--            Type Init Function
-------------------------------------------------

--Maybe make it get damage,
--but no damage is dealt, instead the sound
--"you need a yellow key to pass" is played!
function p.__type_init(id)
    game_ment_type_init.monster(id) --Ok.
    ia_ment_set_builtin_var_f(id, "__radius", 2.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterKeyYellow")
    ia_ment_set_builtin_var_i(id, "__team_id_source", 0)
    ia_ment_set_builtin_var_i(id, "__team_id_target", 0)
    ia_ment_new_static_var_s(id, "identity_str", "YOU NEED A YELLOW KEY TO PASS BY")
    ia_ment_new_static_var_b(id, "identity_str_no_health", true)
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_f(id, "shoot_period", 0.1)
    ia_ment_new_static_var_f(id, "shoot_radius", 12.0)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_key_guard_yellow_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 1000.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 1.0)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 10000)
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
