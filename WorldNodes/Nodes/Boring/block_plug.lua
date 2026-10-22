function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_plug"
end

function p.__main()
    set_default_block("e")
    std.create_edges("r_plug")
end
