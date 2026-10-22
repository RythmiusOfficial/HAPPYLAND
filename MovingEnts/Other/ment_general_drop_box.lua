-------------------------------------------------
--           Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.monster_drop(id)
    ia_ment_set_builtin_var_f(id, "__radius", 2.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "Drop")
    ia_ment_set_builtin_var_b(id, "__solid_wrt_player", false) --To prevent fertile radius = 1 bug.
    ia_ment_new_var_s(id, "identity_str", "Drop Box", 60.0 * 60.0)
    --
    ia_ment_new_var_s(id, "drop_bent", "NOT_SET", 60.0 * 60.0)
    ia_ment_new_var_i(id, "drop_bent_param_i", 0, 60.0 * 60.0)
    ia_ment_new_var_s(id, "drop_bent_param_s", "", 60.0 * 60.0)
    ia_ment_new_var_i(id, "drop_extra_levels", 0, 60.0 * 60.0)
   -- ia_ment_new_var_s(id, "drop_txt") --MAYBE JUST HAVE IDENTITY STRING!!!
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

--CHANGE THE ARGS!!!
function p.__on_too_fine(
    inst_id,
    fine_chunk_id,
    fine_offset)
--
    fine_offset = std.vec(
        fine_offset.x,
        fine_offset.x,
        fine_offset.x)

    local level = ga_chunk_id_to_level(fine_chunk_id)
    local vcp = ga_chunk_id_to_vcp(fine_chunk_id)
    local lp = std.local_to_level_pos(vcp, fine_offset)

    local drop_bent = ga_ment_get_s(inst_id, "drop_bent")
    local drop_bent_param_i = ga_ment_get_i(inst_id, "drop_bent_param_i")
    local drop_bent_param_s = ga_ment_get_s(inst_id, "drop_bent_param_s")
    local drop_extra_levels = ga_ment_get_i(inst_id, "drop_extra_levels") - 1
    if( drop_extra_levels < 0 ) then drop_extra_levels = 0 end
    local drop_box_allow = true
    local drop_box_txt = ga_ment_get_s(inst_id, "identity_str")
    local fireworks = true

    ga_print("general_drop_box.__on_too_fine drop_bent = " .. drop_bent)

    game_ment_drop.drop_general(
        level, lp,
        drop_bent,
        drop_bent_param_i,
        drop_bent_param_s,
        drop_extra_levels,
        drop_box_allow,
        drop_box_txt,
        fireworks)
end
