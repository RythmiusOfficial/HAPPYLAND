function p.render_compass(wid)
    -- Compass (top middle of the screen).
    local camera_look = ga_get_sys_v("game.player.camera.look")
    local dir_str = ""
    local cutoff = 3.1415926 / 8.0
    if( std.angle_between_vec(camera_look, std.vec(1.0, 0.0, 0.0)) < cutoff ) then
        dir_str = "RIGHT"
    end
    if( std.angle_between_vec(camera_look, std.vec(-1.0, 0.0, 0.0)) < cutoff ) then
        dir_str = "LEFT"
    end
    if( std.angle_between_vec(camera_look, std.vec(0.0, 1.0, 0.0)) < cutoff ) then
        dir_str = "FRONT"
    end
    if( std.angle_between_vec(camera_look, std.vec(0.0, -1.0, 0.0)) < cutoff ) then
        dir_str = "BACK"
    end
    if( std.angle_between_vec(camera_look, std.vec(0.0, 0.0, 1.0)) < cutoff ) then
        dir_str = "UP"
    end
    if( std.angle_between_vec(camera_look, std.vec(0.0, 0.0, -1.0)) < cutoff ) then
        dir_str = "DOWN"
    end
    ga_win_set_front_color(wid, std.vec(0.0, 1.0, 0.0))
    ga_win_set_char_size(wid, 0.02, 0.03)
    ga_win_txt_center(wid, 0.96, dir_str)
end
