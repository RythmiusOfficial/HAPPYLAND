-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    ia_ment_set_builtin_var_f(id, "__radius", 0.001)
    ia_ment_set_builtin_var_s(id, "__mesh", "dummy")
    game_ment_type_init.monster_proj(id) --Ok.
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
    return ret.terminal_hit
end

function p.xar_process_hit(args)
    --Is this needed?
    local exceptions = {}
    exceptions.no_damage = true
    local ret = game_ment_hit.process_got_hit(args, exceptions)
    --
    local target_type = ga_ment_get_type(args.target_inst_id)
    if( target_type == "player_hit_sphere" ) then
        game_remove_ammo.remove_ammo()
    end
    return ret
end
