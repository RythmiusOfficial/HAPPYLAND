--win_main_menu_camera.lua

function p.__start(wid)
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
    return "CAMERA"
end

function p.refresh_options(wid)
    local use_true_up = ga_get_sys_b("game.player.move.fly.use_true_up")
    --
    local min_y = 0.4
    local max_y = 0.6
    local char_w = 0.02
    local char_h = 0.04
    local col = {x=0.0, y=0.5, z=0.5}
    local options = {}
    if( use_true_up ) then
        local value1 = (
            ga_get_b("xar.movement.move_on_z_axis")
            and "TRUE"
            or "FALSE" )
        options = {
            "USE TRUE UP: TRUE",
            "MOVE ON Z AXIS: " .. value1}
    else
        options = {
            "USE TRUE UP: FALSE",
            "ROLL DRAG: " .. tostring( win_main_menu_camera_roll_drag.get_value() ),
            "ROLL ACC: "  .. tostring( win_main_menu_camera_roll_acc.get_value() )}
    end
    ga_win_widget_small_list_start(
        wid, min_y, max_y, char_w, char_h,
        col, options)
end

function p.__render(wid)
    p.refresh_options(wid)

    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    local path = ga_get_window_stack_display_names()
    game_win_top_bar.render_path(wid, path)
    ga_win_set_front_color_default(wid)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.85, "CAMERA")
end

function p.__process_input(wid)
    if ga_win_widget_go_back_button_process_input(wid) then
        ga_play_sound("menu_back")
        ga_window_pop()
    end

    local sel_num = ga_win_widget_small_list_process_input(wid)
    if( sel_num >= 0 ) then
        local sel_str = ga_win_widget_small_list_get_entry(wid, sel_num)
        if( sel_str:find("^USE TRUE UP") ~= nil ) then
            --Toggling "use true up".
            local use_true_up_old = ga_get_sys_b("game.player.move.fly.use_true_up")
            p.set_true_up(not use_true_up_old)
        end
        if( sel_str:find("^MOVE ON Z AXIS") ~= nil ) then
            local var = "xar.movement.move_on_z_axis"
            local old_value = ga_get_b(var)
            ga_set_b(var, not old_value)
        end
        if( sel_str:find("^ROLL DRAG") ~= nil ) then
            ga_window_push("win_main_menu_camera_roll_drag")
            return
        end
        if( sel_str:find("^ROLL ACC") ~= nil ) then
            ga_window_push("win_main_menu_camera_roll_acc")
            return
        end
    end
end

function p.set_true_up(use_true_up)
    local trans = std.vec(0.0, 0.0, 0.0)
    local radius = ga_get_sys_f("game.player.move.fly.radius")
    ga_move_set_body_fly(trans, radius, use_true_up)
    if use_true_up then
        ga_set_sys_s("display.hud.attack_display.type", "cylinder")
    else
        ga_set_sys_s("display.hud.attack_display.type", "sphere")
    end
end
