function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_yellow_concrete"
end

function p.__main()
    set_default_block("happy_air")
    std.create_edges("r_yellow")

    -- Create plasma upgrade
    add_bent(7,7,7, "bent_upgrade_gun_1_proj_speed")

    -- Create gold pickup
    add_bent(7,7,5, "bent_gold_10")

    -- Create text box
    local msg = "Here is a (permanent) upgrade!"
    add_bent_s(7,7,9, "bent_base_txt", msg)
end