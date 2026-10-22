--The game time when they opened the menu.
local start_time = -1.0

--Helper variable used for rendering.
--It is the y coordinte of the next part of the
--credits to be rendered.
local scroll = 0.0

function p.__start(wid)
    --ga_play_sound("pickup_upgrade") --Could play a sound here.

    p.start_time = ga_get_sys_f("time.current") --Seconds since program started.

    --Logging in the time that they won the game.
    if not ga_get_b("xar.credits.won_game") then
        ga_set_b("xar.credits.won_game", true)
        --Epic.
        --Will set xar.credits.won_game_game_time
        -- and xar.credits.won_game_play_time.
        game_win_game.win_game()
    end

    ga_play_music("credits")

    ga_set_b("xar.credits.in", true)
end

function p.__end(wid)
    ga_stop_music()

    ga_set_b("xar.credits.in", false)
end

--Advancing the scroll.
function p.sub(delta)
    p.scroll = p.scroll - delta
end

function p.txt_center(wid, str)
    ga_win_txt_center(wid, p.scroll, str)
end

function p.win_quad(wid, min_x, min_y, max_x, max_y, tex)
    ga_win_quad(wid,
        min_x, min_y + p.scroll,
        max_x, max_y + p.scroll,
        tex)
end

function p.win_quad_standard(wid, tex)
    p.win_quad(wid, 0.25, -0.8, 0.75, 0.0, tex)
end

function p.__render(wid)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 1.0)

    --Time stuff.
    local cur_time = ga_get_sys_f("time.current") --Seconds since program started.
    local time_diff1 = cur_time - p.start_time

    local start1 = 0.0
    if time_diff1 < start1 then return end --Will not happen.
    time_diff2 = time_diff1 - start1

    local initial_time_delay = 2.0
    p.scroll = 0.0
    if time_diff2 < initial_time_delay then
        p.scroll = 0.0
    else
        --Controlling the scroll speed.
        local speed = 0.07
        p.scroll = (time_diff2 - initial_time_delay) * speed
    end

    local max_scroll = 9.4 --A little ugly.
    p.scroll = math.min(p.scroll, max_scroll)

    --Rendering the stats that are displayed
    --the the player wins the game, such as the
    --difficulty they used and their total play time.
    game_credits_stats_render.render_end_credit_stats(wid, p.scroll)

    --The scrolling credits.
    ga_win_set_char_size(wid, 0.04, 0.08)
    p.sub(0.1)  p.txt_center(wid, "CREDITS")
    ga_win_set_char_size(wid, 0.02, 0.04)
    p.sub(0.1)  p.txt_center(wid, "CREATOR")
    p.sub(0.05) p.txt_center(wid, "Dan Hathaway")
    p.sub(0.15) p.txt_center(wid, "ARTWORK")
    p.sub(0.05) p.txt_center(wid, "Bruce Hathaway")
    p.sub(0.1)  p.txt_center(wid, "ARTWORK")
    p.sub(0.05) p.txt_center(wid, "Joan Hathaway")
    p.sub(0.1)  p.txt_center(wid, "ARTWORK")
    p.sub(0.05) p.txt_center(wid, "Tegan Pollak")
    p.sub(0.1)  p.txt_center(wid, "IDEAS")
    p.sub(0.05) p.txt_center(wid, "Jon Brandvein")
    p.sub(0.1)  p.txt_center(wid, "-----------------------------------")
    p.sub(0.05) p.txt_center(wid, "FONT")
    p.sub(0.05) p.txt_center(wid, "White Rabbit by Matthew Welch")
    p.sub(0.1)  p.txt_center(wid, "CREDITS SONG")
    p.sub(0.05) p.txt_center(wid, "Variation of \"Cannon\" by Johann Pachelbel")
    p.sub(0.05) p.txt_center(wid, "Arranged by Dan Hathaway")
    p.sub(0.05) p.txt_center(wid, "-----------------------------------")
    p.sub(0.2)  p.txt_center(wid, "You can learn how to")
    p.sub(0.05) p.txt_center(wid, "create your own")
    p.sub(0.05) p.txt_center(wid, "world by reading the creation manual!")
    p.sub(0.2)  p.txt_center(wid, "-----------------------------------")
    p.sub(0.2) p.win_quad_standard(wid, "scroll_cred1")
    p.sub(0.9) p.win_quad_standard(wid,"scroll_cred2")
    p.sub(0.9) p.win_quad_standard(wid,"scroll_cred3")
    p.sub(0.9) p.win_quad_standard(wid, "scroll_cred4")
    p.sub(0.9) p.win_quad_standard(wid, "scroll_cred5")
    p.sub(0.9) p.win_quad_standard(wid, "scroll_cred6")
    p.sub(0.9) p.win_quad_standard(wid, "scroll_cred7")

    ga_win_set_char_size(wid, 0.04, 0.08)
    p.sub(1.5) p.txt_center(wid, "THANKS FOR PLAYING!")
    --more?
end

function p.__process_input(wid)
    if ga_win_key_pressed(wid, "ESC") then
        ga_window_pop()
    end
end
