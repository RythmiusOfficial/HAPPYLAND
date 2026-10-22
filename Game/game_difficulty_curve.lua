function p.curve_enemy_health(uncurved_health)
    if( ga_get_b("xar.difficulty.curve.enabled") ) then
        local power = 0.75
        local curved = math.floor( uncurved_health ^ power )
        if( curved < 1 ) then curved = 1 end
        return curved
    else
        return math.floor( uncurved_health )
    end
end

function p.curve_player_damage(uncurved_damage)
    if( ga_get_b("xar.difficulty.curve.enabled") ) then
        local power = 0.5
        local curved = math.floor( uncurved_damage ^ power )
        if( curved < 1 ) then curved = 1 end
        return curved
    else
        return math.floor( uncurved_damage )
    end
end

function p.curve_player_damage2(lev, factor)
    if( ga_get_b("xar.difficulty.curve.enabled") ) then
        local power = 0.5
        local curved_lev = lev ^ power
        local curved = math.floor( curved_lev * factor )
        if( curved < 1 ) then curved = 1 end
        return curved
    else
        return math.floor( lev * factor )
    end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

function p.curve_player_health(uncurved_health)
    if( ga_get_b("xar.difficulty.curve.enabled") ) then
        local scale = 10.0
        local power = 0.5
        local curved = math.floor( scale * (uncurved_health ^ power) )
        if( curved < 1 ) then curved = 1 end
        return curved
    else
        return uncurved_health
    end
end

--Returns a float.
--Also curves extra health regen this way.
function p.curve_player_shield_regen(uncurved_shield_per_sec)
    if( ga_get_b("xar.difficulty.curve.enabled") ) then
        if( uncurved_shield_per_sec < 1.0 ) then
            return uncurved_shield_per_sec
        end
        local scale = 2.0
        local power = 0.5
        local curved = scale * (uncurved_shield_per_sec ^ power)
        -- if( curved < 1 ) then curved = 1 end
        return curved
    else
        return uncurved_shield_per_sec
    end
end

function p.curve_player_extra_shield_regen(uncurved_health_per_sec)
    if( ga_get_b("xar.difficulty.curve.enabled") ) then
        if( uncurved_health_per_sec < 1.0 ) then
            return uncurved_health_per_sec
        end
        local scale = 2.0
        local power = 0.5
        local curved = scale * (uncurved_health_per_sec ^ power)
        return curved
    else
        return uncurved_health_per_sec
    end
end

function p.curve_player_extra_armor_regen(uncurved_armor_per_sec)
    if( ga_get_b("xar.difficulty.curve.enabled") ) then
        local scale = 2.0
        local power = 0.5
        local curved = scale * (uncurved_armor_per_sec ^ power)
        if( curved > uncurved_armor_per_sec ) then return uncurved_armor_per_sec end
        return curved
    else
        return uncurved_armor_per_sec
    end
end

--Curving damage from all enemies to the player.
function p.curve_enemy_damage(uncurved_damage)
    if( uncurved_damage < 1.0 ) then return 0.0 end
    if( ga_get_b("xar.difficulty.curve.enabled") ) then
        local scale = 10.0
        local power = 0.5
        local curved = math.floor( scale * (uncurved_damage ^ power) )
        if( curved < 1 ) then curved = 1 end
        return curved
    else
        return uncurved_damage
    end
end
