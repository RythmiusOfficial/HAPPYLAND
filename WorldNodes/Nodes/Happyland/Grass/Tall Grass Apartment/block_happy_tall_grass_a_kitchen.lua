function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_white_borderless"
end

function p.__main()
    set_default_block("e")
    std.create_shell("r_white_diag")

    -- Add handles and other fitting textures.
    -- Maybe add a small chandelier in the room as well.

    -- Counter bottoms
    create_rect("r_concrete", 1,3,1, 2,14,3)
    create_rect("r_concrete", 1,13,1, 14,14,3)
    create_rect("r_concrete", 13,1,1, 14,14,3)
    -- Counter tops
    create_rect("r_white_bdless", 1,2,4, 3,14,4)
    create_rect("r_white_bdless", 1,12,4, 14,14,4)
    create_rect("r_white_bdless", 12,3,4, 14,14,4)
    set_pos(3,2,4, "e")

    -- Oven
    create_rect("e", 1,6,1, 3,8,3)
    create_rect("r_dark_gray", 1,6,1, 3,8,4)
    create_rect("stove_top", 1,6,4, 3,8,4)
    create_rect("r_black", 1,6,5, 1,8,5)
    set_pos(3,7,2, "glass")
    set_pos(2,7,2, "e")
    set_pos(1,7,2, "r_black")

    -- Sink
    create_rect("r_white_bdless", 6,12,3, 10,12,3)
    create_rect("e", 7,13,4, 9,13,4)
    create_rect("water", 7,13,3, 9,13,3)
    create_rect("r_metal", 8,14,5, 8,14,6)
    set_pos(8,13,6, "r_metal")
    create_rect("r_white_bdless", 8,13,1, 8,13,2)

    -- Fridge
    create_rect("e", 12,6,1, 14,8,8)
    create_rect("r_white_bdless", 13,6,1, 14,8,8)
    -- Fridge Doors
    create_rect("r_white_bdless", 10,9,1, 12,9,4)
    create_rect("r_white_bdless", 10,9,6, 12,9,8)
    -- Inside
    create_rect("e", 13,7,2, 14,7,3)
    create_rect("e", 13,7,6, 14,7,6)
    -- Backing
    set_pos(15,7,6, "r_white_bdless")
    create_rect("r_white_bdless", 15,7,2, 15,7,3)
    -- Indescribable Food and trophy
    add_bent(13,7,2, "bent_indescribable_food")
    add_bent(13,7,3, "bent_trophy_st_kitchen")

    add_bent(13,7,6, "bent_indescribable_food")
    add_bent(14,7,6, "bent_indescribable_food")

    -- Upper cupboards
    create_rect("r_concrete", 1,1,12, 2,14,14)
    create_rect("r_concrete", 1,13,12, 14,14,14)
    create_rect("r_concrete", 13,1,12, 14,14,14)
    -- Lower cupboards
    create_rect("r_white_bdless", 1,1,11, 2,14,11)
    create_rect("r_white_bdless", 1,13,11, 14,14,11)
    create_rect("r_white_bdless", 13,1,11, 14,14,11)
    create_rect("r_concrete", 13,1,4, 14,2,12)
    -- Oven tunnel
    create_rect("e", 1,3,1, 1,7,1)
    create_rect("r_dark_gray", 1,3,0, 1,7,0)
    create_rect("r_dark_gray", 0,3,1, 0,7,1)
    set_pos(1,7,2, "e")
    set_pos(0,7,2, "r_black")
    add_bent(2,7,2, "bent_indescribable_food")

    -- Sink tunnel
    create_rect("water", 8,14,1, 8,14,3)
    create_rect("water", 8,14,1, 14,14,1)
    create_rect("water", 14,9,1, 14,14,1)
    create_rect("water", 15,5,1, 15,9,1)
    create_rect("water", 14,1,1, 14,5,1)
    create_rect("water", 14,1,1, 14,1,14)
    create_rect("water", 14,1,14, 14,14,14)
    create_rect("water", 1,14,14, 14,14,14)
    create_rect("water", 1,1,14, 1,14,14)
    add_bent(1,1,14, "bent_indescribable_food")
    add_bent(1,2,14, "bent_indescribable_food")
    add_bent(1,3,14, "bent_indescribable_food")
    add_bent(1,4,14, "bent_gold_once_1000")

    -- Black ceiling
    create_rect("r_black", 1,1,15, 14,14,15)
    -- Hole
    set_pos(8,8,15, "anti_plug")

    -- misc bents
    add_bent(2,13,6, "bent_base_ring_pink_source")
    local msg = "This pink ring will take you to the outside of this ^x00ff00Tall Grass Apartment^!"
    add_bent_s(2,13,8, "bent_base_txt", msg)
    -- msg = "TON 618 message placeholder"
    -- add_bent_s(?,?,?, "bent_base_txt", msg)
end