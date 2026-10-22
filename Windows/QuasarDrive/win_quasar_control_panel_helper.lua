local press_plus_handle = 1
local press_minus_handle = 2

function p.__start(wid)
    ga_win_widget_button_start(wid, press_plus_handle, 0.0, 0.6, 0.03, 0.06, "+")
    ga_win_widget_button_center_x_at(wid, press_plus_handle, 0.6)

    ga_win_widget_button_start(wid, press_minus_handle, 0.0, 0.6, 0.03, 0.06, "-")
    ga_win_widget_button_center_x_at(wid, press_minus_handle, 0.4)

    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Go Back (ESC or F)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg)
end

function p.__render(wid)
    local color_black = std.vec(0.0, 0.0, 0.0)
    ga_win_set_background(wid, color_black, 1.0)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.9, "QUASAR HOLE DRIVE")
    ga_win_txt_center(wid, 0.83, "SET ALTERNATE LEVEL RADIUS")

    local radius = game_quasar_drive.get_alt_radius()
    ga_win_txt_center(wid, 0.6, tostring(radius))

    ga_win_set_char_size(wid, 0.01, 0.02)
    ga_win_txt_center(wid, 0.33, "THIS LEVEL RADIUS IS USED WHILE YOU ARE")
    ga_win_txt_center(wid, 0.3, "USING THE QUASAR DRIVE")
    ga_win_txt_center(wid, 0.27, "(TO IMPROVE LOADING TIME)")
end

function p.__process_input(wid)
    if( ga_win_widget_go_back_button_process_input(wid) or
        ga_win_key_pressed(wid, "F") )
    then
        ga_play_sound("menu_back")
        ga_window_pop()
    end

    local which_button = ga_win_widget_button_process_input(wid)

    if( which_button == press_plus_handle or
        ga_win_key_pressed(wid, "EQUALS") )
    then
        p.increment_radius()
    end
    if( which_button == press_minus_handle or
        ga_win_key_pressed(wid, "MINUS") )
    then
        p.decrement_radius()
    end
end

function p.increment_radius()
    local old_radius = game_quasar_drive.get_alt_radius()
    local new_radius = old_radius + 1
    if( new_radius > 10 ) then
        --Enforcing a sane upper bound.
        --The player could always just NOT use an alternate level radius
        --if they really wanted to have a huge level radius.
        new_radius = 10
    end
    game_quasar_drive.set_alt_radius(new_radius)
end

function p.decrement_radius()
    local min_radius = 3
    if( ga_is_cheating_enabled() ) then min_radius = 2 end
    --Note: a min radius of 1 might have bad side effects.
    --The player can set the radius to be 1 by hacking the Lua,
    --but it is not recommended.
    local old_radius = game_quasar_drive.get_alt_radius()
    local new_radius = old_radius - 1
    if( new_radius < min_radius ) then new_radius = min_radius end
    game_quasar_drive.set_alt_radius(new_radius)
end
