--This file describes the various "get_" functions.

-------------------------------------------------
--       Rendering, Geometry, and Motion
-------------------------------------------------

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
    local adj_bp = std.get_adj_bp(bp, normal_side)
    -- local adj_bt = ga_block_get(level, bp)

    --Whether or not we can build a block
    --where the player is standing.    
    --This init function will create it and set it to true
    --if it does not already exist.  Otherwise it will
    -- not change its value.
    --
    local var = "inf2.can_build_block_into_player"
    ga_package_init_b(var, true)
    local glitch_on = ga_package_get_b(var)
    --
    -- local glitch_on = true --Forcing the glitch on.
    --
    if(not glitch_on and
       not game_inf2.can_build_block(level, adj_bp))
    then
        return true --It is a "terminal" hit.
    end

    local bt = ga_get_s("xar.cheat.inf2.primary_bt")
    local exists = ga_bt_exists(bt)
    if( not exists ) then bt = "XAR_SOLID_BORING" end --Uh oh!
    --The bt must start with "XAR_".
    
    --Adding the block.
    ga_print("About to call ga_block_change_rl with bt = " .. bt)
    ga_block_change_rl(level, adj_bp, bt, 1000 * 60 * 60.0) --One thousand hours.

    return true --It is a "terminal" hit.
end
