function p.can_use_wep(wep)
    if( ga_get_b("xar.cheat.inf2.enabled") ) then return true end

    if wep == 1 then return true end

    if wep >= 1 and wep <= 9 then
        local ammo_var = "xar.player.gun" .. tostring(wep) .. ".ammo"
        local ammo = ga_get_i(ammo_var)
        return (ammo > 0)
    end

    if wep == 0 then
        local up1 = ga_get_i("xar.player.gun0.ammo_level")
        local up2 = ga_get_i("xar.player.gun0.speed_level")
        local up3 = ga_get_i("xar.player.gun0.damage_level")
        return (up1 + up2 + up3 > 0)
    end

    return false
end

function p.next_useable_wep(wep)
    local cur = wep
    while true do
        cur = cur + 1
        if (cur >= 10) then cur = 0 end
        if p.can_use_wep(cur) then return cur end
    end
end

function p.prev_useable_wep(wep)
    local cur = wep
    while true do
        cur = cur - 1
        if (cur < 0) then cur = 9 end
        if p.can_use_wep(cur) then return cur end
    end
end
