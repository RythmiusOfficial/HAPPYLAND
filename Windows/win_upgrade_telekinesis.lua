--File: win_upgrade_telekinesis.lua

function p.__start(wid)
    p.refresh_options(wid)

    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Return To Game (ESC or F)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg)
end

--Helper function.
function p.refresh_options(wid)
    local min_y = 0.15
    local max_y = 0.70
    local char_w = 0.015
    local char_h = 0.03
    local col = {x=0.0, y=0.5, z=0.5}
    local num_display_lines = 13
    --
    local options = {}
    local all_array     = game_telekinesis.get_all_array()
    local display_names = game_telekinesis.get_upgrade_display_table()
    for k,v in ipairs(all_array) do
        local api_name = v
        local display_name = display_names[api_name]
        local has = game_telekinesis.has_upgrade(api_name)
        --
        local str = ""
        if( has ) then str = str .. "^x00ff00" end
        str = str .. display_name
        options[#options+1] = str
    end
    --
    ga_win_widget_large_list_start(
        wid, min_y, max_y, char_w, char_h,
        col, num_display_lines, options)
end

function p.__render(wid)
    ga_win_set_background_default(wid)

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.94, "TELEKINESIS UPGRADES")

    ga_win_set_char_size(wid, 0.015, 0.03)

    --This is also a way to double check "game_telekinesis.lua".
    local str =
        tostring(game_telekinesis.get_radius_base()) ..
        " + " ..
        tostring(game_telekinesis.get_radius_delta()) ..
        " = ^x00ff00" ..
        tostring(game_telekinesis.get_radius()) .. "^!"
    ga_win_txt_center(wid, 0.85, "TELEKINESIS RADIUS = " .. str .. " blocks")

    local str =
        tostring(game_telekinesis.get_free_cooldown_base()) ..
        " - " ..
        tostring(game_telekinesis.get_free_cooldown_delta()) ..
        " = ^x00ff00" ..
        tostring(game_telekinesis.get_free_cooldown()) .. "^!"
    ga_win_txt_center(wid, 0.80, "FREE TELEKINESIS COOLDOWN = " .. str .. " sec")
end

function p.__process_input(wid)
    if( ga_win_widget_go_back_button_process_input(wid) or
        ga_win_key_pressed(wid, "F") )
    then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end

    ga_win_widget_large_list_process_input(wid)
end
