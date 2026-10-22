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
    local ammo2 = ga_get_i("xar.player.gun2.ammo");
    local ammo3 = ga_get_i("xar.player.gun3.ammo");
    local ammo4 = ga_get_i("xar.player.gun4.ammo");
    local ammo5 = ga_get_i("xar.player.gun5.ammo");
    local ammo6 = ga_get_i("xar.player.gun6.ammo");
    local ammo7 = ga_get_i("xar.player.gun7.ammo");
    local ammo8 = ga_get_i("xar.player.gun8.ammo");
    --
    local min_y = 0.15
    local max_y = 0.8
    local char_w = 0.015
    local char_h = 0.03
    local col = {x=0.0, y=0.5, z=0.5}
    local options = {
        "Press 2: 20 cannon ammo for 100 gold (cur ammo = " .. ammo2 .. ")",
        "Press 3: 100 laser ammo for 100 gold (cur ammo = " .. ammo3 .. ")",
        "Press 4: 50 rocket ammo for 100 gold (cur ammo = " .. ammo4 .. ")",
        "Press 5: 1000 homing ammo for 100 gold (cur ammo = " .. ammo5 .. ")",
        "Press 6: 100 minigun ammo for 100 gold (cur ammo = " .. ammo6 .. ")",
        "Press 7: 20 railgun ammo for 100 gold (cur ammo = " .. ammo7 .. ")",
        "Press 8: 1 EMP ammo for 100 gold (cur ammo = " .. ammo8 .. ")",
        "Press H: 200% health for 100 gold",
        -- "Press A: 100% armor for 100 gold", --Too sucky and annoying.
        -- "Press B: 150% armor for 150 gold", --Too sucky and annoying.
        "Press C: 200% armor for 100 gold"}
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

    --Todo: rewrite this code:
    --See what we do in "win_upgrade_station.lua".

    local gold = ga_get_i("xar.player.gold.amount")
    local starting_gold = gold

    local selection = ga_win_widget_small_list_process_input(wid) --Not getting selection yet.
    local sel_name = ""
    if( selection >= 0 ) then
        sel_name = ga_win_widget_small_list_get_entry(wid, selection)
    end
    if game_key.pressed_or_spammed(wid, "ENTER") then
        selection = ga_win_widget_small_list_get_selected(wid)
    end
    local sel_name = ga_win_widget_small_list_get_entry(wid, selection)
    --
    local sel_str = ""
    --
    if sel_name:find("^Press 2") ~= nil or
        game_key.pressed_or_spammed(wid, "2") then sel_str = "2" end
    if sel_name:find("^Press 3") ~= nil or
        game_key.pressed_or_spammed(wid, "3") then sel_str = "3" end
    if sel_name:find("^Press 4") ~= nil or
        game_key.pressed_or_spammed(wid, "4") then sel_str = "4" end
    if sel_name:find("^Press 5") ~= nil or
        game_key.pressed_or_spammed(wid, "5") then sel_str = "5" end
    if sel_name:find("^Press 6") ~= nil or
        game_key.pressed_or_spammed(wid, "6") then sel_str = "6" end
    if sel_name:find("^Press 7") ~= nil or
        game_key.pressed_or_spammed(wid, "7") then sel_str = "7" end
    if sel_name:find("^Press 8") ~= nil or
        game_key.pressed_or_spammed(wid, "8") then sel_str = "8" end
    if sel_name:find("^Press H") ~= nil or
        game_key.pressed_or_spammed(wid, "H") then sel_str = "H" end
    if sel_name:find("^Press C") ~= nil or
        game_key.pressed_or_spammed(wid, "C") then sel_str = "C" end

    if sel_str == "2" and game_can_use.main(2) then
        local price = 5
        for i = 1,20 do
            local ammo = ga_get_i("xar.player.gun2.ammo")
            local ammo_max = game_wep_modes.get_ammo_max(2)
            if (gold >= price and ammo < ammo_max) then
                ammo = ammo + 1
                gold = gold - price
            end
            ga_set_i("xar.player.gun2.ammo", ammo)
        end
        p.make_list(wid)
        ga_win_widget_small_list_set_selected(wid, 0) --Fragile!!!
    end
    if sel_str == "3" and game_can_use.main(3) then
        local price = 1
        for i = 1,100 do
            local ammo = ga_get_i("xar.player.gun3.ammo")
            local ammo_max = game_wep_modes.get_ammo_max(3)
            if (gold >= price and ammo < ammo_max) then
                ammo = ammo + 1
                gold = gold - price
            end
            ga_set_i("xar.player.gun3.ammo", ammo)
        end
        p.make_list(wid)
        ga_win_widget_small_list_set_selected(wid, 1) --Fragile!!!
    end
    if sel_str == "4" and game_can_use.main(4) then
        local price = 2
        for i = 1,50 do
            local ammo = ga_get_i("xar.player.gun4.ammo")
            local ammo_max = game_wep_modes.get_ammo_max(4)
            if (gold >= price and ammo < ammo_max) then
                ammo = ammo + 1
                gold = gold - price
            end
            ga_set_i("xar.player.gun4.ammo", ammo)
        end
        p.make_list(wid)
        ga_win_widget_small_list_set_selected(wid, 2) --Fragile!!!
    end
    if sel_str == "5" and game_can_use.main(5) then
        local price = 1 --one gold per 10 ammo.
        for i = 1,100 do
            local ammo = ga_get_i("xar.player.gun5.ammo")
            local ammo_max = game_wep_modes.get_ammo_max(5)
            if (gold >= price and ammo < ammo_max) then
                ammo = ammo + 10
                if( ammo > ammo_max ) then ammo = ammo_max end
                gold = gold - price
            end
            ga_set_i("xar.player.gun5.ammo", ammo)
        end
        p.make_list(wid)
        ga_win_widget_small_list_set_selected(wid, 3) --Fragile!!!
    end
    if sel_str == "6" and game_can_use.main(6) then
        local price = 1
        for i = 1,100 do
            local ammo = ga_get_i("xar.player.gun6.ammo")
            local ammo_max = game_wep_modes.get_ammo_max(6)
            if (gold >= price and ammo < ammo_max) then
                ammo = ammo + 1
                gold = gold - price
            end
            ga_set_i("xar.player.gun6.ammo", ammo)
        end
        p.make_list(wid)
        ga_win_widget_small_list_set_selected(wid, 4) --Fragile!!!
    end
    if sel_str == "7" and game_can_use.main(7) then
        local price = 5
        for i = 1,20 do
            local ammo = ga_get_i("xar.player.gun7.ammo")
            local ammo_max = game_wep_modes.get_ammo_max(7)
            if (gold >= price and ammo < ammo_max) then
                ammo = ammo + 1
                gold = gold - price
            end
            ga_set_i("xar.player.gun7.ammo", ammo)
        end
        p.make_list(wid)
        ga_win_widget_small_list_set_selected(wid, 5) --Fragile!!!
    end
    if sel_str == "8" and game_can_use.main(8) then
        local price = 100
        for i = 1,1 do
            local ammo = ga_get_i("xar.player.gun8.ammo")
            local ammo_max = game_wep_modes.get_ammo_max(8)
            if (gold >= price and ammo < ammo_max) then
                ammo = ammo + 1
                gold = gold - price
            end
            ga_set_i("xar.player.gun8.ammo", ammo)
        end
        p.make_list(wid)
        ga_win_widget_small_list_set_selected(wid, 6) --Fragile!!!
    end
    if sel_str == "H" then
        local price = 100
        local old_health = ga_get_i("xar.player.health.amount")
        local max_health = ga_get_i("xar.player.health.max")
        if( gold >= price and
            old_health < 2*max_health )
        then
            ga_set_i("xar.player.health.amount", 2*max_health)
            gold = gold - price
        end
        p.make_list(wid)
        ga_win_widget_small_list_set_selected(wid, 7) --Fragile!!!
    end
    if sel_str == "C" then
        local price = 100
        local old_armor = ga_get_i("xar.player.armor.amount")
        local max_health = ga_get_i("xar.player.health.max")
        if( gold >= price and
            old_armor < 2*max_health )
        then
            ga_set_i("xar.player.armor.amount", 2*max_health)
            gold = gold - price
        end
        p.make_list(wid)
        ga_win_widget_small_list_set_selected(wid, 8) --Fragile!!!
    end

    if (gold ~= starting_gold) then
        ga_set_i("xar.player.gold.amount", gold)
        ga_play_sound("buy")
    end
end
