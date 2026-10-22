function p.__on_touch()
    local locked_in = ga_get_b("xar.difficulty.locked_in")
    if( locked_in ) then return end
    --
    ga_set_b("xar.difficulty.locked_in", true)
    game_msg.add("From now on, the easiest used difficulty...")
    game_msg.add("will be recorded (press F5) ")
    ga_play_sound("harp")
end
