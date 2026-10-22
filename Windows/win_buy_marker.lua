local main_button_handle = 1

--Helper function.
function p.price_helper(price)
    local num = 10
    if (price == 1) then num = 100 end
    if (price == 2) then num = 50 end
    return num
end

function p.__start(wid)
    local price = ga_get_i("temp.xar.ent.buy_marker.price")
    local num = p.price_helper(price)
    local cost = num * price
    local txt = "PRESS ENTER: BUY " .. num .. " MARKERS FOR " .. cost .. " GOLD"
    ga_win_widget_button_start(wid, main_button_handle, 0.0, 0.5, 0.02, 0.04, txt)
    ga_win_widget_button_center_x_at(wid, main_button_handle, 0.5)

    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Return To Game (ESC or F)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg)
end


function p.__render(wid)
    ga_win_set_background_default(wid)

    local gold = ga_get_i("xar.player.gold.amount")
    local gold_str = game_str.add_commas(gold)
    ga_win_txt_center(wid, 0.9, "GOLD IN INVENTORY = " .. gold_str)

    local inv_markers = ga_get_i("xar.player.markers.num_short")
    ga_win_txt_center(wid, 0.8, "MARKERS IN INVENTORY = " .. inv_markers)
end

function p.__process_input(wid)
    if( ga_win_widget_go_back_button_process_input(wid) or
        ga_win_key_pressed(wid, "F") )
    then
        ga_play_sound("menu_back")
        ga_window_pop()
    end

    local which_button = ga_win_widget_button_process_input(wid)

    if( which_button == main_button_handle or 
        game_key.pressed_or_spammed(wid, "ENTER") )
    then
        local price = ga_get_i("temp.xar.ent.buy_marker.price")
        local num = p.price_helper(price)
        local cost = num * price
        local gold = ga_get_i("xar.player.gold.amount")
        if (gold >= cost) then
            local new_gold = gold - cost
            ga_set_i("xar.player.gold.amount", new_gold)
            std.set_bydelta_i("xar.player.markers.num_short", num)
            ga_play_sound("buy")
        end
    end
end
