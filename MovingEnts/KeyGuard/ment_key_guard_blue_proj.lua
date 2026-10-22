-------------------------------------------------
--            Type Init Function
-------------------------------------------------

--SPECIAL: Only does damage if player does not have key!!!
function p.__type_init(id)
    game_ment_type_init.monster_proj(id) --Ok.
    ia_ment_set_builtin_var_f(id, "__radius", 0.001)
    ia_ment_set_builtin_var_s(id, "__mesh", "dummy")
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
    local exceptions = {}
    if( ga_get_f("xar.key_time.blue") > 0 ) then
        ga_ment_set_i(args.source_inst_id, "damage", 0)
    end
    local ret = game_ment_hit.process_got_hit(args, exceptions)
    return ret
end
