--File: game_air_drag.lua

--This is how drag works:
--When do update player movement,
--we ask the engine was the different
--between the player's last two positions
--(for the last two discrete updates)
--by calling ga_get_sys_v("game.player.move.last_pos_diff").
--Note that there are exactly 25 discrete
--updates per second.
--Then we scale this difference vector by "drag".
--So a drag value of 1.0 means we do not slow down at all.

--Getting movement "drag" factor.
function p.get_air_drag()
    local data = p.helper1()
    return data.drag
end

--Getting movement "acceleration" magnitude.
function p.get_air_acc()
    local data = p.helper1()
    return data.acc
end

--Getting both drag and acc at the same time.
function p.helper1()
    local data = p.helper2()

    --This is a little tricky.
    --Yadifriend pointed out that they prefer the brake
    --to change the drag but not change the acceleration.
    --This makes sense, and if the player really wants to
    --stop completely, then they can also stop accelerating
    --(however they were doing that).
    if ga_get_b("xar.movement.brake") then
        --This will make this stop quickly.
        data.drag  = 0.80
        -- data.acc = 0.0 --Does NOT feel good to set it to zero.
    end

    return data
end

function p.helper2()
    local data = {}
    data.drag = 0.0
    data.acc = 0.0

    local game_time = ga_get_game_time()
    
    local rocket_mode = ga_get_b("xar.movement.rocket")

    local quasar_drive_end_time = ga_get_f("xar.player.gun0.quasar_drive_end")
    if( rocket_mode and
        game_time < quasar_drive_end_time )
    then
        --Using the iconic "Quasar Drive".
        data.drag = 0.995
        data.acc = 0.2
        return data
    end

    local black_hole_drive_end_time = ga_get_f("xar.player.gun0.black_hole_drive_end")
    if( rocket_mode and
        game_time < black_hole_drive_end_time )
    then
        --Using the "Black Hole Drive".
        data.drag = 0.99
        data.acc = 0.2
        return data
    end

    if( rocket_mode ) then
        --Normal rocket mode.
        data.drag = 0.98
        data.acc = 0.2
        return data
    end

    --The default values.
    data.drag = 0.95
    data.acc  = 0.1
    return data
end
