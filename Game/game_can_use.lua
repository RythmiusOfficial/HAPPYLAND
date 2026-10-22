function p.main(num)
    if num == 2 then
        if ga_get_i("xar.player.gun2.ammo_level") > 0 then return true end
        if ga_get_i("xar.player.gun2.speed_level") > 0 then return true end
        if ga_get_i("xar.player.gun2.fire_period_level") > 0 then return true end
        if ga_get_i("xar.player.gun2.damage_level") > 0 then return true end
        if ga_get_i("xar.player.gun2.num_level") > 0 then return true end
        return false
    end
    if num == 3 then
        if ga_get_i("xar.player.gun3.ammo_level") > 0 then return true end
        if ga_get_i("xar.player.gun3.freeze_time_level") > 0 then return true end
        if ga_get_i("xar.player.gun3.damage_level") > 0 then return true end
        return false
    end
    if num == 4 then
        if ga_get_i("xar.player.gun4.ammo_level") > 0 then return true end
        if ga_get_i("xar.player.gun4.speed_level") > 0 then return true end
        if ga_get_i("xar.player.gun4.fire_period_level") > 0 then return true end
        if ga_get_i("xar.player.gun4.damage_level") > 0 then return true end
        if ga_get_i("xar.player.gun4.radius_level") > 0 then return true end
        return false
    end
    if num == 5 then
        if ga_get_i("xar.player.gun5.ammo_level") > 0 then return true end
        if ga_get_i("xar.player.gun5.speed_level") > 0 then return true end
        if ga_get_i("xar.player.gun5.fire_period_level") > 0 then return true end
        if ga_get_i("xar.player.gun5.damage_level") > 0 then return true end
        return false
    end
    if num == 6 then
        if ga_get_i("xar.player.gun6.ammo_level") > 0 then return true end
        if ga_get_i("xar.player.gun6.speed_level") > 0 then return true end
        if ga_get_i("xar.player.gun6.fire_period_level") > 0 then return true end
        if ga_get_i("xar.player.gun6.damage_level") > 0 then return true end
        return false
    end
    if num == 7 then
        if ga_get_i("xar.player.gun7.ammo_level") > 0 then return true end
        if ga_get_i("xar.player.gun7.fire_period_level") > 0 then return true end
        if ga_get_i("xar.player.gun7.damage_level") > 0 then return true end
        return false
    end
    if num == 8 then
        if ga_get_i("xar.player.gun8.ammo_level") > 0 then return true end
        if ga_get_i("xar.player.gun8.damage_level") > 0 then return true end
        if ga_get_i("xar.player.gun8.radius_level") > 0 then return true end
        if ga_get_i("xar.player.gun8.freeze_time_level") > 0 then return true end
        return false
    end
    if num == 9 then
        if ga_get_i("xar.player.gun9.ammo_level") > 0 then return true end
        if ga_get_i("xar.player.gun9.speed_level") > 0 then return true end
        if ga_get_i("xar.player.gun9.damage_level") > 0 then return true end
        if ga_get_i("xar.player.gun9.radius_level") > 0 then return true end
        return false
    end
    if num == 0 then
        if ga_get_i("xar.player.gun0.ammo_level") > 0 then return true end
        if ga_get_i("xar.player.gun0.damage_level") > 0 then return true end
        if ga_get_i("xar.player.gun0.speed_level") > 0 then return true end
        return false
    end
    return true
end
