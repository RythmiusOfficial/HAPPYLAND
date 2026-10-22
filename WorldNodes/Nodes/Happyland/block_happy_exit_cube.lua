function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_concrete"
end

function p.__main()
    set_default_block("happy_air")
    std.create_edges("s")

    local msg = "Message from TON 618:\n\n"
             .. "^x0000ffHahahhaaahhhahah!!\n"
             .. "Don't tell me you thought there would be a blue ring device here!!!^!"
    add_bent_s(7,7,8, "bent_base_txt", msg)
    add_bent(7,7,7, "bent_base_ring_green_danger")
end