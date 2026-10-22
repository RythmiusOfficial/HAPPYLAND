function p.__start(wid)
    p.make_list(wid)

    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Return To Game (ESC or F)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg)
end

--Helper function.
function p.make_list(wid)
    local num_health = ga_get_i("temp.xar.ent.sell_station.health")
    local color_health_vec = ga_get_v("temp.xar.ent.sell_station.health_color");
    local color_health_str = game_color_str.color_vec_to_esc(color_health_vec)
    --
    local num2 = ga_get_i("temp.xar.ent.sell_station.gun2")
    local ammo2 = ga_get_i("xar.player.gun2.ammo")
    local color2_vec = ga_get_v("temp.xar.ent.sell_station.gun2_color")
    local color2_str = game_color_str.color_vec_to_esc(color2_vec)
    --
    local num3 = ga_get_i("temp.xar.ent.sell_station.gun3")
    local ammo3 = ga_get_i("xar.player.gun3.ammo")
    local color3_vec = ga_get_v("temp.xar.ent.sell_station.gun3_color")
    local color3_str = game_color_str.color_vec_to_esc(color3_vec)
    --
    local num4 = ga_get_i("temp.xar.ent.sell_station.gun4")
    local ammo4 = ga_get_i("xar.player.gun4.ammo")
    local color4_vec = ga_get_v("temp.xar.ent.sell_station.gun4_color")
    local color4_str = game_color_str.color_vec_to_esc(color4_vec)
    --
    local num5 = ga_get_i("temp.xar.ent.sell_station.gun5")
    local ammo5 = ga_get_i("xar.player.gun5.ammo")
    local color5_vec = ga_get_v("temp.xar.ent.sell_station.gun5_color")
    local color5_str = game_color_str.color_vec_to_esc(color5_vec)
    --
    local num6 = ga_get_i("temp.xar.ent.sell_station.gun6")
    local ammo6 = ga_get_i("xar.player.gun6.ammo")
    local color6_vec = ga_get_v("temp.xar.ent.sell_station.gun6_color")
    local color6_str = game_color_str.color_vec_to_esc(color6_vec)
    --
    local num7 = ga_get_i("temp.xar.ent.sell_station.gun7")
    local ammo7 = ga_get_i("xar.player.gun7.ammo")
    local color7_vec = ga_get_v("temp.xar.ent.sell_station.gun7_color")
    local color7_str = game_color_str.color_vec_to_esc(color7_vec)
    --
    local num8 = ga_get_i("temp.xar.ent.sell_station.gun8")
    local ammo8 = ga_get_i("xar.player.gun8.ammo")
    local color8_vec = ga_get_v("temp.xar.ent.sell_station.gun8_color")
    local color8_str = game_color_str.color_vec_to_esc(color8_vec)
    --
    local num9 = ga_get_i("temp.xar.ent.sell_station.gun9")
    local ammo9 = ga_get_i("xar.player.gun9.ammo")
    local color9_vec = ga_get_v("temp.xar.ent.sell_station.gun9_color")
    local color9_str = game_color_str.color_vec_to_esc(color9_vec)
    --
    local min_y = 0.15
    local max_y = 0.8
    local char_w = 0.015
    local char_h = 0.03
    local col = {x=0.0, y=0.5, z=0.5}
    local options = {
        color_health_str .. "Press H: 1 gold for each " .. num_health .. "% health above 200%",
        color2_str .. "Press 2: 10 gold for each " .. num2 .. " cannon ammo (".. ammo2 .. " left)",
        color3_str .. "Press 3: 10 gold for each " .. num3 .. " laser ammo (" .. ammo3 .. " left)",
        color4_str .. "Press 4: 10 gold for each " .. num4 .. " rocket ammo (" .. ammo4 .. " left)",
        color5_str .. "Press 5: 10 gold for each " .. num5 .. " homing ammo (" .. ammo5 .. " left)",
        color6_str .. "Press 6: 10 gold for each " .. num6 .. " minigun ammo (" .. ammo6 .. " left)",
        color7_str .. "Press 7: 10 gold for each " .. num7 .. " railgun ammo (" .. ammo7 .. " left)",
        color8_str .. "Press 8: " .. num8 .. " gold for 1 EMP ammo (" .. ammo8 .. " left)",
        color9_str ..  "Press 9: " .. num9 .. " gold for 1 nuke ammo (" .. ammo9 .. " left)",
       "Press \"/\" to sell everything"}
    ga_win_widget_small_list_start(
        wid, min_y, max_y, char_w, char_h,
        col, options)
    ga_win_widget_small_list_set_use_nums(wid, false)
end

function p.__render(wid)
    ga_win_set_background_default(wid)
    ga_win_set_char_size(wid, 0.015, 0.03)

    local gold = ga_get_i("xar.player.gold.amount")
    local gold_str = game_str.add_commas(gold)
    ga_win_txt_center(wid, 0.9, "GOLD IN INVENTORY = " .. gold_str)

    ga_win_set_char_size(wid, 0.01, 0.02)
    ga_win_txt(wid, 0.0, 0.97, "LSHIFT + ENTER TO")
    ga_win_txt(wid, 0.0, 0.94, "SELL ALL OF A CATEGORY")

    local color = ga_get_sys_v("menu.text_color")
    ga_win_set_front_color(wid, color)
end

--Returns true iff sold something.
function p.sell(wid, str, sell_all)
    if sell_all then
        --Doing it over and over until there is no effect.
        local sold_something = false 
        while true do
            local gold_before = ga_get_i("xar.player.gold.amount")
            local sold_something_now = p.sell_helper(wid, str)
            if( sold_something_now ) then sold_something = true end
            local gold_after = ga_get_i("xar.player.gold.amount")
            if( gold_after == gold_before ) then
                return sold_something
            end
        end
    else
        --Doing it once.
        return p.sell_helper(wid, str)
    end
end

--Returns true iff did not run out of money.
function p.sell_helper(wid, str)
    local gold = ga_get_i("xar.player.gold.amount")
    local starting_gold = gold
    local sold = false

    --Todo: rewrite this function.

    if str == "H" then
        local num = ga_get_i("temp.xar.ent.sell_station.health")
        local max_health_1x = ga_get_i("xar.player.health.max")
        local max_health_2x = 2*max_health_1x
        local health = ga_get_i("xar.player.health.amount");
        local health_above_2x = health - max_health_2x
        -- ga_print("health_above_2x = " .. tostring(health_above_2x))
        if( health_above_2x > 0 ) then
            local percent_above_2x = (100.0 * health_above_2x) / (max_health_1x + 0.0)
            local num_add_gold = math.floor(percent_above_2x / num)
            gold = gold + num_add_gold
            ga_set_i("xar.player.health.amount", max_health_2x)
            sold = true
        end
    end
    if str == "2" then
        local num = ga_get_i("temp.xar.ent.sell_station.gun2")
        local ammo = ga_get_i("xar.player.gun2.ammo")
        if (ammo >= num) then
            std.set_bydelta_i("xar.player.gun2.ammo", -num)
            gold = gold + 10
            sold = true
        end
    end
    if str == "3" then
        local num = ga_get_i("temp.xar.ent.sell_station.gun3")
        local ammo = ga_get_i("xar.player.gun3.ammo")
        if (ammo >= num) then
            std.set_bydelta_i("xar.player.gun3.ammo", -num)
            gold = gold + 10
            sold = true
        end
    end
    if str == "4" then
        local num = ga_get_i("temp.xar.ent.sell_station.gun4")
        local ammo = ga_get_i("xar.player.gun4.ammo")
        if (ammo >= num) then
            std.set_bydelta_i("xar.player.gun4.ammo", -num)
            gold = gold + 10
            sold = true
        end
    end
    if str == "5" then
        local num = ga_get_i("temp.xar.ent.sell_station.gun5")
        local ammo = ga_get_i("xar.player.gun5.ammo")
        if (ammo >= num) then
            std.set_bydelta_i("xar.player.gun5.ammo", -num)
            gold = gold + 10
            sold = true
        end
    end
    if str == "6" then
        local num = ga_get_i("temp.xar.ent.sell_station.gun6")
        local ammo = ga_get_i("xar.player.gun6.ammo")
        if (ammo >= num) then
            std.set_bydelta_i("xar.player.gun6.ammo", -num)
            gold = gold + 10
            sold = true
        end
    end
    if str == "7" then
        local num = ga_get_i("temp.xar.ent.sell_station.gun7")
        local ammo = ga_get_i("xar.player.gun7.ammo")
        if (ammo >= num) then
            std.set_bydelta_i("xar.player.gun7.ammo", -num)
            gold = gold + 10
            sold = true
        end
    end
    if str == "8" then
        local num = 1
        local num_gold = ga_get_i("temp.xar.ent.sell_station.gun8")
        local ammo = ga_get_i("xar.player.gun8.ammo")
        if (ammo >= num) then
            std.set_bydelta_i("xar.player.gun8.ammo", -num)
            gold = gold + num_gold
            sold = true
        end
    end
    if str == "9" then
        local num = 1
        local num_gold = ga_get_i("temp.xar.ent.sell_station.gun9")
        local ammo = ga_get_i("xar.player.gun9.ammo")
        if (ammo >= num) then
            std.set_bydelta_i("xar.player.gun9.ammo", -num)
            gold = gold + num_gold
            sold = true
        end
    end

    if (gold ~= starting_gold) then
        ga_set_i("xar.player.gold.amount", gold)
    end

    if( sold ) then
        p.make_list(wid)
    end

    return sold
end

function p.__process_input(wid)
    if( ga_win_widget_go_back_button_process_input(wid) or
        ga_win_key_pressed(wid, "F") )
    then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end

    local starting_gold = ga_get_i("xar.player.gold.amount")
    local selection = ga_win_widget_small_list_process_input(wid) --Not getting selection yet.
    local sel_name = ""
    if( selection >= 0 ) then
        sel_name = ga_win_widget_small_list_get_entry(wid, selection)
    end
    if game_key.pressed_or_spammed(wid, "ENTER") then
        selection = ga_win_widget_small_list_get_selected(wid)
        sel_name = ga_win_widget_small_list_get_entry(wid, selection)
    end
    --
    local sel_str = ""
    if string.match(sel_name, "Press H") or
        game_key.pressed_or_spammed(wid, "H") then sel_str = "H" end
    if string.match(sel_name, "Press 2") or
        game_key.pressed_or_spammed(wid, "2") then sel_str = "2" end
    if string.match(sel_name, "Press 3") or
        game_key.pressed_or_spammed(wid, "3") then sel_str = "3" end
    if string.match(sel_name, "Press 4") or
        game_key.pressed_or_spammed(wid, "4") then sel_str = "4" end
    if string.match(sel_name, "Press 5") or
        game_key.pressed_or_spammed(wid, "5") then sel_str = "5" end
    if string.match(sel_name, "Press 6") or
        game_key.pressed_or_spammed(wid, "6") then sel_str = "6" end
    if string.match(sel_name, "Press 7") or
        game_key.pressed_or_spammed(wid, "7") then sel_str = "7" end
    if string.match(sel_name, "Press 8") or
        game_key.pressed_or_spammed(wid, "8") then sel_str = "8" end
    if string.match(sel_name, "Press 9") or
        game_key.pressed_or_spammed(wid, "9") then sel_str = "9" end
    if string.match(sel_name, "Press \"/\"") or
        game_key.pressed_or_spammed(wid, "/") then sel_str = "/" end
    --
    if sel_str == "/" then
        local sell_all = true
        while p.sell(wid, "H", sell_all) do end
        while p.sell(wid, "2", sell_all) do end
        while p.sell(wid, "3", sell_all) do end
        while p.sell(wid, "4", sell_all) do end
        while p.sell(wid, "5", sell_all) do end
        while p.sell(wid, "6", sell_all) do end
        while p.sell(wid, "7", sell_all) do end
        while p.sell(wid, "8", sell_all) do end
        while p.sell(wid, "9", sell_all) do end
    end
    --Todo: replace all the "fragile" stuff with "ga_win_widget_small_list_set_selected_by_substr".
    local sell_all = ga_win_key_down("LSHIFT")
    if sel_str == "H" then
        p.sell(wid, "H", sell_all)
        ga_win_widget_small_list_set_selected(wid, 0) --Fragile!!!
    end
    if sel_str == "2" then
        p.sell(wid, "2", sell_all)
        ga_win_widget_small_list_set_selected(wid, 1) --Fragile!!!
    end
    if sel_str == "3" then
        p.sell(wid, "3", sell_all)
        ga_win_widget_small_list_set_selected(wid, 2) --Fragile!!!
    end
    if sel_str == "4" then
        p.sell(wid, "4", sell_all)
        ga_win_widget_small_list_set_selected(wid, 3) --Fragile!!!
    end
    if sel_str == "5" then
        p.sell(wid, "5", sell_all)
        ga_win_widget_small_list_set_selected(wid, 4) --Fragile!!!
    end
    if sel_str == "6" then
        p.sell(wid, "6", sell_all)
        ga_win_widget_small_list_set_selected(wid, 5) --Fragile!!!
    end
    if sel_str == "7" then
        p.sell(wid, "7", sell_all)
        ga_win_widget_small_list_set_selected(wid, 6) --Fragile!!!
    end
    if sel_str == "8" then
        p.sell(wid, "8", sell_all)
        ga_win_widget_small_list_set_selected(wid, 7) --Fragile!!!
    end
    if sel_str == "9" then
        p.sell(wid, "9", sell_all)
        ga_win_widget_small_list_set_selected(wid, 8) --Fragile!!!
    end

    local ending_gold = ga_get_i("xar.player.gold.amount")

    --Playing a sound based on how much gold way gained.
    local gold_diff = ending_gold - starting_gold
    if gold_diff >= 1000 then
        ga_play_sound("pickup_gold_large")
    elseif gold_diff >= 100 then
        ga_play_sound("pickup_gold_medium")
    elseif gold_diff > 0 then
        ga_play_sound("pickup_gold_small")
    end
end
