--This file describes the various "get_" functions.

-------------------------------------------------
--       Rendering, Geometry, and Motion
-------------------------------------------------

function p.get_radius() return 0.1 end
function p.get_collides() return true end
function p.get_solid_wrt_player() return false end

-------------------------------------------------
--              Damage AND Health
-------------------------------------------------

function p.get_getting_hit_type() return "" end
function p.get_hitting_type() return "" end

function p.get_health() return 10 end

-------------------------------------------------
--                   Shooting
-------------------------------------------------

function p.get_shoots() return false end

-------------------------------------------------
--                   Sound
-------------------------------------------------

-------------------------------------------------
--              Identity String
-------------------------------------------------

-- If not defined, then false.
function p.get_identifies() return false end

-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    ia_ment_set_builtin_var_f(id, "__ttl", 60.0)
    ia_ment_set_builtin_var_f(id, "__radius", 0.1)
    ia_ment_set_builtin_var_s(id, "__mesh", "sphere_pink")
end

-------------------------------------------------
--         Movement Hitting Callbacks
-------------------------------------------------

function p.__on_block_hit(
    inst_id,
    level, bp, lp,
    normal_side, normal)
--
    local bt = ga_get_s("xar.cheat.inf2.secondary_bt")
    local exists = ga_bt_exists(bt)
    if( not exists ) then bt = "XAR_EMPTY_BORING" end --Uh oh!
    --The bt must start with "XAR_".

    -- ga_print("In block_gun_remove.__on_block_hit")
    -- ga_print("bt=" .. bt)

    --Removing the block.
    ga_block_change_rl(level, bp, bt, 1000 * 60 * 60.0) --One thousand hours.

    return true
end
