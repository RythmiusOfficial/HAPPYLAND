function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_concrete"
end

function p.__main()
    set_default_block("happy_exit_cube_air")
    std.create_edges("r_concrete")

    local msg = "Message from TON 618:\n\n"
             .. "^x0000ffDon't tell me you thought there would ACTUALLY be a blue ring device here!!! "
             .. "Did you also happen to fall for the 'gullible on the ceiling' trick as well?!\n"
             .. "Hehhehahahhaaahhhahah!!^!"
    add_bent_s(7,7,9, "bent_base_txt", msg)
    add_bent(7,7,7, "bent_base_ring_green_danger")
end