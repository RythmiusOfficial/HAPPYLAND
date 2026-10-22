function p.__on_touch()
    if( ga_get_f("xar.key_time.yellow") > 0 ) then
        --The player has the key.
        return
    end
    --The player does not have the key.
    ga_kill_player()
end
