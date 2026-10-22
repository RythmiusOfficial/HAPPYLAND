--File: win_icarus.lua

local button_handle = 1

function p.get_enabled()
    return ga_get_icarus_enabled()
end

function p.set_enabled(value)
    ga_set_icarus_enabled(value)
end

function p.toggle_enabled(value)
    p.set_enabled( not p.get_enabled() )
end

function p.__start(wid)
    local x = 0.0
    local y = 0.4
    local w = 0.02
    local h = 0.04
    local msg = "PRESS ENTER TO TOGGLE"
    ga_win_widget_button_start(wid, button_handle, x,y,w,h, msg)
    ga_win_widget_button_center_x_at(wid, button_handle, 0.5)

    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Return To Game (ESC or F)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg)
end

function p.__end(wid)
    --Nothing to do.
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    ga_win_set_char_size(wid, 0.04, 0.08)
    ga_win_txt_center(wid, 0.85, "ICARUS MODE")

    local str = "ICARUS MODE IS CURRENTLY "
    if( p.get_enabled() ) then str = str .. "ENABLED"
    else str = str .. "DISABLED"
    end
    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.6, str)

    --The text button is displayed automatically.
end

function p.__process_input(wid)
    if( ga_win_widget_go_back_button_process_input(wid) or
        ga_win_key_pressed(wid, "F") )
    then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end
    
    local button_clicked = ga_win_widget_button_process_input(wid)
    if( ga_win_key_pressed(wid, "ENTER") or
        button_clicked == button_handle )
    then
        p.toggle_enabled(value)

        if( p.get_enabled() ) then
            ga_play_sound_menu("holy_cow")
            -- ga_play_sound_menu("harp")
        end
    end

end
