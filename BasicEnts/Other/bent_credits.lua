function p.__get_mesh() return "bent_credits" end

function p.__on_use(level, bp)
    ga_set_f("xar.key_time.universe", 20.0)
    ga_window_push("win_thank_you")
end
