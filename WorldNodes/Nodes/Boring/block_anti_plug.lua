function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("e")
    create_rect("r_anti", 0,0,12, 15,15,15)
    create_rect("e", 6,6,12, 8,8,13)

    local msg = "This is an ^xff0000Anti-Plug.^!\n"
        .. "You need to be at a larger size in order to pass through here."

    add_bent_s(7,7,12, "bent_base_txt", msg)
end
