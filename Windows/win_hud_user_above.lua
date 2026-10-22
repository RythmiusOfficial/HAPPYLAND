--wid = window id.
function p.__render(wid)
    --Covering the hud with a blue transparant later.
    -- p.render_blue_layer(wid) --Put this back in!
end

function p.render_blue_layer(wid)
    local min_x = 0.0
    local min_y = 0.0
    local max_x = 0.0
    local max_y = 0.0
    local blue = std.vec(0.0, 0.0, 0.5)
    local alpha = 0.5
    ga_win_quad_color_alpha(wid, 0.0, 0.0, 1.0, 1.0, blue, alpha)
end
