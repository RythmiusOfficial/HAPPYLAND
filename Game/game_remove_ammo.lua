--Perhaps rename this module.

--If you are reading this, then I know you can write prettier code than this.

function p.remove_ammo()
    total =
        ga_get_i("xar.player.gun2.ammo") +
        ga_get_i("xar.player.gun3.ammo") +
        ga_get_i("xar.player.gun4.ammo") +
        ga_get_i("xar.player.gun5.ammo") +
        ga_get_i("xar.player.gun6.ammo") +
        ga_get_i("xar.player.gun7.ammo") +
        ga_get_i("xar.player.gun8.ammo") +
        ga_get_i("xar.player.gun9.ammo") +
        ga_get_i("xar.player.gun0.ammo")

    if total > 0 then
        ga_play_sound("harp")
    end

    ga_set_i("xar.player.gun2.ammo", 0)
    ga_set_i("xar.player.gun3.ammo", 0)
    ga_set_i("xar.player.gun4.ammo", 0)
    ga_set_i("xar.player.gun5.ammo", 0)
    ga_set_i("xar.player.gun6.ammo", 0)
    ga_set_i("xar.player.gun7.ammo", 0)
    ga_set_i("xar.player.gun8.ammo", 0)
    ga_set_i("xar.player.gun9.ammo", 0)
    ga_set_i("xar.player.gun0.ammo", 0)
end

function p.remove_keys()
    local neg = -1.0
    ga_set_f("xar.key_time.yellow", neg)
    ga_set_f("xar.key_time.blue", neg)
    ga_set_f("xar.key_time.green", neg)
    ga_set_f("xar.key_time.universe", neg)
    ga_set_f("xar.key_time.laser_genesis", neg)
    ga_set_f("xar.key_time.dans_house", neg)
end

--Cheatcode.
--Todo: think of a better name for this script.
function p.give_keys()
    if not ga_get_sys_b("metagame.cheat.enabled") then
        ga_console_print("^1Cheating must be enabled")
        return
    end
    
    local new_time = 30 --In seconds.
    ga_set_f("xar.key_time.yellow",         new_time)
    ga_set_f("xar.key_time.blue",           new_time)
    ga_set_f("xar.key_time.green",          new_time)
    ga_set_f("xar.key_time.universe",       new_time)
    ga_set_f("xar.key_time.laser_genesis",  new_time)
    ga_set_f("xar.key_time.dans_house",     new_time)
end
