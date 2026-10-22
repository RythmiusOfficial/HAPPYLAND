function p.play_hurt_sound(num)
    local str = "player_hurt_" .. tostring(num)

    local global_hurt_var = "sound.player_hurt_sounds_enabled"
    ga_package_init_b(global_hurt_var, true)
    local sound_enabled = ga_package_get_b(global_hurt_var)

    if not sound_enabled then return end
    if not p.slot_free(num) then return end
    ga_play_sound(str)
end

function p.init_cooldown_vars()
    for i = 1,7 do
    for j = 1,2 do
        local var =
            "temp.hurt_sound_cooldown_" ..
            tostring(i) ..
            "_" ..
            tostring(j)
        ga_init_f(var, 0.0)
    end end
end

--Once we use a slot to play a player hurt sound,
--it cannot be used again for another minute.
function p.slot_free(num)
    for j = 1,2 do
        local var =
            "temp.hurt_sound_cooldown_" ..
            tostring(num) ..
            "_" ..
            tostring(j)
        local old_value = ga_get_f(var)
        if( old_value <= 0.0 ) then
            --Slot is free.
            ga_set_f(var, 60.0) --One minute cool down.
            return true
        end
    end
    return false
end

function p.update()
    local cur_time = ga_get_sys_f("game.time.total")
    local last_update_time = ga_get_f("xar.hurt_sound.last_time")

    --Updating cooldown vars.
    local elapsed_time = ga_get_sys_f("time.elapsed")
    p.init_cooldown_vars()
    for i = 1,7 do
    for j = 1,2 do
        local var =
            "temp.hurt_sound_cooldown_" ..
            tostring(i) ..
            "_" ..
            tostring(j)
        local old_value = ga_get_f(var)
        local new_value = old_value
        if( old_value >= 0.0 ) then
            new_value = old_value - elapsed_time
        end
        ga_set_f(var, new_value)
    end end

    --Added Jan 2022.
    --Adding a saftey here in case for some reason
    --the last hurt sound time is far in the future.
    if( last_update_time > cur_time + 1.0 ) then
        last_update_time = cur_time
        ga_set_f("xar.hurt_sound.last_time", cur_time)
    end

    -- local sound_period = 1.0
    local sound_period = 3.0

    --Sort of a hack.
    if cur_time > last_update_time + sound_period*2 then
        ga_set_f("xar.hurt_sound.last_time", cur_time)
        return
    end

    --Executing once every sound_period seconds.
    if cur_time > last_update_time + sound_period then
        --Playing a sound.
        local damage = ga_get_i("xar.hurt_sound.damage")
        local max_health = ga_get_i("xar.player.health.max")
        local frac = damage / max_health
        if frac < 0.001 then
            --No sound.
        elseif frac < 0.01 then
            p.play_hurt_sound(1)
        elseif frac < 0.02 then
            p.play_hurt_sound(2)
        elseif frac < 0.05 then
            p.play_hurt_sound(3)
        elseif frac < 0.25 then
        --elseif frac < 0.15 then
            p.play_hurt_sound(4)
        elseif frac < 0.75 then
            p.play_hurt_sound(5)
        elseif frac < 1.5 then
            p.play_hurt_sound(6) --Annoying sounding.
        else
            p.play_hurt_sound(7) --Annoying sounding.
        end

        --Getting ready for next cycle.
        ga_set_f("xar.hurt_sound.last_time", last_update_time + sound_period)
        ga_set_i("xar.hurt_sound.damage", 0)
    end
end
