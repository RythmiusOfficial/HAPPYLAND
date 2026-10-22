function p.__start(wid)
    local min_y = 0.30
    local max_y = 0.60
    local char_w = 0.03
    local char_h = 0.06
    local col = {x=0.0, y=0.5, z=0.5}
    local options = {}
    options = {
        "CAMERA + MOVEMENT",
        "MARKERS",
        "USE KEY" }
    ga_win_widget_small_list_start(
        wid, min_y, max_y, char_w, char_h,
        col, options)

    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Go Back (ESC)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg);
end

function p.__end(wid)
    --Nothing to do.
end

function p.__get_path_display_name()
    return "GAME"
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    local path = ga_get_window_stack_display_names()
    game_win_top_bar.render_path(wid, path)
    ga_win_set_front_color_default(wid)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.85, "GAME")
end

function p.__process_input(wid)
    local sel = ga_win_widget_small_list_process_input(wid)
    local sel_str = ga_win_widget_small_list_get_entry(wid, sel)
    if( sel_str == "CAMERA + MOVEMENT" ) then
        --I may want to change the name later.
        ga_window_push("win_main_menu_camera")
        return
    end
    if( sel_str == "MARKERS" ) then
        ga_window_push("win_main_menu_markers")
        return
    end
    if( sel_str == "USE KEY" ) then
        ga_window_push("win_main_menu_use_key")
        return
    end

    if ga_win_widget_go_back_button_process_input(wid) then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end
end
