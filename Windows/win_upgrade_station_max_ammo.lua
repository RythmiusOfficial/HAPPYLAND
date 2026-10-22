--File: win_upgrade_station_max_ammo.lua

--Do not access from the outside.
p.price = {}
p.price[1] = 1000
p.price[2] = 1000
p.price[4] = 1000
p.price[5] = 1000
p.price[6] = 1000
p.price[7] = 3000
p.price[8] = 3000
p.price[9] = 3000
p.price[0] = 3000

--Returns a table with 3 members:
--  is_valid (bool)
--  level    (int)
--  bp       (block position).
function p.get_bent_location()
    local ret = {}
    --The chunk_id of the bent is communicated via a global variable.
    local chunk_id = ga_get_i("temp.xar.upgrade_station_max_ammo.chunk_id")
    --Kind of gross:
    local data = ga_search_for_bent_in_chunk(chunk_id, "bent_upgrade_station_max_ammo")
    ret.is_valid = data.is_valid
    if( not data.is_valid ) then return -1 end
    --
    local lbp = data.value
    ret.level = ga_chunk_id_to_level(chunk_id)
    ret.bp = ga_chunk_id_and_lbp_to_bp(chunk_id, lbp)
    return ret
end

function p.get_num_charges()
    ga_print("win_upgrade_station_max_ammo.get_num_charges 1")
    local location = p.get_bent_location()
    if( not location.is_valid ) then return -1 end
    ga_print("win_upgrade_station_max_ammo.get_num_charges 2")
    ga_print("win_upgrade_station_max_ammo: level = " .. tostring(location.level))
    ga_print("win_upgrade_station_max_ammo: bp = " .. std.vec_to_str(location.bp))
    local param = ga_bent_get_param_i(
        location.level,
        location.bp)
    ga_print("win_upgrade_station_max_ammo: param = " .. tostring(param))
    return param
end

function p.set_num_charges_by_delta(delta)
    local location = p.get_bent_location()
    if( not location.is_valid ) then return -1 end
    local old_value = ga_bent_get_param_i(
        location.level,
        location.bp)
    local new_value = old_value + delta
    local rl = 100 * 1000 * 60*60 --Revert length (100K hours).
    ga_bent_set_param_i(
        location.level,
        location.bp,
        new_value,
        rl)
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
function p.upgrade_str(gun)
    local var = "xar.player.gun" .. tostring(gun) .. ".ammo_level"
    local value = ga_get_i(var)
    return "(cur = " .. tostring(value) .. ")"
end

function p.refresh_options(wid)
    local min_y = 0.2
    local max_y = 0.8
    local char_w = 0.015
    local char_h = 0.03
    local color = {x=0.0, y=0.5, z=0.5}
    local options = {
        "Press 1: plasma max ammo upgrade for 1000 gold " .. p.upgrade_str(1),
        "Press 2: cannon max ammo upgrade for 1000 gold " .. p.upgrade_str(2),
        "Press 4: rocket max ammo upgrade for 1000 gold " .. p.upgrade_str(4),
        "Press 5: homing max ammo upgrade for 1000 gold " .. p.upgrade_str(5),
        "Press 6: minigun max ammo upgrade for 1000 gold " .. p.upgrade_str(6),
        "Press 7: railgun max ammo upgrade for ^xff00003000^! gold " .. p.upgrade_str(7),
        "Press 8: EMP max ammo upgrade for ^xff00003000^! gold " .. p.upgrade_str(8),
        "Press 9: nuke max ammo upgrade for ^xff00003000^! gold " .. p.upgrade_str(9),
        "Press 0: dark hole max ammo upgrade for ^xff00003000^! gold " .. p.upgrade_str(0) }
    ga_win_widget_small_list_start(
        wid, min_y, max_y, char_w, char_h,
        color, options)
    ga_win_widget_small_list_set_use_nums(wid, false)
    ga_win_widget_small_list_mute_sound(wid, "select")
end

function p.__render(wid)
    ga_win_set_background_default(wid)
    ga_win_set_char_size(wid, 0.015, 0.03)

    local gold = ga_get_i("xar.player.gold.amount")
    local gold_str = game_str.add_commas(gold)
    ga_win_txt_center(wid, 0.9, "GOLD IN INVENTORY = " .. gold_str)

    local num_charges = p.get_num_charges()
    if( num_charges <= 0 ) then
        local color_red = std.vec(1.0, 0.0, 0.0)
        ga_win_set_front_color(wid, color_red)
    end
    ga_win_txt_center(wid, 0.85, "CHARGES LEFT = " .. tostring(num_charges))
    ga_win_set_front_color_default(wid)
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
    local gun = -1
    if sel_name ~= "" then
        _, _, gun_str = string.find(sel_name, "Press (%d+)")
        gun = tonumber(gun_str)
    end
    for i = 0,9 do
        if( game_key.pressed_or_spammed(wid, tostring(i)) and
            p.price[i] ~= nil )
        then
            gun = i
        end
    end

    p.try_buy(wid, gun)
end

function p.try_buy(wid, gun)
    if gun < 0 then return end
    --
    local substr = "Press " .. tostring(gun)
    ga_win_widget_small_list_set_selected_by_substr(wid, substr)
    --
    local gun_price = p.price[gun]
    if( gun_price == nil ) then return end
    local charge_price = gun_price / 1000
    if p.get_num_charges() < charge_price then
        ga_play_sound("error")
        return
    end
    local gold = ga_get_i("xar.player.gold.amount")
    if (gold < gun_price) then
        ga_play_sound("error")
        return
    end
    --Actually buying.
    std.set_bydelta_i("xar.player.gold.amount", -gun_price)
    local var = "xar.player.gun" .. tostring(gun) .. ".ammo_level"
    std.set_bydelta_i(var, 1)
    ga_play_sound("pickup_upgrade")
    p.set_num_charges_by_delta(-charge_price)
    p.refresh_options(wid)
end
