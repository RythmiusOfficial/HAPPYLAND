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
    local type_hl = "Happy Land"
    -- Happy Land
    p.add("treasure_flower_orange", type_hl)
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
        local var_name = "game.trophy." .. trophy_name
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
    var_name = "game.trophy." .. name
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
