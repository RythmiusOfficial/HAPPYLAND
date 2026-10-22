--File: game_win_top_bar.lua

local color_cyan = std.vec(0.0, 1.0, 1.0)

p.num_buttons = 7
p.buttons = {}
p.buttons[1] = "TOP"
p.buttons[2] = "UPGRADES"
p.buttons[3] = "WEP STATS"
p.buttons[4] = "LEVEL UP"
p.buttons[5] = "DIFF"
p.buttons[6] = "TROPHIES"
p.buttons[7] = "WEP MODES"

function p.render_path(wid, path)
    ga_win_set_front_color(wid, color_cyan)
    ga_win_set_char_size(wid, 0.0075, 0.02)
    local min_x = 0.0
    local min_y = 0.97
    local str = ""
    for k,v in ipairs(path) do
        str = str .. v.name
        if( k < #path ) then
            str = str .. " -> "
        end
    end
    ga_win_txt(wid, min_x, min_y, str)
end

function p.create_stats_buttons(wid, green_num)
    local delta_x = 1.0 / p.num_buttons
    local x = 0.0
    local y = 0.97
    local w = 0.0075
    local h = 0.02
    for k,v in ipairs(p.buttons) do
        ga_win_widget_button_start(wid, k, x, y, w, h, v)
    end
    for i = 1,p.num_buttons do
        local center_x = (i - 1 + 0.5) * delta_x
        ga_win_widget_button_center_x_at(wid, i, center_x)
        local color = color_cyan
        if( i == green_num ) then color = std.vec(0.0, 1.0, 0.0) end
        ga_win_widget_button_set_color(wid, i, color)
    end
end

function p.remove_stats_buttons(wid)
    for k,v in ipairs(p.buttons) do
        ga_win_widget_button_end(wid, k)
    end
    --more!!!
end

--This could be in another script.
function p.buttons_process_input_helper(wid)
    local which_button = ga_win_widget_button_process_input(wid)
    if( which_button < 0 ) then return "" end
    return ga_win_widget_button_get_text(wid, which_button)
end

function p.create_stats_buttons_bot_line(wid)
    local color_cyan = std.vec(0.0, 1.0, 1.0)
    ga_win_line(wid, 0.0, 0.965, 1.0, 0.965, color_cyan)
    -- ga_win_line(wid, 0.0, 0.97, 1.0, 0.97, color_cyan)
end
