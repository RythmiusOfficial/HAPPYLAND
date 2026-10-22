function p.__start(wid)
    local min_x = 0.1
    local max_x = 0.9
    local min_y = 0.3
    local max_y = 0.7
    local char_w = 0.02
    local char_h = 0.04
    local col = std.vec(0.0, 0.5, 0.5)

    local inst_id = ga_get_i("temp.xar.marker_long_inst_id")
    local init_str = ga_ment_get_s(inst_id, "msg")

    ga_win_widget_mutable_text_box_start(
        wid, min_x, max_x, min_y, max_y, char_w, char_h,
        col,
        init_str)
end

function p.__end(wid)
    local txt = ga_win_widget_mutable_text_box_get_text(wid)

    local game_time = ga_get_sys_f("game.time.total")
    local revert_time = game_time + (1000000 * 60.0)

    local inst_id = ga_get_i("temp.xar.marker_long_inst_id")
    ga_ment_set_s(inst_id, "msg", txt)
    
    ga_win_widget_mutable_text_box_end(wid)
end

function p.__process_input(wid)
    if ga_win_key_pressed(wid, "ESC") then
        ga_window_pop()
    end

    if ga_win_key_pressed(wid, "F5") then
        local cur_marker_code_id = ga_get_i("temp.xar.marker_long_code_id")
        local tracker_marker_code_id = ga_get_i("xar.player.tracking_marker")
        if( cur_marker_code_id == tracker_marker_code_id ) then
            game_tracking_marker.hide()
        end
        --
        local inst_id = ga_get_i("temp.xar.marker_long_inst_id")
        ga_ment_remove(inst_id)
        ga_window_pop()
    end

    if ga_win_key_pressed(wid, "F7") then
        game_tracking_marker.unhide()
        local cur_marker = ga_get_i("temp.xar.marker_long_code_id")
        ga_set_i("xar.player.tracking_marker", cur_marker)
    end
end

function p.__render(wid)
    --The mutable_text_box widget is rendered automatically
    --(because it was created).

    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.9, "THE MESSAGE FOR THIS LONG MARKER:")

    ga_win_set_char_size(wid, 0.015, 0.03)
    ga_win_txt_center(wid, 0.85, "PRESS F5 TO REMOVE (OR RIGHT CLICK ON MARKER)")

    ga_win_set_char_size(wid, 0.015, 0.03)
    local cur_marker = ga_get_i("temp.xar.marker_long_code_id")
    local tracker_marker = ga_get_i("xar.player.tracking_marker")
    if( cur_marker == tracker_marker ) then
        ga_win_txt_center(wid, 0.80, "THIS IS YOUR TRACKING MARKER")
    else
        ga_win_txt_center(wid, 0.80, "PRESS F7 TO SET AS TRACKING MARKER")    
    end

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.06, "Go Back (ESC)")
end
