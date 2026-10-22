function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Black Hole Drive Control Panel"
end

function p.__on_use(level, bp)
    ga_window_push("win_black_hole_control_panel")
end
