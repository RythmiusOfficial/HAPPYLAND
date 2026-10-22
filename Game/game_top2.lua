--The engine calls functions in "game_top.lua",
--but not in this file (game_top2.lua).

function p.damage_player(raw, amount)
    game_damage.damage_player(raw, amount)
end

function p.damage_player_from_dir(raw, amount, dir)
    ga_hud_reg_damage_from_dir(amount, dir);

    p.damage_player(raw, amount)
end
