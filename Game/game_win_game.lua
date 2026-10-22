function p.win_game()
    local game_time = ga_get_sys_f("game.time.total")
    ga_set_f("xar.credits.won_game_game_time", game_time)
    --
    local play_time = ga_get_sys_f("game.time.play")
    ga_set_f("xar.credits.won_game_play_time", play_time)
    --
    p.get_steam_achievements()
end

--Must synchronize with game_difficulty.num_to_human_readable.
function p.get_steam_achievements()
    --The (easiest used) difficulty number.
    local diff_num = game_difficulty.easiest_num()
    -- local diff_num = game_difficulty.num() --Debugging.
    local diff_str = game_difficulty.num_to_human_readable(diff_num)
    --
    ga_print("game_win_game.get_steam_achievements: diff_num = " .. tostring(diff_num))
    ga_print("game_win_game.get_steam_achievements: diff_str = " .. diff_str)
    --
    local hardcore = game_difficulty.is_hardcore()

    --Plain difficulty achievements.
    p.get_steam_achievements_plain_helper(diff_str)

    --Hardcore achievements.
    if( hardcore ) then
        --Gets a hardcore achivement.
        p.get_steam_achievements_hardcore_helper(diff_str)
    end

    --Pacifest achievements.
    if( game_kill_count.is_pacifist() ) then
        --Gets a pacifist achivement.
        p.get_steam_achievements_pacifist_helper(diff_str)
    end
end

function p.get_steam_achievements_plain_helper(diff_str)
    if    ( diff_str == "tranquility" ) then
        ga_get_steam_achievement("won_game_tranquility")
        --
    elseif( diff_str == "normal") then
        ga_get_steam_achievement("won_game_normal")
        p.get_steam_achievements_plain_helper("tranquility")
        --
    elseif( diff_str == "gateway") then
        ga_get_steam_achievement("won_game_gateway")
        p.get_steam_achievements_plain_helper("normal")
        --
    elseif( diff_str == "quagmire") then
        ga_get_steam_achievement("won_game_quagmire")
        p.get_steam_achievements_plain_helper("gateway")
        --
    elseif( diff_str == "agony") then
        ga_get_steam_achievement("won_game_agony")
        p.get_steam_achievements_plain_helper("quagmire")
        --
    elseif( diff_str == "caustic utopia") then
        ga_get_steam_achievement("won_game_caustic_utopia")
        p.get_steam_achievements_plain_helper("agony")
        --
    elseif( diff_str == "madness") then
        ga_get_steam_achievement("won_game_madness")
        p.get_steam_achievements_plain_helper("caustic utopia")
        --
    end
end

--Should only be called if the player is hardcore.
function p.get_steam_achievements_hardcore_helper(diff_str)
    if    ( diff_str == "tranquility" ) then
        ga_get_steam_achievement("won_game_tranquility_hardcore")
        --
    elseif( diff_str == "normal") then
        ga_get_steam_achievement("won_game_normal_hardcore")
        p.get_steam_achievements_hardcore_helper("tranquility")
        --
    elseif( diff_str == "gateway") then
        ga_get_steam_achievement("won_game_gateway_hardcore")
        p.get_steam_achievements_hardcore_helper("normal")
        --
    elseif( diff_str == "quagmire") then
        ga_get_steam_achievement("won_game_quagmire_hardcore")
        p.get_steam_achievements_hardcore_helper("gateway")
        --
    elseif( diff_str == "agony") then
        ga_get_steam_achievement("won_game_agony_hardcore")
        p.get_steam_achievements_hardcore_helper("quagmire")
        --
    elseif( diff_str == "caustic utopia") then
        ga_get_steam_achievement("won_game_caustic_utopia_hardcore")
        p.get_steam_achievements_hardcore_helper("agony")
        --
    elseif( diff_str == "madness") then
        ga_get_steam_achievement("won_game_madness_hardcore")
        p.get_steam_achievements_hardcore_helper("caustic utopia")
        --
    end
end

--Should only be called if the player is a pacifist.
function p.get_steam_achievements_pacifist_helper(diff_str)
    if    ( diff_str == "tranquility" ) then
        ga_get_steam_achievement("won_game_tranquility_pacifist")
        --
    elseif( diff_str == "normal") then
        ga_get_steam_achievement("won_game_normal_pacifist")
        p.get_steam_achievements_pacifist_helper("tranquility")
        --
    elseif( diff_str == "gateway") then
        ga_get_steam_achievement("won_game_gateway_pacifist")
        p.get_steam_achievements_pacifist_helper("normal")
        --
    elseif( diff_str == "quagmire") then
        ga_get_steam_achievement("won_game_quagmire_pacifist")
        p.get_steam_achievements_pacifist_helper("gateway")
        --
    elseif( diff_str == "agony") then
        ga_get_steam_achievement("won_game_agony_pacifist")
        p.get_steam_achievements_pacifist_helper("quagmire")
        --
    elseif( diff_str == "caustic utopia") then
        ga_get_steam_achievement("won_game_caustic_utopia_pacifist")
        p.get_steam_achievements_pacifist_helper("agony")
        --
    elseif( diff_str == "madness") then
        ga_get_steam_achievement("won_game_madness_pacifist")
        p.get_steam_achievements_pacifist_helper("caustic utopia")
        --
    end
end
