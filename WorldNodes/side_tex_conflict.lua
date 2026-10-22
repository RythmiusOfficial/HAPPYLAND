--Returns true iff the inv side takes precedence.
function p.__resolve(
    bt1, --solid type
    tex1,
    bt2, --empty type
    tex2,
    side)

    --Could make this more complex.    
    return true
end

--Note: tex1 and tex2 are determined from
--bt1, bt2, and side.
--Thus, the results of this function are
--cached using those three values as the keys.
