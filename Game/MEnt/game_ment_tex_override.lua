--Should be called
--1) after EMP effect ends on an ment, or
--2) after freeze effect ends on an ment, or
--3) after poison effect ends on an ment.
function p.refresh(inst_id)
    local tex_override = ""
    if( ga_ment_get_b(inst_id, "emp_stunned") ) then tex_override = "emp" end
    if( ga_ment_get_b(inst_id, "poisoned") ) then tex_override = "ment_poison" end
    if( ga_ment_get_b(inst_id, "frozen") ) then tex_override = "ice" end
    --
    ga_ment_set_s(inst_id, "__tex_override", tex_override)
end
