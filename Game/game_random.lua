--Look should be a vector of length 1
--(pointing where the player is looking).
--This function will return a vector that is
--at most "spread" away from the look vector.
function p.rand_weapon_spread(look, spread)
    local dir = {}
    dir.x = look.x + (ga_randf() - 0.5) * spread
    dir.y = look.y + (ga_randf() - 0.5) * spread
    dir.z = look.z + (ga_randf() - 0.5) * spread
    return dir
end
