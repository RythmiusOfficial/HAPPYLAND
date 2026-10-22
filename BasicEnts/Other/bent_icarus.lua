function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Enable / disable Icarus mode"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.payload(level, bp)
    ga_window_push("win_icarus")
end
