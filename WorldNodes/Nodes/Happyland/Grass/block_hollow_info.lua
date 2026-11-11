function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_info"
end

function p.__main()
    set_default_block("e")
    std.create_edges("r_info")

    local bent = randi(1,5)

    -- treasure!
    if bent == 1 then
        add_bent(7,7,7, "bent_gold_once_5")
        add_bent(7,7,5, "bent_armor_200p_once")
    end
    if bent == 2 then
        add_bent(7,7,7, "bent_ammo_gun_2_small")
        add_bent(7,7,5, "bent_upgrade_gun_2_damage")
    end
    if bent == 3 then
        add_bent_s(7,7,7, "bent_base_waypoint", "Happy Grass Info Block")
        add_bent(7,7,5, "bent_base_save")
    end
    if bent == 4 then
        add_bent(7,7,7, "bent_base_respawn_point")
        add_bent(7,7,5, "bent_health_100p")
    end
    if bent == 5 then
        add_bent(7,7,7, "bent_gold_once_10")
        ment_start(7,7,7, "ment_monster_overseer")
        ment_set_offset(8,8,8)
        ment_end()
    end
end