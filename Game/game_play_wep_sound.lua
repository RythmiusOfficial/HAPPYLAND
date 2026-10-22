--This script is a stub.
--It is intended that people can mod (by overriding it).
function p.play(wep, mode)
    local shoot_sound = "shoot_" .. tostring(wep) .. "_" .. tostring(mode)
    game_play_sound.play(shoot_sound)
end

function p.play_0_1_loud()
    game_play_sound.play("shoot_0_1_loud")
end

function p.play_0_charge()
    game_play_sound.play("shoot_0_charge")
end
