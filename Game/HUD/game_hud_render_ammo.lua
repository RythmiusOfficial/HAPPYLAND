function p.set_txt_size(wid)
    ga_win_set_char_size(wid, 0.012, 0.024)
end

function p.get_ammo_y_min() return 0.01 end
function p.get_ammo_width() return 0.059 end
function p.get_ammo_height() return 0.086 end

function p.render_ammo(wid)
    game_hud_render_ammo.set_txt_size(wid)

    local ammo_y_min = p.get_ammo_y_min()
    local ammo_width = p.get_ammo_width()
    local ammo_height = p.get_ammo_height()

    local col_red    = std.vec(1.0, 0.0, 0.0)
    local col_yellow = std.vec(1.0, 1.0, 0.0)
    local col_green  = std.vec(0.0, 1.0, 0.0)

    --Ammo.
    for raw_num = 1,10 do
        local num = raw_num
        if (num == 10) then num = 0 end

        local ammo_x_delta = 0.065
        local x_min = 0.21 + ammo_x_delta * (raw_num-1)
        local x_max = x_min + ammo_width
        local y_min = ammo_y_min
        local y_max = y_min + ammo_height

        local cur_wep = ga_get_i("xar.player.cur_wep")
        if ( (raw_num%10) == cur_wep) then
            local add = 0.02
            y_min = y_min + add
            y_max = y_max + add
        end

        local ammo_var = "xar.player.gun" .. num .. ".ammo"
        local ammo     = ga_get_i(ammo_var)
        local ammo_max = game_wep_modes.get_ammo_max(num)

        --GET RID OF SLASHES!!!
        tex1 = "ammo_gun" .. num 
        tex2 = tex1 .. "_grey"
        frac = (ammo / ammo_max)
        if ga_get_b("xar.hud.show_ammo") and (not game_genesis.enabled()) then
            ga_win_quad_two(wid, x_min, y_min, x_max, y_max,
                tex1, tex2, frac)
        end

        local col = col_green
        if     (ammo < ammo_max/4) then col = col_red
        elseif (ammo < ammo_max/2) then col = col_yellow
        else                            col = col_green
        end
        if ga_get_b("xar.hud.show_ammo") and (not game_genesis.enabled()) then
            win_hud.txt_col(wid, col)
            local short_str = game_str.make_3_digit_big(ammo)
            ga_win_txt_center_at_bg(wid, 
                x_min + 0.5 * ammo_width,
                y_max, short_str)
        end
    end
end
