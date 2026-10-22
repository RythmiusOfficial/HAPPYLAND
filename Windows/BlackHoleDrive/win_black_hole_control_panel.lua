local open = false

function p.__start(wid)
    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Return To Game (ESC or F)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg)

    p.make_list(wid)
end

--Helper function.
function p.make_list(wid)
    local use_alt_radius = game_black_hole_drive.get_uses_alt_radius()
    local value1 = (
        use_alt_radius
        and "TRUE"
        or "FALSE" )
    --
    local min_y = 0.4
    local max_y = 0.6
    local char_w = 0.015
    local char_h = 0.03
    local col = {x=0.0, y=0.5, z=0.5}
    local options = {
        "USE ALTERNATE LEVEL RADIUS DURING EFFECT: " .. value1 }
    if( use_alt_radius ) then
        local alt_radius = game_black_hole_drive.get_alt_radius()
        options[#options+1] = "SET ALTERNATE LEVEL RADIUS: " .. tostring(alt_radius)
    end
    -- 
    ga_win_widget_small_list_start(
        wid, min_y, max_y, char_w, char_h,
        col, options)
end

function p.__render(wid)
    local color_black = std.vec(0.0, 0.0, 0.0)
    ga_win_set_background(wid, color_black, 1.0)

    if( not open ) then
        --Refactor once there are better open/close functions.
        open = true
        p.make_list(wid)
    end

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.9, "BLACK HOLE DRIVE")
    ga_win_txt_center(wid, 0.83, "CONTROL PANEL")
end

function p.__process_input(wid)
    if( ga_win_widget_go_back_button_process_input(wid) or
        ga_win_key_pressed(wid, "F") )
    then
        ga_play_sound("menu_back")
        ga_window_pop()
    end

    local selection = ga_win_widget_small_list_process_input(wid)
    local sel_name = ""
    if( selection >= 0 ) then
        sel_name = ga_win_widget_small_list_get_entry(wid, selection)
    end
    if( string.match(sel_name, "USE ALTERNATE LEVEL RADIUS") ) then
        game_black_hole_drive.toggle_uses_alt_radius()
        p.make_list(wid)
    end
    if( string.match(sel_name, "SET ALTERNATE LEVEL RADIUS") ) then
        open = false
        ga_window_push("win_black_hole_control_panel_helper")
        return
    end
end
