--Should be called when the given ment
--shots a projectile that successfully
--hits the player.
function p.reg_hit(inst_id)
    --Saftey check.
    if not ga_ment_var_exists(inst_id, "individual_delay_last_time") then return end
    if not ga_ment_var_exists(inst_id, "individual_delay_total_time") then return end
    --
    local last_time = ga_ment_get_f(inst_id, "individual_delay_last_time")
    local total_time = ga_ment_get_f(inst_id, "individual_delay_total_time")
    local cur_time = ga_get_game_time()
    local since_last_hit = cur_time - last_time
    --
    --Getting ready for next time:
    ga_ment_set_f(inst_id, "individual_delay_last_time", cur_time)
    --
    if( since_last_hit > 3.0 or
        total_time < -0.1 )
    then
        --Resetting the counter.
        ga_ment_set_f(inst_id, "individual_delay_total_time", 0.0)
        return false --Warning shot.
    end
    --
    --Advancing the total time.
    local new_total_time = total_time + since_last_hit
    ga_ment_set_f(inst_id, "individual_delay_total_time", new_total_time)
    --
    if( new_total_time < 2.0 ) then
        return false --Warning shot.
    end
    return true --Not a warning shot.
end
