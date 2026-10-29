function p.__get_is_solid()
    return true
end

function p.__get_tex()
    return "block_glass"
end

function p.__get_is_solid_visibly()
    return false
end

function p.__get_is_solid_visibly_glass()
    return true
end

function p.__main()
    set_default_block("glass")
end