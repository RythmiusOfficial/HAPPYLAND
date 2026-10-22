-------------------------------------------------
--       Rendering, Geometry, and Motion
-------------------------------------------------

function p.get_turn_towards_player_speed() return 0.5 end

-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60)
    ia_ment_set_builtin_var_f(id, "__radius", 3.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterBee")
    ia_ment_new_var_i(id, "health", 10000, 60.0)
    ia_ment_new_static_var_f(id, "dps", 2.0)
    ia_ment_new_static_var_s(id, "sound_death", "die_bee_queen")
    ia_ment_new_static_var_s(id, "die_drop_bent", "bent_gold_3")
    ia_ment_new_static_var_s(id, "identity_str", "Queen Bee")
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_f(id, "shoot_period", 4.0)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_spider_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 1000.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 1.0)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 8)
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
