function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 1.0)
    
    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.7, "CREATING THE STARTING POSITION")
    ga_win_txt_center(wid, 0.6, "SEED = " .. tostring(ga_get_sys_i("game.package.seed")))

    local str = ga_get_s("xar.create_start_pos.splash")
    ga_win_txt_center(wid, 0.45, str)

    local min_x = 0.2
    local min_y = 0.3
    local max_x = 0.8
    local max_y = 0.4
    --
    local frac = ga_get_f("xar.create_start_pos.frac")
    local mid_x = min_x * (1.0 - frac) + max_x * frac
    ga_win_quad(wid, min_x, min_y, mid_x, max_y, "green")
    ga_win_quad(wid, mid_x, min_y, max_x, max_y, "dark_grey")

    local tries_max = ga_get_i("xar.create_start_pos.global_tries_max")
    local tries = ga_get_i("xar.create_start_pos.global_tries")
    local frac = (tries / tries_max)
    local min_y = 0.2
    local max_y = 0.25
    local mid_x = min_x * (1.0 - frac) + max_x * frac
    ga_win_quad(wid, min_x, min_y, mid_x, max_y, "red")
    ga_win_quad(wid, mid_x, min_y, max_x, max_y, "dark_grey")
    --
    ga_win_txt_center(wid, 0.1, "Go Back (ESC)")
end

function p.__process_input(wid)
    if ga_win_key_pressed(wid, "ESC") then
        --Going to the main menu.
        ga_play_sound("menu_back")
        ga_set_sys_b("menu.in_main", true)
    end
end
