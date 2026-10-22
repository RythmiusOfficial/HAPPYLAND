--wid = window id.
function p.__render(wid)
    --Covering the screen with a transparent layer.
    --Note that this window is applied before the usual hud.
    -- p.render_green_layer(wid) --Put this back in!
end

function p.render_green_layer(wid)
    local min_x = 0.0
    local min_y = 0.0
    local max_x = 0.0
    local max_y = 0.0
    local green = std.vec(0.0, 1.0, 0.0)
    local alpha = 0.5
    ga_win_quad_color_alpha(wid, 0.0, 0.0, 1.0, 1.0, green, alpha)
end
