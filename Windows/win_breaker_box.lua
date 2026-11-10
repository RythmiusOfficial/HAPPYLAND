local main_button_handle = 1

function p.__start(wid)
    -- nothing here
end


function p.__render(wid)
    ga_win_set_background_default(wid)
    ga_win_txt_center(wid, 0.9, "DEACTIVATE 10% OF APARTMENT KEY GUARDS")

    local keymax = ga_get_i("worldgen.state.tga")
    local keyguard_amt = keymax*10

    ga_win_txt_center(wid, 0.8, "CURRENTLY DEACTIVATING " .. tostring(keyguard_amt) .. "% OF APT. KEY GUARDS")
    
    if keymax < 10 then
        local txt = "PRESS ENTER: PAY 2000 GOLD TO BEGIN DEACTIVATION"
        ga_win_widget_button_start(wid, main_button_handle, 0.0, 0.5, 0.02, 0.04, txt)
        ga_win_widget_button_center_x_at(wid, main_button_handle, 0.5)
    else
        local txt = "^xff0000YOU ARE AT MAX DEACTIVATION POWER^!"
        ga_win_widget_button_start(wid, main_button_handle, 0.0, 0.5, 0.02, 0.04, txt)
        ga_win_widget_button_center_x_at(wid, main_button_handle, 0.5)
    end
    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Return To Game (ESC or F)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg)
end

function p.__process_input(wid)
    if( ga_win_widget_go_back_button_process_input(wid) or
        ga_win_key_pressed(wid, "F") )
    then
        ga_play_sound("menu_back")
        ga_window_pop()
    end

    local keymax = ga_get_i("worldgen.state.tga")
    local which_button = ga_win_widget_button_process_input(wid)

    if( which_button == main_button_handle or 
            game_key.pressed_or_spammed(wid, "ENTER") )
        then
        if keymax < 10 then
            local gold = ga_get_i("xar.player.gold.amount")
            if (gold >= 2000) then
                local new_gold = gold - 2000
                ga_set_i("xar.player.gold.amount", new_gold)
                std.set_bydelta_i("worldgen.state.tga", 1)
                ga_worldgen_refresh_state_var("tga")
                ga_play_sound("buy")
            else
                ga_play_sound("error")
            end
        else
            ga_play_sound("error")
        end
    end
end
