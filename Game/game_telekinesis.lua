-------------------------------------------------

p.all_array = {}
p.all_array[#p.all_array + 1] = "stone_corral"
p.all_array[#p.all_array + 1] = "huntington"
p.all_array[#p.all_array + 1] = "starksboro"
p.all_array[#p.all_array + 1] = "desert_flower_cloud"
p.all_array[#p.all_array + 1] = "tangerine"
p.all_array[#p.all_array + 1] = "super_massive_black_hole"
p.all_array[#p.all_array + 1] = "top_of_world"
p.all_array[#p.all_array + 1] = "secret_farmhouse"
p.all_array[#p.all_array + 1] = "main_branch_lib"
p.all_array[#p.all_array + 1] = "mylantis_great_cavern"
p.all_array[#p.all_array + 1] = "beta_sponge"
--May add more later.

p.upgrade_to_display = {}
p.upgrade_to_display["stone_corral"]                = "Stone Corral (Richmond, in Midway)"
p.upgrade_to_display["huntington"]                  = "Huntington (Midway)"
p.upgrade_to_display["starksboro"]                  = "Starksboro (I3)"
p.upgrade_to_display["desert_flower_cloud"]         = "Desert Flower Secret (I3)"
p.upgrade_to_display["tangerine"]                   = "Tangerine (I3)"
p.upgrade_to_display["super_massive_black_hole"]    = "Super Massive Black Hole (Space)"
p.upgrade_to_display["top_of_world"]                = "Top of the World"
p.upgrade_to_display["secret_farmhouse"]            = "Secret Farmhouse"
p.upgrade_to_display["main_branch_lib"]             = "Main Branch Library (Mylantis)"
p.upgrade_to_display["mylantis_great_cavern"]       = "Mylantis Great Cavern (Mylantis)"
p.upgrade_to_display["beta_sponge"]                 = "Beta Menger Sponge (Mylantis)"

-- Being explicit.
function p.get_all_array()
    return p.all_array
end

--Being explicit.
function p.get_upgrade_display_table()
    return p.upgrade_to_display
end

function p.api_name_to_env_var(api_name)
    return "game.globals.xar.player.telekinesis." .. api_name
end

function p.has_upgrade(api_name)
    return ga_get_b( p.api_name_to_env_var(api_name) )
end

function p.get_num_upgrades()
    local count = 0
    for _,v in pairs(p.all_array) do
        local value = p.has_upgrade(v)
        if( value ) then count = count + 1 end
    end
    return count
end

-------------------------------------------------
-- Free telekinesis cooldowns.

function p.get_free_cooldown_base()
    return 30 --In seconds.
end

function p.get_free_cooldown_delta()
    return p.get_num_upgrades()
end

function p.get_free_cooldown()
    local base = p.get_free_cooldown_base()
    local delta = p.get_free_cooldown_delta()
    return base - delta
end

-------------------------------------------------

function p.get_radius_base()
    return 24 --In blocks.
end

function p.get_radius_delta()
    return p.get_num_upgrades()
end

function p.get_radius()
    local base = p.get_radius_base()
    local delta = p.get_radius_delta()
    return base + delta
end

-------------------------------------------------

function p.payload()
    local game_time = ga_get_game_time()
    local last_free_tele_time = ga_get_f("xar.input.last_free_telekinesis_time")
    local tele_cooldown_len = p.get_free_cooldown()

    local is_tele_free = (game_time > last_free_tele_time + tele_cooldown_len)

    --Making sure if have enough gold.
    local gold = ga_get_i("xar.player.gold.amount")
    if( gold < 5 ) then
        game_msg.add("Not enough gold for telekinesis")
        return
    end
    --Will apply telekinesis.
    --Technically there is an explot if the player's
    --gold is between 5 and 9 inclusive and they are doing
    --a pickup that costs 10 gold, but who cares.

    if( is_tele_free ) then
        ga_play_sound("telekinesis_free")
    else
        ga_play_sound("telekinesis")
    end

    --Note: the player can use telekinesis even if they have no gold.
    local gold_before = ga_get_i("xar.player.gold.amount")
    local num_picked_up = p.main_helper() --Actually picking stuff up.
    local gold_after = ga_get_i("xar.player.gold.amount")
    local gold_diff = gold_after - gold_before

    --Calculating the gold cost.

    local gold_only_cost = 0
    if    ( gold_diff < 40  ) then gold_only_cost = 5
    elseif( gold_diff < 80  ) then gold_only_cost = 6
    elseif( gold_diff < 120 ) then gold_only_cost = 7
    elseif( gold_diff < 160 ) then gold_only_cost = 8
    elseif( gold_diff < 200 ) then gold_only_cost = 9
    else                           gold_only_cost = 10
    end
    --
    local count_only_cost = 0
    if    ( num_picked_up < 5  ) then count_only_cost = 5
    elseif( num_picked_up < 10 ) then count_only_cost = 6
    elseif( num_picked_up < 15 ) then count_only_cost = 7
    elseif( num_picked_up < 20 ) then count_only_cost = 8
    elseif( num_picked_up < 25 ) then count_only_cost = 9
    else                              count_only_cost = 10
    end

    local final_cost = math.max(gold_only_cost, count_only_cost)
    if( is_tele_free ) then final_cost = 0 end
    local gold_after_pay = gold_after - final_cost
    if( gold_after_pay < 0 ) then gold_after_pay = 0 end --In case of exploit.

    --Actually paying the gold.
    ga_set_i("xar.player.gold.amount", gold_after_pay)

    if( is_tele_free ) then
        ga_set_f("xar.input.last_free_telekinesis_time", game_time)
    end
end

--New way.
function p.main_helper()
    local count = 0 --How many bents were picked up.

    local level = ga_get_viewer_level()
    local lp = ga_get_viewer_offset()
    -- local radius = 16.0 --Important.
    local radius = p.get_radius()
    local ents = ga_bent_sphere_query(level, lp, radius) --MORE!!!
    for k,v in pairs(ents) do
        local dist = v.dist
        local bp = v.bp

        --Checking for visibility.
        local block_center = std.block_center(bp)
        local visible = ga_vis_test_level(level, lp, block_center)

        if( visible ) then
            --Calling telekinesis.
            local type = ga_bent_get_type(level, bp)
            local mod_name = type
            local func_name = "on_telekinesis"
            if( std.mod_func_exists(mod_name, func_name) ) then
                --The BEnt DOES have a on_telekinesis function.
                _G[mod_name][func_name](level,bp)
            end
            --Seeing if picked it up.
            local bent_type_after = ga_bent_get_type(level, bp)
            if( bent_type_after == "" ) then count = count + 1 end
        end
    end
    return count
end
