function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_concrete"
end

function p.__main()
    set_default_block("happy_exit_cube_air")
    std.create_edges("r_concrete")

    local chance = randf()

    local msg = "Message from TON 618:\n\n"
             .. "^x0000ffDon't tell me you thought there would ACTUALLY be a blue ring device here!!! "
             .. "Did you also happen to fall for the 'gullible on the ceiling' trick as well?!\n"
             .. "Hehhehahahhaaahhhahah!!^!"
    add_bent_s(7,7,9, "bent_base_txt", msg)

    if chance <= 0.2 then -- 20% chance!
        add_bent(7,7,7, "bent_base_ring_green_danger")
        set_pos(15,15,15, "e")
        add_bent(15,15,15, "bent_base_ring_pink_dest")
    end

    -- Create antiplugs
    create_rect("anti_plug", 0,1,1, 0,14,14)
    create_rect("anti_plug", 15,1,1, 15,14,14)
    create_rect("anti_plug", 1,0,1, 14,0,14)
    create_rect("anti_plug", 1,15,1, 14,15,14)
    create_rect("anti_plug", 1,1,0, 14,14,0)
    create_rect("anti_plug", 1,1,15, 14,14,15)
end