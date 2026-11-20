function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_info"
end

function p.__main()
    set_default_block("e")
    std.create_edges("r_info")
    local level = get_level()
    local room = get_input_path_block_i(level, "room")
    local msg = ""

    if room == 1 then -- infertile concrete growths
        msg = "Hey wattup bro"
        add_bent_s(7,7,7, "bent_base_txt", msg)
        add_bent(7,7,5, "bent_gold_once_200")
    elseif room == 2 then
        msg = "Hey wattup bro 2"
        add_bent_s(7,7,7, "bent_base_txt", msg)
        add_bent(7,7,5, "bent_gold_once_200")
    elseif room == 3 then
        msg = "Hey wattup bro 3"
        add_bent_s(7,7,7, "bent_base_txt", msg)
        add_bent(7,7,5, "bent_gold_once_200")
    elseif room == 4 then
        -- plugged; large map room
    elseif room == 5 then
        -- plugged; black and dark gray speckled
    elseif room == 6 then
        -- Start Hooks
    elseif room == 7 then
        msg = "Hey wattup bro 7"
        add_bent_s(7,7,7, "bent_base_txt", msg)
        add_bent(7,7,5, "bent_gold_once_200")
    elseif room == 8 then
        -- Electric Fence maze (short)
    elseif room == 9 then
        msg = "Hey wattup bro 9"
        add_bent_s(7,7,7, "bent_base_txt", msg)
        add_bent(7,7,5, "bent_gold_once_200")
    elseif room == 10 then
        msg = "Hey wattup bro 10"
        add_bent_s(7,7,7, "bent_base_txt", msg)
        add_bent(7,7,5, "bent_gold_once_200")
    end
end

function p.__type_init(id)
    ia_block_new_var_i(id, "room", 1)
end