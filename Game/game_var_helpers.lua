--The brute force approach:
--Updating variables that depend on other variables every frame.
--A fancier way to do this would be with callbacks that get called
--when a variable changes. 
function p.set_dep_vars()
    ---------------------------------------------
    --          Shield / Health / Armor
    ---------------------------------------------
    local lev = ga_get_i("xar.player.health.level")
    local health_max_uncurved = 100 + lev*4
    local health_max = game_difficulty_curve.curve_player_health(health_max_uncurved)
    local shield_max = math.floor(health_max/4)
    ga_set_i("xar.player.shield.max", shield_max)
    ga_set_i("xar.player.health.max", health_max)
    ga_set_i("xar.player.armor.max", health_max)
    ga_set_sys_i("game.player.health_max", health_max) --A system var!

    --Capping shield, health, and armor.
    local shield = ga_get_i("xar.player.shield.amount")
    if( shield > shield_max ) then ga_set_i("xar.player.shield.amount", shield_max) end
    local health = ga_get_i("xar.player.health.amount")
    if( health > health_max*5 ) then ga_set_i("xar.player.health.amount", health_max*5) end
    local armor = ga_get_i("xar.player.armor.amount")
    if( armor > health_max*10 ) then ga_set_i("xar.player.armor.amount", health_max*10) end

    local lev = ga_get_i("xar.player.health.regen_level")
    local health_per_sec_uncurved = (0.5 + (0.5 / 4.0) * lev)
    local shield_per_sec_uncurved = 2.0 * health_per_sec_uncurved
    local shield_per_sec_curved =
        game_difficulty_curve.curve_player_shield_regen(shield_per_sec_uncurved)
    local health_per_sec_curved = 0.5 * shield_per_sec_curved
    local health_regen_curved = 1.0 / health_per_sec_curved
    ga_set_f("xar.player.health.regen", health_regen_curved)
        -- 1.0 / (0.5 + (0.5 / 4.0) * lev) )

    local lev = ga_get_i("xar.player.health.extra_regen_level")
    if (lev == 0) then
        ga_set_f("xar.player.health.extra_regen", -1.0)
    else
        local extra_health_per_sec_uncurved = (0.125 * lev)
        --Same curving for shield as extra health.
        local extra_health_per_sec_curved =
            game_difficulty_curve.curve_player_extra_shield_regen(extra_health_per_sec_uncurved)
        local extra_health_regen_curved = 1.0 / extra_health_per_sec_curved
        ga_set_f("xar.player.health.extra_regen", extra_health_regen_curved)
    end

    local lev = ga_get_i("xar.player.armor.regen_level")
    if (lev == 0) then
        ga_set_f("xar.player.armor.regen", -1.0)
    else
        local extra_armor_per_sec_uncurved = lev
        local extra_armor_per_sec_curved =
            game_difficulty_curve.curve_player_extra_armor_regen(extra_armor_per_sec_uncurved)
        local extra_armor_regen_curved = 1.0 / extra_armor_per_sec_curved
         ga_set_f("xar.player.armor.regen", extra_armor_regen_curved)
    end

    ---------------------------------------------
    --          Capping the player's XP level
    ---------------------------------------------
    game_xp.cap_max_level()
end
