-------------------------------------------------
--                     Data
-------------------------------------------------

local color = std.vec(1.0, 1.0, 1.0)

-------------------------------------------------
--        Functions called back by engine
-------------------------------------------------

function p.__update()
    p.update_common()
end

function p.__update_passive()
    p.update_common()
end

-------------------------------------------------
--                Helper functions
-------------------------------------------------

--This is called whenever the game loaded
--(either paused or not paused).
function p.update_common()
    -- p.blink()
end

function p.blink()
    ga_print("Here in blinker_test.update_common!!!")
    if ga_get_game_paused() then
        ga_print("Here in blinker_test.update_common, even though game is paused")
    end

    --Changing the based on the time.
    --Two second flicker.
    -- local time = ga_get_game_time()
    local time = ga_get_sys_f("time.current")
    local time2 = math.floor(time * 0.5)
    if( time2 % 2 == 0 ) then
        color = std.vec(1.0, 0.0, 0.0) --Red.
    else
        color = std.vec(0.0, 1.0, 0.0) --Green.
    end
end

--wid = window id.
function p.render(wid)
    --Covering the screen with a transparent,
    --of the color specified with the local variable "color".
    -- local min_x = 0.0
    -- local min_y = 0.0
    -- local max_x = 1.0
    -- local max_y = 1.0
    -- local alpha = 0.2
    -- ga_win_quad_color_alpha(
    --     wid, min_x, min_y,
    --     max_x, max_y,
    --     color, alpha)
end
