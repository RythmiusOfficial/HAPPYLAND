--Helper.
function p.txt_col(wid, col)
    ga_win_set_front_color(wid, col)
end

function p.interp_col(col1, col2, frac)
    col = {x=0, y=0, z=0}
    col.x = (1.0 - frac)*col1.x + frac*col2.x
    col.y = (1.0 - frac)*col1.y + frac*col2.y
    col.z = (1.0 - frac)*col1.z + frac*col2.z
    return col
end

function p.__render(wid)
    ga_win_set_char_size(wid, 0.012, 0.024)

    col_white  = std.vec(1.0, 1.0, 1.0)
    col_red    = std.vec(1.0, 0.0, 0.0)
    col_yellow = std.vec(1.0, 1.0, 0.0)
    col_green  = std.vec(0.0, 1.0, 0.0)
    col_blue   = std.vec(0.0, 0.25, 1.0)
    col_cyan   = std.vec(0.0, 1.0, 1.0)

    --Lower left message.
    ga_win_set_char_size(wid, 0.015, 0.03)
    p.txt_col(wid, col_green)
    for i = 1,5 do
        prefix = "blank.messages.slot" .. tostring(i)
        msg = ga_get_s(prefix .. ".msg")
        ttl = ga_get_f(prefix .. ".ttl")
        --
        col = col_white
        if ttl < 4.0 then col = col_green end
        if( ttl > 4.0 and ttl < 5.0 ) then
            col = p.interp_col(col_green,col_white,ttl-4.0)
        end
        p.txt_col(wid, col)
        --
        min_x = 0.01
        min_y = 0.25 + 0.033*(i-1)
        alpha_fade = 1.0
        if( ttl < 1.0 and ttl >= 0.0 ) then alpha_fade = ttl end
        if ttl > 0.0 then
            local color = std.vec(0.0,0.0,0.0)
            local back_alpha = 0.4 * alpha_fade
            local front_alpha = 1.0 * alpha_fade
            ga_win_set_back_params(wid, color, back_alpha,back_alpha)
            ga_win_txt_alpha_bg(wid, min_x, min_y, front_alpha, msg)
        end
    end

    -- Icons.
    icon_bot = 0.13
    icon_top = icon_bot + 0.08
    icon_width = 0.05
    step_x = icon_width + 0.01
    cur_x = 0.01
        if ga_get_b("blank.movement.rocket") then
        tex = "icon_rocket"
        ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
        cur_x = cur_x + step_x
    end

    if ga_get_b("blank.movement.brake") then
        tex = "icon_brake"
        ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
        cur_x = cur_x + step_x
    end    

    --more!!!
end
