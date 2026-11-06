function p.__get_is_solid() return false end
function p.__get_tex() return "block_water" end
function p.__get_is_solid_move_body() return false end
function p.__get_is_solid_visibly() return false end
function p.__get_is_solid_visibly_water() return true end
function p.__get_is_partially_transparent() return true end
function p.__main() set_default_block("block_water") end