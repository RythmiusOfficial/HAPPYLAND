function p.plasma()
    --Nothing to do.
end

function p.payload(wep)
    if game_can_use.main(wep) then return end

    local prefix = "xar.player.gun" .. tostring(wep) .. "."
    --Getting full ammo.
    local ammo_max = game_wep_modes.get_ammo_max(wep)
    ga_set_i(prefix .. "ammo", ammo_max)

    --Getting level upgrades.
    --(Close enough).
    local start_level = ga_get_i("xar.experience.level")
    if( ga_get_b("xar.difficulty.easy_2") ) then
        start_level = start_level * 2
    end
    std.set_bydelta_i(prefix .. "damage_level", start_level)
end

function p.cannon()
    p.payload(2)
end

function p.laser()
    p.payload(3)
end

function p.rocket()
    p.payload(4)
end

function p.homing()
    p.payload(5)
end

function p.minigun()
    p.payload(6)
end

function p.railgun()
    p.payload(7)
end

function p.emp()
    p.payload(8)
end

function p.nuke()
    p.payload(9)
end

function p.dark_hole()
    p.payload(0)
end
