function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Common Sell Station"
end

-- Used for all 3 types of sell_stations.
function p.helper1(type)
    if (type == 0) then return ga_randf() end
    if (type == 1) then return 0.75 + 0.25*ga_randf() end
    if (type == 2) then return 0.9 + 0.1*ga_randf() end
end

-- Used for all 3 types of sell stations.
--Types: 0 = common, 1 = scarse, 2 = rare.
function p.helper2(type)
    local num = 0
    local c = std.vec(0.0, 0.0, 0.0)
    local c1 = ga_get_sys_v("menu.text_color")
    local c2 = {x=1.0, y=1.0, z=0.0}
    local c3 = {x=0.0, y=1.0, z=0.0}

    --Health.
    local f = bent_sell_station_common.helper1(type)
    if (f < 0.9) then
        num = ga_randi(10,20)
        c = c1
    elseif (f < 0.99) then
        num = ga_randi(5,9)
        c = c2
    else
        num = ga_randi(2,4)
        c = c3
    end
    ga_create_i("temp.xar.ent.sell_station.health")
    ga_create_v("temp.xar.ent.sell_station.health_color")
    ga_set_i("temp.xar.ent.sell_station.health", num)
    ga_set_v("temp.xar.ent.sell_station.health_color", c)

    f = bent_sell_station_common.helper1(type)
    if (f < 0.9) then
        num = ga_randi(40,100)
        c = c1
    elseif (f < 0.99) then
        num = ga_randi(20,39)
        c = c2
    else
        num = ga_randi(10,19)
        c = c3
    end
    ga_create_i("temp.xar.ent.sell_station.gun2")
    ga_create_v("temp.xar.ent.sell_station.gun2_color")
    ga_set_i("temp.xar.ent.sell_station.gun2", num)
    ga_set_v("temp.xar.ent.sell_station.gun2_color", c);

    f = bent_sell_station_common.helper1(type)
    if (f < 0.9) then
        num = ga_randi(20,50)
        c = c1
    elseif (f < 0.99) then
        num = ga_randi(10,19)
        c = c2
    else
        num = ga_randi(5,9)
        c = c3
    end
    ga_create_i("temp.xar.ent.sell_station.gun3")
    ga_create_v("temp.xar.ent.sell_station.gun3_color")
    ga_set_i("temp.xar.ent.sell_station.gun3", num)
    ga_set_v("temp.xar.ent.sell_station.gun3_color", c);

    f = bent_sell_station_common.helper1(type)
    if (f < 0.9) then
        num = ga_randi(20,50)
        c = c1
    elseif (f < 0.99) then
        num = ga_randi(10,19)
        c = c2
    else
        num = ga_randi(7,9)
        c = c3
    end
    ga_create_i("temp.xar.ent.sell_station.gun4")
    ga_create_v("temp.xar.ent.sell_station.gun4_color")
    ga_set_i("temp.xar.ent.sell_station.gun4", num)
    ga_set_v("temp.xar.ent.sell_station.gun4_color", c);

    f = bent_sell_station_common.helper1(type)
    if (f < 0.9) then
        num = ga_randi(300,1009) --If it is 1009, it will round down to 1000.
        c = c1
    elseif (f < 0.99) then
        num = ga_randi(200,299)
        c = c2
    else
        num = ga_randi(100,199)
        c = c3
    end
    num = math.floor(num / 10) * 10 --Rounding down to nearest multiple of 10.
    ga_create_i("temp.xar.ent.sell_station.gun5")
    ga_create_v("temp.xar.ent.sell_station.gun5_color")
    ga_set_i("temp.xar.ent.sell_station.gun5", num)
    ga_set_v("temp.xar.ent.sell_station.gun5_color", c);

    f = bent_sell_station_common.helper1(type)
    if (f < 0.9) then
        num = ga_randi(100,200)
        c = c1
    elseif (f < 0.99) then
        num = ga_randi(80,99)
        c = c2
    else
        num = ga_randi(70,79)
        c = c3
    end
    ga_create_i("temp.xar.ent.sell_station.gun6")
    ga_create_v("temp.xar.ent.sell_station.gun6_color")
    ga_set_i("temp.xar.ent.sell_station.gun6", num)
    ga_set_v("temp.xar.ent.sell_station.gun6_color", c);

    f = bent_sell_station_common.helper1(type)
    if (f < 0.9) then
        num = ga_randi(20,40)
        c = c1
    elseif (f < 0.99) then
        num = ga_randi(15,19)
        c = c2
    else
        num = ga_randi(10,14)
        c = c3
    end
    ga_create_i("temp.xar.ent.sell_station.gun7")
    ga_create_v("temp.xar.ent.sell_station.gun7_color")
    ga_set_i("temp.xar.ent.sell_station.gun7", num)
    ga_set_v("temp.xar.ent.sell_station.gun7_color", c);

    f = bent_sell_station_common.helper1(type)
    if (f < 0.9) then
        num = ga_randi(1,14)
        c = c1
    elseif (f < 0.99) then
        num = ga_randi(15,19)
        c = c2
    else
        num = ga_randi(20,25)
        c = c3
    end
    ga_create_i("temp.xar.ent.sell_station.gun8")
    ga_create_v("temp.xar.ent.sell_station.gun8_color")
    ga_set_i("temp.xar.ent.sell_station.gun8", num)
    ga_set_v("temp.xar.ent.sell_station.gun8_color", c);

    f = bent_sell_station_common.helper1(type)
    if (f < 0.9) then
        --num = ga_randi(1,39)
        num = ga_randi(1,24)
        c = c1
    elseif (f < 0.99) then
        --num = ga_randi(40,59)
        num = ga_randi(25,49)
        c = c2
    else
        --num = ga_randi(60,100)
        num = ga_randi(50,60) --50 is black market rate.
        c = c3
    end
    ga_create_i("temp.xar.ent.sell_station.gun9")
    ga_create_v("temp.xar.ent.sell_station.gun9_color")
    ga_set_i("temp.xar.ent.sell_station.gun9", num)
    ga_set_v("temp.xar.ent.sell_station.gun9_color", c);
end

function p.__on_use(level, bp)
    ga_play_sound_menu("use")

    local seed = ga_block_seed_pos(level, bp) --New way.
    ga_srand(seed)
    
    bent_sell_station_common.helper2(0)

    ga_window_push("win_sell_station")
end
