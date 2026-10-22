-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_f(id, "__ttl", 10.0)
    ia_ment_set_builtin_var_f(id, "__radius", 0.2)
    ia_ment_set_builtin_var_s(id, "__mesh", "homing")
    ia_ment_set_builtin_var_b(id, "__homing", true)
    --
    ia_ment_new_var_i(id, "damage2", 1, 60.0)
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

function p.__on_ment_hit(
    source_inst_id,
    target_inst_id,
    level, lp, normal)
--
    local args = {}
    args.source_inst_id = source_inst_id
    args.target_inst_id = target_inst_id
    args.level = level
    args.lp = lp
    args.normal = normal
    --
    local ret = game_ment_hit.process_hit_and_got_hit(args)

    --Could play a sound.

    if( game_ment_homing_nerf.lock(target_inst_id) ) then
        --Dealing custom damage.
        local damage2 = ga_ment_get_i(source_inst_id, "damage2")
        game_ment_health.take_damage(target_inst_id, damage2)
    else
        --The damage2 was nerfed.
        --Only damage was applied (which should be 1), not damage2.
    end

    return ret.terminal_hit
end
