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
    local adj_bp = std.get_adj_bp(bp, normal_side)

    local bt = ""

    if normal_side == 0 then
        bt = "block_ladder_x_neg"
    end
    if normal_side == 1 then
        bt = "block_ladder_x_pos"
    end
    if normal_side == 2 then
        bt = "block_ladder_y_neg"
    end
    if normal_side == 3 then
        bt = "block_ladder_y_pos"
    end

    --Adding the block.
    if bt ~= "" then
        ga_block_change_rl(level, adj_bp, bt, 1000 * 60 * 60.0) --One thousand hours.
    end

    return true
end
