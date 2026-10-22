--This file describes the various "get_" functions.

-------------------------------------------------
--                Life and Death
-------------------------------------------------

-- If __ttl is not defined, -1.0 is assumed.

-- The information of when to respawn is recorded when the entity is removed.
-- A negative respawn time means "the information of when to respawn will not be stored".
-- If get_respawn_time is not defined, then it is as if it returns -1.
-- function p.get_respawn_time() return 60 * 60 end -- One hour to respawn (units = seconds).

-- How many extra levels it can exist on.
-- NEED TO SAY MORE ABOUT THIS!!!
-- function p.get_extra_min_levels() return 0 end
-- function p.get_extra_max_levels() return 0 end

-------------------------------------------------
--       Rendering, Geometry, and Motion
-------------------------------------------------

-- If get_mesh is not defined, then the name of this file minus the .txt or .lua will be used for the meshname.
-- function p.__get_mesh() return "monster_gremlin" end

-- The mesh will be scalled by this factor.
--function p.get_radius() return 0.75 end

-- If true, then the player cannot move through the entity.
-- If not defined, then false.
-- function p.get_solid_wrt_player() return true end

-- If "", then is not homing.
-- If "player", then is homing towards the enemy.
-- If "enemy", then is homing towards the player.
-- If not defined, then the same as "".
-- function p.get_homing_type() return "" end

-- If not defined, then can turn instantaneously.
-- Let "a" and "b" be the floats returned by the following two functions.
-- Then the velocity vector turns (because of homing)
-- at the rate of a + b * vel many radians per second.
--function p.get_homing_turn_speed_a() return 1.0 end
--function p.get_homing_turn_speed_b() return 0.0 end

-------------------------------------------------
--              Damage AND Health
-------------------------------------------------

-- Each type is either "", "enemy", or "player".
-- Player hit type can hit enemy hitting type.
-- Enemy hit type can hit player hitting type.
-- These are the only combinations where hits occur.
--function p.get_getting_hit_type() return "enemy" end
--function p.get_hitting_type() return "" end

-- Negative means invulnerable.
--function p.get_health() return 10 end

--end get_damage is not defined, then damage = 0.
-- function p.get_damage() return 0 end

-- If these are not defined, it is as if they return "1.0".
-- The integer "delta" equals the other entity's level - this entity's level.
-- For example, if this entity is on level 10 and it is being shot by a
-- projectile that originally came from level 11, then delta = 1.
-- These functions should return the factor that describes
-- how much the damage should be multiplied by.
function p.xar_get_level_mod_damage_in(delta) return 1.0 end
function p.xar_get_level_mod_damage_out(delta) return 1.0 end

-------------------------------------------------
--                   Shooting
-------------------------------------------------

-- If not defined, then false.
--function p.get_shoots() return true end

--function p.get_shoot_period() return 0.6 end
--function p.get_shoot_period() return 1.2 end

-- If true, then the shoot period is the same
-- no matter the level difference between the entity and the player.
--function p.get_shoot_period_is_universal() return false end

-- If not defined, then false.
-- If true, then only shoots if the entity and player are NOT on same level.
--function p.get_shoot_requires_level_delta() return false end

-- If not defined, then is 1000.
--function p.get_shoot_radius() return 1000.0 end



-- The projectile that gets shot
-- (the name of the moving entity).
--function p.get_proj() return "monster_gremlin_proj" end

-- If not defined, then 1.
--function p.get_proj_speed() return 8.0 end

-- The time to live of the projectile.
-- If not defined, then 1.
--function p.get_proj_ttl() return 1.5 end

-- If not defined, uses the default damage of the projectile type.
--function p.get_proj_damage() return 60 end

-------------------------------------------------
--                   Sound
-------------------------------------------------
--This has all been softcoded.

-------------------------------------------------
--             Identification
-------------------------------------------------
--This has all been softcoded.

-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster(id)
    ia_ment_set_builtin_var_f(id, "__ttl", -1.0)
    ia_ment_set_builtin_var_f(id, "__respawn_length", 60*60)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 0)
    ia_ment_set_builtin_var_i(id, "__extra_max_levels", 3)
    ia_ment_set_builtin_var_f(id, "__radius", 0.75)
    ia_ment_set_builtin_var_s(id, "__mesh", "monster_gremlin")
    ia_ment_set_builtin_var_b(id, "__solid_wrt_player", true)
    ia_ment_set_builtin_var_f(id, "__turn_speed", 0.5)
    ia_ment_set_builtin_var_b(id, "__turn_towards_player", true)
    ia_ment_set_builtin_var_b(id, "__homing", false)
    ia_ment_set_builtin_var_i(id, "__team_id_source", 0)
    ia_ment_set_builtin_var_i(id, "__team_id_target", 2)
    ia_ment_new_var_i(id, "health", 10, 60.0)
    ia_ment_new_var_i(id, "damage", 0, 3600.0)
    -- ia_ment_new_static_var_i("xp_override", 50)
    ia_ment_new_static_var_f(id, "xp_mod", 3) --High.
    ia_ment_new_static_var_f(id, "dps", 50.0)
    ia_ment_new_static_var_s(id, "sound_death", "die_gremlin")
    ia_ment_new_static_var_b(id, "identifies", false)
    ia_ment_new_static_var_s(id, "identity_str", "Minor Gremlin")
    ia_ment_new_static_var_b(id, "shoots", true)
    ia_ment_new_static_var_f(id, "shoot_period", 1.2)
    ia_ment_new_static_var_b(id, "shoot_period_lvlinv", false)
    ia_ment_new_static_var_f(id, "shoot_radius", 1000.0)
    ia_ment_new_static_var_b(id, "shoot_only_different_level", false)
    ia_ment_new_static_var_s(id, "shoot_proj_type", "ment_monster_gremlin_proj")
    ia_ment_new_static_var_f(id, "shoot_proj_speed", 8.0)
    ia_ment_new_static_var_f(id, "shoot_proj_ttl", 1.5)
    ia_ment_new_static_var_i(id, "shoot_proj_damage", 60)
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
