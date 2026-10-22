--This moving entity is special.
--It is automatically moved by the engine to be where the player is.
--The main package should define their own player_hit_sphere entity.

-------------------------------------------------
--              Damage AND Health
-------------------------------------------------

--Is this replaced by _team_id_source and target???
function p.get_getting_hit_type() return "player" end
function p.get_hitting_type() return "" end

-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    ia_ment_set_builtin_var_b(id, "__disable_saving", true)
    ia_ment_set_builtin_var_f(id, "__ttl", -1.0)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 1234567) --Ok?
    ia_ment_set_builtin_var_i(id, "__extra_max_levels", 1234567) --Ok?
    ia_ment_set_builtin_var_f(id, "__radius", 1.0)
    ia_ment_set_builtin_var_b(id, "__radius_lvlinv", true) --unusual.
    ia_ment_set_builtin_var_s(id, "__mesh", "")
    ia_ment_set_builtin_var_b(id, "__solid_wrt_player", false)
    ia_ment_set_builtin_var_b(id, "__collides", false)
    ia_ment_set_builtin_var_i(id, "__team_id_source", 0)
    ia_ment_set_builtin_var_i(id, "__team_id_target", 1)
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.xar_process_got_hit(args, exceptions)
    -- ga_print("here insisde player_hit_sphere.xar_process_got_hit")
    local source_type_name = ga_ment_get_type(args.source_inst_id)
    --So no damage will be dealt,
    --but it will compute how much damage WOULD be dealt
    --and it returns that in the damage_dealt var of ret.
    exceptions.no_blood = true
    exceptions.no_damage = true
    exceptions.compute_damage = true
    local ret = game_ment_hit.process_final(args, exceptions)
    --
    if( ret.damage_dealt > 0 ) then
        local raw = false
        local vel = ga_ment_get_v(args.source_inst_id, "__vel")
        local neg_vel = std.vec_scale(vel, -1.0)
        if( ret.display_hit_to_hud ) then
            game_top2.damage_player_from_dir(raw, ret.damage_dealt, neg_vel)
        else
            game_top2.damage_player(raw, ret.damage_dealt)
        end
    end
    return ret
end
