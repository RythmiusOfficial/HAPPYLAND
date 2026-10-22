function p.__start(wid)
    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Go Back (ESC)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg);
end

function p.__get_path_display_name()
    return "HARDCORE"
end

function p.state_already_died()
    return not ga_get_b("xar.first_life")
end

--Helper.
function p.young_enough_for_hardcore()
    --return true
    return (ga_get_game_time() < 5 * 60) --5 minutes.
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    local path = ga_get_window_stack_display_names()
    game_win_top_bar.render_path(wid, path)
    ga_win_set_front_color_default(wid)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.85, "HARDCORE MODE")

    if( not p.young_enough_for_hardcore() ) then
        ga_win_set_front_color(wid, std.vec(1.0, 0.0, 0.0))
        ga_win_txt_center(wid, 0.55, "CANNOT TURN ON HARDCORE MODE")
        ga_win_txt_center(wid, 0.45, "AFTER 5 MINUTES OF GAMEPLAY")
    elseif( p.state_already_died() ) then
        ga_win_set_front_color(wid, std.vec(1.0, 0.0, 0.0))
        ga_win_set_char_size(wid, 0.02, 0.04)
        ga_win_txt_center(wid, 0.50, "YOU CANNOT SWITCH TO HARDCORE MODE")
        ga_win_txt_center(wid, 0.40, "BECAUSE YOU HAVE ALREADY DIED")
    else
        if( p.get_hardcore() ) then
            ga_win_set_char_size(wid, 0.02, 0.04)
            ga_win_txt_center(wid, 0.2, "YOU ARE ALREADY IN HARDCORE MODE")
        else
            ga_win_set_char_size(wid, 0.02, 0.04)
            ga_win_txt_center(wid, 0.2, "DO IT?")
            ga_win_txt_center(wid, 0.15, "Y / N")
        end

        ga_win_set_front_color(wid, std.vec(1.0, 0.0, 0.0))
        ga_win_txt_center(wid, 0.80, "WHEN YOU DIE, YOU CANNOT RESPAWN")
        ga_win_txt_center(wid, 0.75, "YOU CANNOT TURN OFF HARDCORE MORE")

        ga_win_quad(wid, 0.35, 0.3, 0.65, 0.7, "icon_hardcore")
    end
end

function p.__process_input(wid)
    if  p.young_enough_for_hardcore() and
        (not p.state_already_died()) and
        ga_win_key_pressed(wid, "Y") and
        (not p.get_hardcore())
    then
        p.set_hardcore()
        ga_play_sound("harp")
        ga_window_pop_all()
        return
    end
    --
    if( ga_win_widget_go_back_button_process_input(wid) or
        ga_win_key_pressed(wid, "N") )
    then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end
end

function p.get_hardcore()
    return ga_get_hardcore_mode()
end

function p.set_hardcore()
    ga_set_hardcore_mode(true)
    ga_set_sys_b("game.automatic_saving", true)
end
