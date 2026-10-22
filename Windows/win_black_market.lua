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
    local ammo7 = ga_get_i("xar.player.gun7.ammo")
    local ammo8 = ga_get_i("xar.player.gun8.ammo")
    local ammo9 = ga_get_i("xar.player.gun9.ammo")
    --
    local min_y = 0.4
    local max_y = 0.6
    local char_w = 0.015
    local char_h = 0.03
    local col = {x=0.0, y=0.5, z=0.5}
    local options = {
        "Press 7: 50 railgun ammo for 100 gold. (cur ammo = " .. ammo7 .. ")",
        "Press 8: 2 EMP ammo for 100 gold. (cur ammo = " .. ammo8 .. ")",
        "Press 9: 2 Nuke ammo for 100 gold. (cur ammo = " .. ammo9 .. ")"}
    ga_win_widget_small_list_start(
        wid, min_y, max_y, char_w, char_h,
        col, options)
    ga_win_widget_small_list_set_use_nums(wid, false)
    ga_win_widget_small_list_mute_sound(wid, "select")
end

function p.__render(wid)
    ga_win_set_background_default(wid)
    ga_win_set_char_size(wid, 0.015, 0.03)

    local gold = ga_get_i("xar.player.gold.amount")
    local gold_str = game_str.add_commas(gold)
    ga_win_txt_center(wid, 0.9, "GOLD IN INVENTORY = " .. gold_str)
end

function p.__process_input(wid)
    if( ga_win_widget_go_back_button_process_input(wid) or
        ga_win_key_pressed(wid, "F") )
    then
        ga_play_sound("menu_back")
        ga_window_pop()
        return
    end

    local gold = ga_get_i("xar.player.gold.amount")
    local gold_delta = 0
    
    local selection = ga_win_widget_small_list_process_input(wid)
    local sel_name = ""
    if( selection >= 0 ) then
        sel_name = ga_win_widget_small_list_get_entry(wid, selection)
    end
    if game_key.pressed_or_spammed(wid, "ENTER") then
        selection = ga_win_widget_small_list_get_selected(wid)
        sel_name = ga_win_widget_small_list_get_entry(wid, selection)
    end
    local sel_str = ""
    if string.match(sel_name, "Press 7") or
        game_key.pressed_or_spammed(wid, "7")
    then
        sel_str = "7"
    end
    if string.match(sel_name, "Press 8") or
        game_key.pressed_or_spammed(wid, "8")
    then
        sel_str = "8"
    end
    if string.match(sel_name, "Press 9") or
        game_key.pressed_or_spammed(wid, "9")
    then
        sel_str = "9"
    end

    if sel_str == "7" then
        local price = 2
        for i = 1,50 do
            local ammo = ga_get_i("xar.player.gun7.ammo")
            local ammo_max = game_wep_modes.get_ammo_max(7)
            if (gold >= price and ammo < ammo_max) then
                ammo = ammo + 1
                gold_delta = gold_delta - price
            end
            ga_set_i("xar.player.gun7.ammo", ammo)
        end
        p.make_list(wid)
        ga_win_widget_small_list_set_selected(wid, 0) --Fragile!!!
    end

    if sel_str == "8" then
        local price = 50
        for i = 1,2 do
            local ammo = ga_get_i("xar.player.gun8.ammo")
            local ammo_max = game_wep_modes.get_ammo_max(8)
            if (gold >= price and ammo < ammo_max) then
                ammo = ammo + 1
                gold_delta = gold_delta - price
            end
            ga_set_i("xar.player.gun8.ammo", ammo)
        end
        p.make_list(wid)
        ga_win_widget_small_list_set_selected(wid, 1) --Fragile!!!
    end

    if sel_str == "9" then
        local price = 50
        for i = 1,2 do
            local ammo = ga_get_i("xar.player.gun9.ammo")
            local ammo_max = game_wep_modes.get_ammo_max(9)
            if (gold >= price and ammo < ammo_max) then
                ammo = ammo + 1
                gold_delta = gold_delta - price
            end
            ga_set_i("xar.player.gun9.ammo", ammo)
        end
        p.make_list(wid)
        ga_win_widget_small_list_set_selected(wid, 2) --Fragile!!!
    end

    if (gold_delta ~= 0) then
        std.set_bydelta_i("xar.player.gold.amount", gold_delta)
        ga_play_sound("buy")
    end
end
