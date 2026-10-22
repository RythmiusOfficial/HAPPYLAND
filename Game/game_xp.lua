function p.get_max_level()
    return 500
end

function p.get_to_next_level_max(level)
    local step = ga_get_i("xar.experience.level_step")
    return step * level
end

function p.cap_max_level()
    local level = ga_get_i("xar.experience.level")
    local max_level = p.get_max_level()
    if( level >= max_level ) then
        level = max_level
        ga_set_i("xar.experience.level", level)
        --
        local to_next_level_max = p.get_to_next_level_max(level)
        ga_set_i("xar.experience.to_next_level_max",    to_next_level_max)
        ga_set_i("xar.experience.to_next_level",        to_next_level_max)
    end
end

--Returns true if can no longer level up
--or get experiecnce (because the player is at their
--max level)
function p.is_done()
    local old_level = ga_get_i("xar.experience.level")
    local max_level = p.get_max_level()
    p.cap_max_level()
    old_level = ga_get_i("xar.experience.level")
    if old_level >= max_level then
        return true
    end
    return false
end

function p.level_up_loop()
    while ga_get_i("xar.experience.to_next_level") <= 0 do
        p.level_up()
    end
end

function p.level_up()
    if p.is_done() then return end

    local old_level = ga_get_i("xar.experience.level")
    local next_level = old_level + 1
    game_msg.add("You just leveled up to level " .. tostring(next_level) .. "!")

    --Playing the level up sound.
    ga_play_sound("level_up")

    --Dealing with xp.
    std.set_bydelta_i("xar.experience.level", 1)
    local step = ga_get_i("xar.experience.level_step")
    local max = step * next_level
    --ga_set_i("xar.experience.to_next_level", max)
    std.set_bydelta_i("xar.experience.to_next_level", max)
    ga_set_i("xar.experience.to_next_level_max", max)

    -- local up_delta = bicent --Too much.
    local up_delta = 1
    if( ga_get_b("xar.difficulty.easy_2") ) then
        up_delta = up_delta * 2
    end

    --Adding damage upgrades.
    std.set_bydelta_i("xar.player.gun1.damage_level", up_delta)
    for wep = 2,9 do
        if game_can_use.main(wep) then
            std.set_bydelta_i("xar.player.gun" .. tostring(wep) .. ".damage_level", up_delta)
        end
    end
    if game_can_use.main(0) then
        std.set_bydelta_i("xar.player.gun" .. tostring(0) .. ".damage_level", up_delta)
    end
    --Adding health upgrades.
    std.set_bydelta_i("xar.player.health.level", up_delta)
    std.set_bydelta_i("xar.player.health.regen_level", up_delta)
end

--Something odd is that the player can only level up
--when when they get experience via "game_xp.add".
--That is, forcibly increasing xar.experience.total
--will not cause the player to level up.
--I might want to change this.

function p.add(raw, allow_powerup)
    if p.is_done() then return end

    local num = raw

    --XP factor.
    if allow_powerup then
        local xp_time = ga_get_f("xar.xp_5x_stacking_time")
        if xp_time > 0.0 then num = num * 5 end
    end
    --
    if ga_get_b("xar.difficulty.easy_2") then num = num * 2 end

    std.set_bydelta_i("xar.experience.this_second", num)

    std.set_bydelta_i("xar.experience.total", num)
    std.set_bydelta_i("xar.experience.to_next_level", -num)

    --This could be called elsewhere as well.
    p.level_up_loop()
end

--Should be called within the on_die function of an ment.
function p.ment_add(inst_id)
    local ment_type = ga_ment_get_type(inst_id)

    local xp = 0
    local allow_powerup = true
    if ga_ment_type_var_exists(ment_type, "xp_override") then
        --MAYBE NOT HAVE ANY OVERRIDES!!!
        xp = ga_ment_get_static_i(ment_type, "xp_override")
    else
        if( ga_ment_var_exists(inst_id, "dps") ) then
            local dps = ga_ment_get_f(inst_id, "dps")
            local hp = game_ment_health.get_ment_max_health(inst_id)

            if (hp < 1.0 or dps < 1.0) then
                xp = 1
            else
                local a = math.log10(hp)
                local b = 1 + math.log(dps)
                --raw = a * a * b * b
                local raw = math.pow(a,2.5) * math.pow(b,2.5)
                xp = math.floor(raw)
                if( xp < 1.0 ) then xp = 1 end
            end
        end
    end
    if ga_ment_type_var_exists(ment_type, "xp_mod") then
        local mod_factor = ga_ment_get_f(inst_id, "xp_mod")
        if( mod_factor ~= 1 ) then allow_powerup = false end
        xp = xp * mod_factor
    end
    if ga_ment_type_var_exists(ment_type, "xp_only_different_level") then
        if ga_ment_get_b(inst_id, "xp_only_different_level") then
            local ment_level = ga_ment_get_level(inst_id)
            local player_level = ga_get_viewer_level()
            if( ment_level == player_level ) then
                xp = 0
            end
        end
    end
    --
    p.add(xp, allow_powerup)
end
