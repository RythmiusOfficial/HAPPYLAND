--This just contains a function that
--is called by win_credits.render.

--For people that want to mod the xar package
--to display other stuff when the player wins
--the game and is in the final credits,
--make a copy of this file and put it into
--Input/Packages/xar/Game then modify it.

--This is called by win_credits.
--The scroll var is a float used by the ending
--credits to scroll the credits down over time.
--It must be added the the y coordinates of
--everything that is rendered.
function p.render_end_credit_stats(wid, scroll)
    --Have exactly one of the following uncommented.

    --The standard stats.
    p.standard(wid, scroll)

    --Stats for a speedrunner.
    -- p.speed_run(wid, scroll)
end

function p.standard(wid, scroll)
    ga_win_set_char_size(wid, 0.08, 0.16)
    ga_win_txt_center(wid, 0.6 + scroll, "YOU WIN")
    --
    ga_win_set_char_size(wid, 0.02, 0.04)
    local player_name = ga_get_sys_s("game.player.name")
    ga_win_txt_center(wid, 0.5 + scroll, "NAME: " .. player_name)
    --
    -- ga_win_set_char_size(wid, 0.03, 0.06)
    ga_win_set_char_size(wid, 0.02, 0.04)
    local e_hardness = string.upper(game_difficulty.easiest_human_readable() .. " mode")
    ga_win_txt_center(wid, 0.4 + scroll, "EASIEST USED DIFFICULTY:")
    ga_win_txt_center(wid, 0.32 + scroll, e_hardness)
    --
    ga_win_set_char_size(wid, 0.04, 0.08)
    local game_time = ga_get_f("xar.credits.won_game_game_time")
    local game_time_str = game_time_helpers.time_str(game_time)
    ga_win_txt_center(wid, 0.2 + scroll, "GAME TIME: " .. game_time_str)
    --
    local play_time = ga_get_f("xar.credits.won_game_play_time")
    local play_time_str = game_time_helpers.time_str(play_time)
    ga_win_txt_center(wid, 0.1 + scroll, "PLAY TIME: " .. play_time_str)
end

--Make this function display what you want.
function p.speed_run(wid, scroll)
    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.6 + scroll, "NICE SPEEDRUN!")

    --If you are a modder, change this function!!!
end
