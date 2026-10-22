--Can be called from other scripts.
function p.in_arcade()
    return ga_get_b("xar.player.arcade.inside")
end

--Can be called from other scripts.
function p.set_inside_arcade()
    --Dealing with ammo.
    if not p.in_arcade() then
        ga_play_sound("arcade_enter")
        --
        local health = ga_get_i("xar.player.health.amount")
        local armor  = ga_get_i("xar.player.armor.amount")
        local ammo1  = ga_get_i("xar.player.gun1.ammo")
        local ammo2  = ga_get_i("xar.player.gun2.ammo")
        local ammo3  = ga_get_i("xar.player.gun3.ammo")
        local ammo4  = ga_get_i("xar.player.gun4.ammo")
        local ammo5  = ga_get_i("xar.player.gun5.ammo")
        local ammo6  = ga_get_i("xar.player.gun6.ammo")
        local ammo7  = ga_get_i("xar.player.gun7.ammo")
        local ammo8  = ga_get_i("xar.player.gun8.ammo")
        local ammo9  = ga_get_i("xar.player.gun9.ammo")
        local ammo0  = ga_get_i("xar.player.gun0.ammo")
        --
        ga_set_i("xar.player.arcade.health", health)
        ga_set_i("xar.player.arcade.armor",  armor)
        ga_set_i("xar.player.arcade.ammo.1", ammo1)
        ga_set_i("xar.player.arcade.ammo.2", ammo2)
        ga_set_i("xar.player.arcade.ammo.3", ammo3)
        ga_set_i("xar.player.arcade.ammo.4", ammo4)
        ga_set_i("xar.player.arcade.ammo.5", ammo5)
        ga_set_i("xar.player.arcade.ammo.6", ammo6)
        ga_set_i("xar.player.arcade.ammo.7", ammo7)
        ga_set_i("xar.player.arcade.ammo.8", ammo8)
        ga_set_i("xar.player.arcade.ammo.9", ammo9)
        ga_set_i("xar.player.arcade.ammo.0", ammo0)
    end

    --Setting that is now inside arcade.
    ga_set_b("xar.player.arcade.inside", true)
end

--Can be called from other scripts.
function p.set_outside_arcade()
    --Setting ammo to what is was when entered the arcade.
    if p.in_arcade() then
        ga_play_sound("arcade_exit")
        local health = ga_get_i("xar.player.arcade.health")
        local armor = ga_get_i("xar.player.arcade.armor")
        local ammo1 = ga_get_i("xar.player.arcade.ammo.1")
        local ammo2 = ga_get_i("xar.player.arcade.ammo.2")
        local ammo3 = ga_get_i("xar.player.arcade.ammo.3")
        local ammo4 = ga_get_i("xar.player.arcade.ammo.4")
        local ammo5 = ga_get_i("xar.player.arcade.ammo.5")
        local ammo6 = ga_get_i("xar.player.arcade.ammo.6")
        local ammo7 = ga_get_i("xar.player.arcade.ammo.7")
        local ammo8 = ga_get_i("xar.player.arcade.ammo.8")
        local ammo9 = ga_get_i("xar.player.arcade.ammo.9")
        local ammo0 = ga_get_i("xar.player.arcade.ammo.0")
        --
        ga_set_i("xar.player.health.amount", health)
        ga_set_i("xar.player.armor.amount", armor)
        ga_set_i("xar.player.gun1.ammo", ammo1)
        ga_set_i("xar.player.gun2.ammo", ammo2)
        ga_set_i("xar.player.gun3.ammo", ammo3)
        ga_set_i("xar.player.gun4.ammo", ammo4)
        ga_set_i("xar.player.gun5.ammo", ammo5)
        ga_set_i("xar.player.gun6.ammo", ammo6)
        ga_set_i("xar.player.gun7.ammo", ammo7)
        ga_set_i("xar.player.gun8.ammo", ammo8)
        ga_set_i("xar.player.gun9.ammo", ammo9)
        ga_set_i("xar.player.gun0.ammo", ammo0)
        --
        game_black_hole_drive.stop_back_hole_drive()
        game_quasar_drive.stop_quasar_drive()
    end
    
    --Setting to be not in the arcade.
    ga_set_b("xar.player.arcade.inside", false)
end
