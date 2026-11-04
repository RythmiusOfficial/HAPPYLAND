function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_dust"
end

function p.__main()
    set_default_block("happy_smokey_air")
    std.create_center(6, "dust")
    create_sprinkles(0,0,0, 15,15,15, 0.2, "dust")
end