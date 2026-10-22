--win_main_menu_camera_roll_drag.lua

function p.def_value()
    return 0.70 --Default num.
end

function p.get_value()
    local var = "movement.roll.drag"
    ga_package_init_f(var, p.def_value())
    return ga_package_get_f(var)
end

function p.set_value(value)
    local var = "movement.roll.drag"
    ga_package_init_f(var, p.def_value())
    return ga_package_set_f(var, value)
end

--Returns true off worked.
function p.set_value_maybe(str_value)
    local num_value = tonumber(str_value)
    if( num_value == nil ) then return false end
    if( num_value > 1.0 ) then return false end
    if( num_value < 0.0 ) then return false end
    --
    p.set_value(num_value)
    return true
end

function p.__start(wid)
    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Go Back (ESC)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg);

    local min_y = 0.45
    local w = 0.02
    local h = 0.04
    ga_win_widget_text_input_start(wid, min_y, w, h)
end

function p.__end(wid)
    --Nothing to do.
end

function p.__get_path_display_name()
    return "ROLL DRAG"
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    local path = ga_get_window_stack_display_names()
    game_win_top_bar.render_path(wid, path)
    ga_win_set_front_color_default(wid)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.85, "ROLL DRAG")

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.75, "DEFAULT VALUE: 0.7")
    ga_win_txt_center(wid, 0.7, "CLOSER TO 1.0 MEANS LESS DRAG")
    ga_win_txt_center(wid, 0.65, "NEVER HAVE THIS > 1.0")

    ga_win_txt_center(wid, 0.5, "ENTER NEW VALUE:")
end

function p.__process_input(wid)
    if ga_win_widget_go_back_button_process_input(wid) then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end

    local txt = ga_win_widget_text_input_process_input(wid)
    if( txt ~= "" ) then
        local ok = p.set_value_maybe(txt)
        if( ok ) then
            ga_window_pop()
            return
        else
            ga_play_sound_menu("error")
        end
    end
end
