function p.alarm(inst_id)
    if( ga_ment_get_i(inst_id, "__death_anim_stage") == 2) then
        ga_ment_remove(inst_id)
    else
        --Doing it again.
        local game_time = ga_get_game_time()
        local alarm_time = game_time + 0.1
        local alarm_name = "death_anim"
        ga_ment_set_alarm(inst_id, alarm_time, alarm_name)
    end
end
