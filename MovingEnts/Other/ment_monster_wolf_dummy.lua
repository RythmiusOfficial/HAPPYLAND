--File: ment_monster_world_dummy.lua

--This is supposed to be fast to render.

-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    ia_ment_set_builtin_var_f(id, "__radius", 2.0)
    ia_ment_set_builtin_var_s(id, "__mesh", "MonsterWolf")
    ia_ment_new_static_var_s(id, "identity_str", "Dummy Infinity Wolf")
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------
--Nothing.
