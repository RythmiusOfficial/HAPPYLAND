function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_orange_concrete"
end

function p.__main()
    set_default_block("happy_air")
    std.create_edges("r_orange")

    -- Create plasma upgrades
    add_bent(7,7,7, "bent_upgrade_gun_1_proj_speed")
    add_bent(7,7,5, "bent_upgrade_gun_1_proj_speed")

    -- Create gold pickup
    add_bent(7,7,3, "bent_gold_10")

    -- Create text box
    local msg = "Here are two (permanent) upgrades!"
    add_bent_s(7,7,9, "bent_base_txt", msg)
end