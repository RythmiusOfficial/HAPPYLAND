function p.__get_is_solid()
    return true
end

function p.__get_tex() return "block_chain" end

function p.__get_is_solid_visibly() return false end

function p.__get_is_solid_visibly_water() return true end

function p.__get_tex_z_pos() return "block_blank" end

function p.__get_tex_z_neg() return "block_blank" end

function p.__get_inv_tex_x_pos() return "block_chain" end

function p.__get_inv_tex_x_neg() return "block_chain" end

function p.__get_inv_tex_y_pos() return "block_chain" end

function p.__get_inv_tex_y_neg() return "block_chain" end

function p.__main()
    set_default_block("chain")
end