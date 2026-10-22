function p.render_identified_ment(wid)
    if( not ga_exists("temp.identify_ment") ) then return end
    
    local identified_ment_inst_id = ga_get_i("temp.identify_ment")
    if( identified_ment_inst_id >= 0 and
        ga_ment_exists(identified_ment_inst_id) )
    then
        local type = ga_ment_get_type(identified_ment_inst_id)
        if( type ~= "MENT_NOT_FOUND" ) then
            local has_health = game_ment_identify.has_health()
            local txt_color = std.vec(1.0, 1.0, 1.0)
            local back_color1 = std.vec(0.9, 0.0, 0.0)
            local back_color2 = std.vec(0.0, 0.0, 0.0)
            if( not has_health ) then
                back_color1 = std.vec(0.0, 0.0, 1.0)
                back_color2 = std.vec(0.0, 0.0, 1.0)
            end

            local base_str = game_ment_identify.get_str()
            local health = game_ment_identify.get_health()
            local max_health = game_ment_identify.get_max_health()
            if( health < 0 ) then health = 0 end
            if( health > max_health ) then health = max_health end
            local health_str = game_str.make_3_digit_big(health)
            local id_str = base_str .. ": " .. health_str
            if( not has_health or
                ga_ment_static_b_exists_and_true(type, "identity_str_no_health") )
            then
                id_str = base_str
                back_color1 = std.vec(0.0, 0.0, 1.0)
                back_color2 = back_color1
            end
            local id_min_x = ga_win_get_center_text_min_x(0.02, string.len(id_str))
            local id_max_x = 1.0 - id_min_x
            local eps = 0.005
            local frac = health / max_health
            if( max_health == 0 ) then frac = 0 end
            local mid = (1.0 - frac) * (id_min_x-eps) + frac * (id_max_x+eps)
            --
            local min_y = 0.84
            ga_win_quad_color(
                wid,
                id_min_x - eps,     --Min X
                min_y - eps,        --Min Y
                id_max_x + eps,     --Max X
                min_y + 0.03 + eps, --Max Y
                back_color2)
            ga_win_quad_color(
                wid,
                id_min_x - eps,      --Min X
                min_y - eps,         --Min Y
                mid,                 --Max X
                min_y + 0.03 + eps,  --Max Y
                back_color1)
            ga_win_set_front_color(wid, std.vec(1.0, 1.0, 1.0))
            ga_win_txt_center(wid, min_y, id_str)
        end
    end
end
