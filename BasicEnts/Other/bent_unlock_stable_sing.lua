function p.get_area_name(level, bp)
    return ga_bent_get_param_s(level, bp)
end

function p.get_var_name(level, bp)
    local area_name = p.get_area_name(level, bp)
    return "xar.door_unlocked." .. area_name 
end

function p.get_door_unlocked(level, bp)
    local var = p.get_var_name(level, bp)
    if not ga_exists(var) then return false end --Uh oh!
    return ga_get_b(var)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    if p.get_door_unlocked(level, bp) then
        return "^xffff00Door Already Unlocked in Stable Singletons Room"
    else
        return "^x00ff00Unlock Door in Stable Singletons Room"
    end
end

function p.__on_use(level, bp)
    ga_create_s("temp.xar.ent.unlock_stable_sing.area")
    ga_set_s("temp.xar.ent.unlock_stable_sing.area",
        p.get_area_name(level, bp))
    --
    local already_unlocked = p.get_door_unlocked(level,bp)
    ga_create_b("temp.xar.ent.unlock_stable_sing.already_unlocked")
    ga_set_b("temp.xar.ent.unlock_stable_sing.already_unlocked",
        already_unlocked)
    --
    --Actually unlocking.
    if not already_unlocked then
        ga_play_sound_menu("harp")
        local var = p.get_var_name(level, bp)
        ga_set_b(var, true) --The door is now unlocked.
    else
        ga_play_sound_menu("use")
    end
    --
    ga_window_push("win_unlock_stable_sing")
end
