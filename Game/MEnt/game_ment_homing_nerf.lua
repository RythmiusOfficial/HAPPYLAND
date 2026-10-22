function p.num_slots()
    return 5
end

function p.get_var_name(i)
    return "homing_nerf_slot_" .. tostring(i)
end

--In seconds.
--It takes this many seconds to unlock a slot.
function p.cooldown_len()
    return 4.0
end

--Monsters need these extra variables in order to implement the nerf.
--Note: The revert time is one minute.
--The variables will be called things like
--homing_nerf_slot_1,
--homing_nerf_slot_2,
--etc.
function p.ment_monster_type_init_helper(id)
    local num_slots = p.num_slots()
    for i = 1,num_slots  do
        local var = p.get_var_name(i)
        ia_ment_new_var_f(id, var, -1, 60.0)
    end
end

--Will return true if could get a lock
--and false otherwise.
function p.lock(target_inst_id)
    local num_slots = p.num_slots()
    local game_time = ga_get_game_time()
    local wait_len = p.cooldown_len()
    for i = 1,num_slots do
        local var = p.get_var_name(i)
        if( not ga_ment_var_exists(target_inst_id, var) )
            --This could happen.
            then return false
        end
        local slot_time = ga_ment_get_f(target_inst_id, var)
        if( game_time > slot_time + 0.01 ) then
            --The slot is free.
            --Locking it.
            ga_ment_set_f(target_inst_id, var, game_time + wait_len)
            return true --Lock successful.
        end
    end
    return false --Could not lock.
end
