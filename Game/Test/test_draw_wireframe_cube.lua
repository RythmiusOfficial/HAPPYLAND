--Uncomment the following __render_augmented
--function to have the game
--render a red cube adjacent to the cube that the player
--is looking at.
--
-- function p.__render_augmented(level)
--     p.render_augmented_helper()
-- end

function p.render_augmented_helper()
    --Drawing a wireframe cube.
    if( not ga_look_object_block_exists() ) then return end
    local look_block_chunk_id = ga_look_object_block_get_chunk_id()
    local look_block_lbp = ga_look_object_block_get_lbp()
    local vcp = ga_chunk_id_to_vcp(look_block_chunk_id)
    local bp = ga_lbp_to_bp(vcp, look_block_lbp)
    local level = ga_get_viewer_level()
    local normal_side = ga_look_object_block_get_normal_side()
    local bp2 = std.get_adj_bp(bp, normal_side)
    ga_render_color( std.vec(1.0, 0.0, 0.0) ) --Red
    p.draw_cube(bp2)
end

function p.draw_cube(bp)
    local thickness = 3.0
    --
    for i = 0,1 do
    for j = 0,1 do
        local v1 = p.corner(bp, i,j,0)
        local v2 = p.corner(bp, i,j,1)
        ga_render_line_thick(v1, v2, thickness)
    end end
    --
    for i = 0,1 do
    for k = 0,1 do
        local v1 = p.corner(bp, i,0,k)
        local v2 = p.corner(bp, i,1,k)
        ga_render_line_thick(v1, v2, thickness)
    end end
    --
    for j = 0,1 do
    for k = 0,1 do
        local v1 = p.corner(bp, 0,j,k)
        local v2 = p.corner(bp, 1,j,k)
        ga_render_line_thick(v1, v2, thickness)
    end end
end

--i,j,k should each be 0 or 1.
function p.corner(v, i,j,k)
    local eps = 0.02
    --
    local x = v.x + eps
    if i == 1 then x = v.x + 1.0 - eps end
    --
    local y = v.y + eps
    if j == 1 then y = v.y + 1.0 - eps end
    --
    local z = v.z + eps
    if k == 1 then z = v.z + 1.0 - eps end
    --
    return std.vec(x,y,z)
end
