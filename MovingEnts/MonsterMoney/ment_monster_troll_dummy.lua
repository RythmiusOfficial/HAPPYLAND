--File: ment_monster_troll_dummy.lua

--This is supposed to be fast to render.

-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    ia_ment_set_builtin_var_f(id, "__radius", 5.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterTroll")
    ia_ment_new_static_var_s(id, "identity_str", "Dummy Troll")
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------
--Nothing.
