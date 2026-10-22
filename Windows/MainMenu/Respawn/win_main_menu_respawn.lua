local press_y_handle = 1
local press_n_handle = 2
local press_p_handle = 3

function p.__start(wid)
    local go_back_button_y = 0.02
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Go Back (ESC)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg);

    ga_win_widget_button_start(wid, press_y_handle, 0.0, 0.6, 0.02, 0.04, "YES (PRESS Y)")
    ga_win_widget_button_center_x_at(wid, press_y_handle, 0.5)

    ga_win_widget_button_start(wid, press_n_handle, 0.0, 0.53, 0.02, 0.04, "NO (PRESS N)")
    ga_win_widget_button_center_x_at(wid, press_n_handle, 0.5)

    ga_win_widget_button_start(wid, press_p_handle, 0.0, 0.37, 0.02, 0.04, "PRESS P")
    ga_win_widget_button_center_x_at(wid, press_p_handle, 0.5)
end

function p.__end(wid)
    --Nothing to do.
end

function p.__get_path_display_name()
    return "RESPAWN"
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    local path = ga_get_window_stack_display_names()
    game_win_top_bar.render_path(wid, path)
    ga_win_set_front_color_default(wid)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.9, "RESPAWN?")

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.8, "WANT TO RESPAWN TO YOUR RESPAWN POINT?")

    ga_win_set_char_size(wid, 0.015, 0.03)
    ga_win_set_front_color(wid, std.vec(1.0, 1.0, 0.0))
    if( game_genesis.enabled() ) then
        ga_win_txt_center(wid, 0.7, "YOU WILL LOSE 30 GOLD")
    else
        ga_win_txt_center(wid, 0.7, "YOU WILL LOSE HEALTH ABOVE 100%, ARMOR, AMMO, AND 30 GOLD")
    end

    ga_win_set_front_color_default(wid)
    ga_win_set_char_size(wid, 0.02, 0.04)
    -- ga_win_txt_center(wid, 0.6, "Y / N")

    ga_win_line(wid, 0.0,0.5, 1.0,0.5, std.vec(1.0, 1.0, 1.0))

    local low_ammo_mode = ga_get_b("worldgen.state.low_ammo")
    if not low_ammo_mode then
        local respawn_cost = game_respawn.get_keepammo_cost()
        ga_win_txt_center(wid, 0.30,
            "TO PAY ^xff0000" .. tostring(respawn_cost) .. "^! GOLD")
        ga_win_txt_center(wid, 0.23, "TO RESPAWN BUT KEEPING")
        ga_win_txt_center(wid, 0.16, "YOUR HEALTH, AMMO, AND ARMOR")
    end
end

function p.__process_input(wid)
    if ga_win_key_pressed(wid, "Y") then
        ga_set_i("xar.player.health.amount", -100)
        ga_play_sound("player_death")
        ga_window_pop_all()
        --
        --Actually respawning.
        ga_command("respawn force")
        return
    end

    local which_button = ga_win_widget_button_process_input(wid)

    if( which_button == press_p_handle or
        ga_win_key_pressed(wid, "P") )
    then
        if ga_get_b("xar.player.arcade.inside") then
            ga_window_push("win_main_menu_respawn_arcade_error")
            return
        end
        ga_play_sound("buy")
        ga_window_pop_all()
        --Actually respawning.
        ga_command("respawn force keepammo")
        return
    end
    if( ga_win_widget_go_back_button_process_input(wid) or
        ga_win_key_pressed(wid, "N") )
    then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end
end
