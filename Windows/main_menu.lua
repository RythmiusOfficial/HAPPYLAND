function p.__on_start(wid)
    local min_y = 0.4
    local max_y = 0.6
    local char_w = 0.03
    local char_h = 0.06
    local col = std.vec(0.0, 0.5, 0.5)
    local options = { "RESPAWN" }
    ga_win_widget_small_list_start(wid, 
        min_y, max_y, char_w, char_h,
        col, options)
end

function p.__on_end(wid)
    --Nothing to do.
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    ga_win_set_char_size(wid, 0.04, 0.08)
    ga_win_txt_center(wid, 0.85, "PACKAGE MAIN MENU")

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.12, "Go Back (ESC)")
end

function p.__process_input(wid)
    selection = ga_win_widget_small_list_process_input(wid)
    if( selection == 0 ) then
        ga_main_menu_push("blank_win_main_menu_respawn")
        return
    end

    if ga_win_key_pressed(wid, "ESC") then
        ga_main_menu_pop_all(false)
        return
    end
end
