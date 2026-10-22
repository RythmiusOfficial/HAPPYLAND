function p.__on_touch()
    local var = "xar.difficulty.speedrun_start"
    local start_time = ga_get_f(var)
    if( start_time > 0 ) then return end
    --Initializing the start time.
    start_time = ga_get_game_time()
    ga_set_f(var, start_time)
end
