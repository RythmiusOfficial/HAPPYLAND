function p.__get_is_solid()
    return false
end

function p.__get_tex()
    return ""
end

function p.__main()
    set_default_block("landlord_office_air_guard")

    ment_start(7,7,7, "ment_key_guard_apartment")
    ment_set_offset(8,8,8)
    ment_end()
end