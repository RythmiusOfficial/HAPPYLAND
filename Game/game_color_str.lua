function p.dec_to_hex(dec)
    dec = math.floor(dec)
    if dec < 0 then dec = 0 end
    if dec > 255 then dec = 255 end
    local hex = string.format("%x", dec)
    if( string.len(hex) == 2 ) then return hex end
    if( string.len(hex) == 1 ) then return "0" .. hex end
    return "ERROR"
end

function p.color_vec_to_esc(c)
    local red_hex = p.dec_to_hex(c.x * 255)
    local green_hex = p.dec_to_hex(c.y * 255)
    local blue_hex = p.dec_to_hex(c.z * 255)
    return "^x" .. red_hex .. green_hex .. blue_hex
end
