function p.__start(wid)
    p.refresh_list(wid)

    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Go Back (ESC)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg)
end

function p.__end(wid)
    --Nothing to do.
end

function p.__get_path_display_name()
    return "USE KEY"
end

function p.refresh_list(wid)
    local uses = ga_get_b("xar.input.use_primary_uses_object")

    local min_y = 0.4
    local max_y = 0.4
    local char_w = 0.015
    local char_h = 0.03
    local col = {x=0.0, y=0.5, z=0.5}
    --
    local op_1 = "ATTACK USES OBJECTS: "
    if( uses ) then
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


function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    local path = ga_get_window_stack_display_names()
    game_win_top_bar.render_path(wid, path)
    ga_win_set_front_color_default(wid)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.85, "USE KEY")

    ga_win_set_char_size(wid, 0.015, 0.03)

    ga_win_txt_center(wid, 0.6, "USING PRIMARY ATTACK DOUBLES AS THE USE KEY?")

    -- local enabled = ga_get_b("xar.input.use_primary_uses_object")
    -- local enabled_str = "NO"
    -- if enabled then enabled_str = "YES" end
    -- ga_win_txt_center(wid, 0.5,enabled_str)

    -- ga_win_txt_center(wid, 0.3, "ENABLE?")
    -- ga_win_txt_center(wid, 0.25, "Y / N")
end

function p.__process_input(wid)
    local sel = ga_win_widget_small_list_process_input(wid)

    local uses = ga_get_b("xar.input.use_primary_uses_object")

    if( (uses and sel == 0) or
        ga_win_key_pressed(wid, "N") )
    then
        ga_play_sound("menu_select")
        ga_set_b("xar.input.use_primary_uses_object", false)
        p.refresh_list(wid)
        return
    end
    if( (not uses and sel == 0) or
        ga_win_key_pressed(wid, "Y") )
    then
        ga_play_sound("menu_select")
        ga_set_b("xar.input.use_primary_uses_object", true)
        p.refresh_list(wid)
        return
    end
    
    if( ga_win_widget_go_back_button_process_input(wid) ) then
        ga_play_sound("menu_back")
        ga_window_pop()
        p.refresh_list(wid)
        return
    end
end
