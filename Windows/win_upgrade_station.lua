p.price = {}
p.price["1"] = 100
p.price["2"] = 100
p.price["3"] = 100
p.price["4"] = 100
p.price["7"] = 200
p.price["8"] = 100
p.price["9"] = 200
p.price["0"] = 300
p.price["H"] = 200
p.price["R"] = 100

function p.price_colored(letter)
    local value = p.price[letter]
    local value_str = tostring(value)
    local prefix = ""
    if( value >= 200 ) then prefix = "^xffff00" end
    if( value >= 300 ) then prefix = "^xff0000" end
    return prefix .. value_str .. "^!"
end

function p.__start(wid)
    p.refresh_options(wid)

    local go_back_button_y = 0.06
    local w = 0.02
    local h = 0.04
    local go_back_msg = "Return To Game (ESC or F)"
    ga_win_widget_go_back_button_start(
        wid, go_back_button_y, w, h, go_back_msg)
end

--Helper function
function p.upgrade_str(letter)
    local var = ""
    if( letter == "H" ) then
        var = "xar.player.health.level"
    elseif( letter == "R" ) then
        var = "xar.player.health.regen_level"
    else
        --Could do a check.
        var = "xar.player.gun" .. letter .. ".damage_level"
    end
    return "(cur = " .. tostring(ga_get_i(var)) .. ")"
end

--Helper function.
function p.refresh_options(wid)
    local min_y = 0.2
    local max_y = 0.8
    local char_w = 0.015
    local char_h = 0.03
    local col = {x=0.0, y=0.5, z=0.5}
    local options = {
        "Press 1: plasma damage upgrade for "    .. p.price_colored("1") .. " gold " .. p.upgrade_str("1"),
        "Press 2: cannon damage upgrade for "    .. p.price_colored("2") .. " gold " .. p.upgrade_str("2"),
        "Press 3: laser damage upgrade for "     .. p.price_colored("3") .. " gold " .. p.upgrade_str("3"),
        "Press 4: rocket damage upgrade for "    .. p.price_colored("4") .. " gold " .. p.upgrade_str("4"),
        "Press 7: railgun damage upgrade for "   .. p.price_colored("7") .. " gold " .. p.upgrade_str("7"),
        "Press 8: EMP damage upgrade for "       .. p.price_colored("8") .. " gold " .. p.upgrade_str("8"),
        "Press 9: nuke damage upgrade for "      .. p.price_colored("9") .. " gold " .. p.upgrade_str("9"),
        "Press 0: dark hole damage upgrade for " .. p.price_colored("0") .. " gold " .. p.upgrade_str("0"),
        "Press H: health max upgrade for "       .. p.price_colored("H") .. " gold " .. p.upgrade_str("H"),
        "Press R: health regen upgrade for "     .. p.price_colored("R") .. " gold " .. p.upgrade_str("R")}
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

    --Getting which option was selected.
    local selection = ga_win_widget_small_list_process_input(wid)
    local sel_name = ""
    if( selection >= 0 ) then
        sel_name = ga_win_widget_small_list_get_entry(wid, selection)
    end
    local sel_letter = ""
    for k,_ in pairs(p.price) do
        --k should be "1", "2", ..., "H", or "R".
       if(  string.match(sel_name, "Press " .. k) or
            game_key.pressed_or_spammed(wid, k) )
        then
            sel_letter = k
        end
    end

    p.try_buy(wid, sel_letter)
end

function p.try_buy(wid, letter)
    if( letter == nil or
        letter == "" )
    then
        return
    end
    local option_price = p.price[letter]
    if( option_price == nil ) then return end
    local gold = ga_get_i("xar.player.gold.amount")
    if (gold >= option_price) then
        --Losing gold.
        std.set_bydelta_i("xar.player.gold.amount", -option_price)
        --Getting the upgrde.
        local var = ""
        if( letter == "H" ) then
            var = "xar.player.health.level"
        elseif( letter == "R" ) then
            var = "xar.player.health.regen_level"
        else
            --Could do a check.
            var = "xar.player.gun" .. letter .. ".damage_level"
        end
        std.set_bydelta_i(var, 1)
        ga_play_sound("pickup_upgrade")
        --The widget.
        p.refresh_options(wid)
    end
    --Moving the widget selection box.
    local substr = "Press " .. letter
    ga_win_widget_small_list_set_selected_by_substr(wid, substr)
end
