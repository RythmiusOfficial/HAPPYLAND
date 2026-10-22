function p.__start(wid)
    p.refresh_list(wid)

    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Go Back (ESC)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg);
end

function p.refresh_list(wid)
    local hurt_var = "sound.player_hurt_sounds_enabled"
    ga_package_init_b(hurt_var, true)
    local hurt_sounds_enabled = ga_package_get_b(hurt_var)

    local min_y = 0.40
    local max_y = 0.50
    local char_w = 0.015
    local char_h = 0.03
    local col = {x=0.0, y=0.5, z=0.5}
    --
    local op_1 = "PLAYER HURT SOUNDS: "
    if( hurt_sounds_enabled ) then
        op_1 = op_1 .. "ENABLED"
    else
        op_1 = op_1 .. "DISABLED"
    end
    options = {
        op_1 }
    ga_win_widget_small_list_start(
        wid, min_y, max_y, char_w, char_h,
        col, options)
end

function p.__end(wid)
    --Nothing to do.
end

function p.__get_path_display_name()
    return "SOUND"
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    local path = ga_get_window_stack_display_names()
    game_win_top_bar.render_path(wid, path)
    ga_win_set_front_color_default(wid)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.85, "SOUND")
end

function p.__process_input(wid)
    sel = ga_win_widget_small_list_process_input(wid)
    sel_str = ga_win_widget_small_list_get_entry(wid, sel)
    if( sel_str:find("^PLAYER HURT SOUNDS") ) then
        local var = "sound.player_hurt_sounds_enabled"
        local old_value = ga_package_get_b(var)
        ga_package_set_b(var, not old_value)
        p.refresh_list(wid)
    end

    if ga_win_widget_go_back_button_process_input(wid) then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end
end
