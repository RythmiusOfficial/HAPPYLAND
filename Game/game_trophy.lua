--This table maps each trophy name (string)
--to its type (string).
local initialized = false
local trophy_to_type = {}

function p.add(trophy_name, trophy_type)
    trophy_to_type[trophy_name] = trophy_type
end

--For secret trophies (starts with "st_")
--that were converted into regular trophies,
--its trophy name will be its API name (it starts with "st_").
function p.init_maybe()
    if( initialized ) then return end
    initialized = true
    --
    local type_yw = "Ying World"
    local type_mid = "Midway"
    local type_i1 = "I1"
    local type_i2 = "I2"
    local type_i3 = "I3"
    local type_bur = "Burlington"
    local type_space = "Space"
    local type_bulk = "Bulk"
    local type_mylantis = "Mylantis"
    local type_hell = "Hell"
    local type_nwp = "No Waypoint"
    --Ying world.
    p.add("library_ying",           type_yw)
    p.add("noob_flower",            type_yw)
    p.add("small_yellow_flower",    type_yw)
    p.add("jumbo_yellow_flower",    type_yw)
    p.add("small_cannon_pyramid",   type_yw)
    p.add("large_cannon_pyramid",   type_yw)
    p.add("ying_island_1",          type_yw)
    p.add("ying_island_2",          type_yw)
    p.add("ying_island_3",          type_yw)
    p.add("ying_island_4",          type_yw)
    p.add("ying_exit_maze",         type_yw)
    p.add("ying_flower",            type_yw)
    p.add("ying_tower",             type_yw)
    p.add("sponge_pure",            type_yw)
    --Midway.
    p.add("richmond",           type_mid)
    p.add("richmond_sewers",    type_mid)
    p.add("tau_caves_map",      type_mid)
    p.add("richmond_caves",     type_mid)
    p.add("stoney_cave_1",      type_mid)
    p.add("stoney_cave_2",      type_mid)
    p.add("stoney_cave_3",      type_mid)
    p.add("stoney_church",      type_mid)
    p.add("blackberry",         type_mid)
    p.add("black_cube",         type_mid)
    p.add("jericho",            type_mid)
    p.add("catacombs",          type_mid)
    p.add("orange",             type_mid)
    p.add("tweed_cave",         type_mid)
    p.add("ice_cube",           type_mid)
    p.add("blue_bubble",        type_mid)
    --I1.
    p.add("blue_bubble_breach", type_i1)
    p.add("botany_lab_1",       type_i1)
    p.add("botany_lab_2",       type_i1)
    p.add("botany_lab_3",       type_i1)
    p.add("botany_lab_4",       type_i1)
    p.add("botany_lab_5",       type_i1)
    p.add("botany_lab_6",       type_i1)
    p.add("library_i1",         type_i1)
    p.add("lighthouse",         type_i1)
    p.add("infinity_flower",    type_i1)
    p.add("williston",          type_i1)
    p.add("williston_caves",    type_i1)
    p.add("bristol",            type_i1)
    p.add("emp_castle",         type_i1)
    p.add("zube_castle",        type_i1)
    --I2.
    p.add("library_i2",             type_i2)
    p.add("wig_prison",             type_i2)
    p.add("montreal",               type_i2)
    p.add("toronto",                type_i2)
    p.add("toronto_underground",    type_i2)
    p.add("danville",               type_i2)
    p.add("small_blue_flower_1",    type_i2)
    p.add("small_blue_flower_2",    type_i2)
    p.add("willow_tree",            type_i2)
    p.add("willow_tree_dark",       type_i2)
    p.add("mystic_vine",            type_i2)
    p.add("raspberry",              type_i2)
    p.add("weed_rings",             type_i2)
    p.add("blue_mushroom",          type_i2)
    p.add("fanatic_spire",          type_i2)
    p.add("creeping_jeni",          type_i2)
    p.add("violets",                type_i2)
    --I3.
    p.add("library_i3",             type_i3)
    p.add("colchester",             type_i3)
    p.add("red_maze_flower",        type_i3)
    p.add("jackfruit",              type_i3)
    p.add("large_white_flower",     type_i3)
    p.add("cactus",                 type_i3)
    p.add("aladdin_cave",           type_i3)
    p.add("desert_cave",            type_i3)
    p.add("desert_flower",          type_i3)
    p.add("salmon_mushroom",        type_i3)
    p.add("black_mushroom",         type_i3)
    p.add("yellow_mushroom",        type_i3)
    p.add("red_mushroom",           type_i3)
    p.add("river",                  type_i3)
    p.add("tangerine",              type_i3)
    p.add("st_i3_treetop",          type_i3) --Used to be a secret trophy.
    p.add("inner_tree",             type_i3)
    p.add("deep_sliver_maze",       type_i3)
    --Burlington.
    p.add("burlington",             type_bur)
    p.add("burlington_cols",        type_bur)
    p.add("tegan_garden",           type_bur)
    p.add("green_apple_club",       type_bur)
    --Space.
    p.add("library_space",          type_space)
    p.add("moon_alpha",             type_space)
    p.add("moon_beta",              type_space)
    p.add("moon_gamma",             type_space)
    p.add("moon_tau",               type_space)
    p.add("moon_ice",               type_space)
    p.add("moon_fire_rate",         type_space)
    p.add("planet_small_minigun",   type_space)
    p.add("planet_clay",            type_space)
    p.add("sun",                    type_space)
    p.add("sponge_alpha",           type_space)
    --The Bulk.
    p.add("ice_castle",     type_bulk)
    --Mylantis.
    p.add("mylantis",               type_mylantis)
    p.add("farmhouse",              type_mylantis)
    p.add("laser_genesis",          type_mylantis)
    p.add("sapphire_maze",          type_mylantis)
    p.add("sponge_beta",            type_mylantis)
    p.add("topaz",                  type_mylantis)
    p.add("iolite",                 type_mylantis)
    p.add("emerald",                type_mylantis)
    p.add("denver",                 type_mylantis)
    p.add("amethyst_maze",          type_mylantis)
    p.add("edge_of_world",          type_mylantis)
    --Hell.
    p.add("hell_flower",    type_hell)
    p.add("inner_core",     type_hell)
    p.add("credits",        type_hell)
    --No Waypoint.
    p.add("small_white_flower",     type_nwp)
    p.add("small_black_flower",     type_nwp)
    p.add("apple_tree",             type_nwp)
    p.add("health_tower",           type_nwp)
    p.add("alpha_cube",             type_nwp)
    --Can add to this function when more
    --trophies are created.
end

function p.trophy_type(name)
    p.init_maybe()
    --
    local entry = trophy_to_type[name]
    if( entry == nil ) then return "UNKNOWN" end --Uh oh!
    return entry
end

--Does NOT give Steam achievements for them.
-- function p.give_all_trophies()
--     p.init_maybe()
--     --
--     for k, v in pairs(trophy_to_type) do
--         local trophy_name = k
--         p.pickup_with_no_achievement(trophy_name)
--     end
-- end

--I solemnly swear I am not a malicious hacker.
--Needs to be more complex because some secret trophies were convered to regular trophies.
--Make a helper function to convert trophy name to achievement name.
function p.get_all_achievements_for_aquired_trophies()
    ga_print("Getting Steam achievements for all trophies in player's inventory")
    p.init_maybe()
    --
    for k, v in pairs(trophy_to_type) do
        local trophy_name = k
        local var_name = "xar.player.trophy." .. trophy_name
        if ga_get_b(var_name) then
            local achievement_name = "trophy_" .. trophy_name
            ga_get_steam_achievement(achievement_name)
        end
    end
end

function p.starts_with_vowell(str)
    str2 = string.lower(str)
    c = string.sub(str2, 1, 1)
    if( c == "a" ) then return true end
    if( c == "e" ) then return true end
    if( c == "i" ) then return true end
    if( c == "o" ) then return true end
    if( c == "u" ) then return true end
    return false
end

--Called from trophy bent scripts.
function p.pickup(name)
    ga_print("game_trophy.pickup: " .. name)
    p.pickup_with_achievement(name)
end

--Needs to be more complex when some secret trophies are convered to regular trophies.
--If the name start with "st_", then we should get the achivement with that name.
--Otherwise, we pretend "trophy_".
--Make a helper function to convert trophy name to achievement name.
function p.pickup_with_achievement(name)
    ga_print("game_trophy.pickup_with_achievement: " .. name)
    if( name:find("^st_") ) then
        --It starts with "st_"
        ga_get_steam_achievement(name) --Keep the "st_".
    else
        ga_get_steam_achievement("trophy_" .. name)
    end
    p.pickup_with_no_achievement(name)
end

function p.pickup_with_no_achievement(name)
    genesis = game_genesis.enabled()
    var_name = "xar.player.trophy." .. name
    trophy_type = p.trophy_type(name)
    if p.starts_with_vowell(trophy_type) then
        ga_hud_msg("You Got An " .. trophy_type .. " Trophy", 5.0)
    else
        ga_hud_msg("You Got A " .. trophy_type .. " Trophy", 5.0)
    end
    if ga_get_b(var_name) then
        --Already has this trophy.
        ga_play_sound("pickup_gold")
        --
        game_msg.add("You already have this trophy: 10 gold")
        --
        max_gold = ga_get_i("xar.player.gold.max")
        old_gold = ga_get_i("xar.player.gold.amount")
        new_gold = old_gold + 10
        if( new_gold > max_gold ) then new_gold = max_gold end
        ga_set_i("xar.player.gold.amount", new_gold)
    else
        --Does not have this trophy.
        ga_play_sound("fanfare_short")
        --
        if genesis then
            game_msg.add("New trophy bonus: 200 gold")
        else
            game_msg.add("New trophy bonus: 200 gold + 4 health upgrades") 
        end
        --
        p.give_gold(200)
        --
        if not genesis then
            std.set_bydelta_i("xar.player.health.level", 2)
            std.set_bydelta_i("xar.player.health.regen_level", 2)
        end
        if not genesis then
            game_msg.add("New trophy bonus: 200% health + armor")
            p.get_200_health_armor()
        end
        --
        ga_set_b(var_name, true) --Setting that got the trophy.
    end
end

function p.pickup_secret_trophy(name)
    --Figuring out if already have.
    local dyn_var = "dyn.xar.secret_trophy." .. name
    ga_print("game_trophy.pickup_secret_trophy: dyn_var = " .. dyn_var)
    local already_exists = ga_dyn_exists(dyn_var)
    ga_dyn_create_b(dyn_var)
    ga_dyn_set_b(dyn_var, true)

    if already_exists then
        game_msg.add("You already have this secret trophy")
        ga_play_sound("pickup_gold")
    else
        --Getting it for the first time.
        game_msg.add("New secret trophy bonus: 100 gold + health + armor")
        --
        p.get_100_gold_200_health_armor()
        --
        ga_play_sound("fanfare_short")
    end

    ga_get_steam_achievement(name)
end

function p.get_100_gold_200_health_armor()
    p.get_200_health_armor()
    --
    p.give_gold(100)
end

function p.get_200_health_armor()
    local max_200_health = 2 * ga_get_i("xar.player.health.max")
    --
    local health = ga_get_i("xar.player.health.amount")
    if( health < max_200_health ) then
        ga_set_i("xar.player.health.amount", max_200_health)
    end
    --
    local armor = ga_get_i("xar.player.armor.amount")
    if( armor < max_200_health ) then
        ga_set_i("xar.player.armor.amount", max_200_health)
    end
end

function p.give_gold(amount)
    max_gold = ga_get_i("xar.player.gold.max")
    old_gold = ga_get_i("xar.player.gold.amount")
    new_gold = old_gold + amount
    if( new_gold > max_gold ) then new_gold = max_gold end
    ga_set_i("xar.player.gold.amount", new_gold)
end
