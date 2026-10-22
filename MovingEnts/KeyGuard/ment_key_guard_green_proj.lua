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
    -- ga_print("here inside key_guard_kellow_proj.__on_ment_hit")
    -- ga_exit()

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
    -- ga_print("key_guard_green_proj.xar_process_hit")
    local player_combo = ga_get_s("xar.key_time.green_combo") --CHECK THIS!!!
    -- ga_print("source_inst_id = " .. tostring(args.source_inst_id))
    -- ga_print("source type = " .. tostring(ga_ment_get_type(args.source_inst_id)))
    local parent_inst_id = ga_ment_get_i(args.source_inst_id, "parent_inst_id")
    -- ga_print("paren_inst_id = " .. tostring(parent_inst_id))
    local ment_combo = ga_ment_get_s(parent_inst_id, "key_combo")
    ga_print("past the tricky part.  Key combo = " .. tostring(ment_combo))
    local exceptions = {}
    if( ga_get_f("xar.key_time.green") > 0 and
        player_combo == ment_combo )
    then
        ga_ment_set_i(args.source_inst_id, "damage", 0)
    end
    local ret = game_ment_hit.process_got_hit(args, exceptions)
    return ret
end
