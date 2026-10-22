--Helper function.
function p.price_helper(price)
    local num = 10
    if (price == 1) then num = 100 end
    if (price == 2) then num = 50 end
    return num
end

function p.__render(wid)
    ga_win_set_background_default(wid)

    ga_win_txt_center(wid, 0.7, "PRESS ENTER TO PAY 1000 GOLD")
    ga_win_txt_center(wid, 0.6, "SO THAT NOW MARKERS THAT YOU USE")
    ga_win_txt_center(wid, 0.5, "(THAT HAVE NOT BEEN BOUGHT AT A STORE)")
    ga_win_txt_center(wid, 0.4, "THAT WOULD COST 10 NOW INSTEAD COST 5 GOLD")

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.12, "Go Back (ESC or F)")
end

function p.__process_input(wid)
    if( ga_win_key_pressed(wid, "ESC") or
        ga_win_key_pressed(wid, "F") or
        ga_win_mouse_pressed(wid, true) )
    then
        ga_play_sound("menu_back")
        ga_window_pop()
    end

    if game_key.pressed_or_spammed(wid, "ENTER") then
        local cost = 1000
        local gold = ga_get_i("xar.player.gold.amount")
        if( gold < cost ) then
            ga_play_sound_menu("error")
        else
            ga_set_i_by_delta("xar.player.gold.amount", -cost)
            game_drop_markers.enabled_cheap_common_markers()
            ga_window_pop()
        end

    end
end
