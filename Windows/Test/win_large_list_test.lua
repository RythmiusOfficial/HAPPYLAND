function p.__start(wid)
    local min_y = 0.15
    local max_y = 0.7
    local char_w = 0.03
    local char_h = 0.06
    local col = {x=0.0, y=0.5, z=0.5}
    local options = {
        "OPTION 1",
        "OPTION 2",
        "OPTION 3",
        "OPTION 4",
        "OPTION 5",
        "OPTION 6",
        "OPTION 7",
        "OPTION 8"}
    local num_lines = 7
    ga_win_widget_large_list_start(
        wid, min_y, max_y, char_w, char_h,
        col, num_lines, options)
end

function p.__end(wid)
    --Nothing to do.
end

function p.__process_input(wid)
    if ga_win_key_pressed(wid, "ESC") then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end

    local sel1 = ga_win_widget_large_list_process_input(wid) --0 indexed.
    -- local test_str = ga_win_widget_large_list_get_entry(wid, 0)
    -- local sel2 = ga_win_widget_large_list_get_selected(wid)
    -- ga_win_widget_large_list_set_selected(wid, "OPTION 7")
    -- ga_print("sel1 = " .. tostring(sel1))
    -- ga_print("test_str = " .. test_str)
    -- ga_print("sel2 = " .. tostring(sel1))
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 0.95)

    ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_txt_center(wid, 0.85, "LARGE LIST TEST")

    --more!!!

    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.06, "Go Back (ESC)")
end
