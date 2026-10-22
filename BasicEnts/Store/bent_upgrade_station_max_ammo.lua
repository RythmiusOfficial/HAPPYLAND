function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Max Ammo Upgrade Station"
end

function p.__on_use(level, bp)
    ga_play_sound_menu("use")
    local chunk_id = ga_bp_to_parent_chunk_id(level, bp)
    ga_create_i("temp.xar.upgrade_station_max_ammo.chunk_id")
    ga_set_i("temp.xar.upgrade_station_max_ammo.chunk_id", chunk_id)
    ga_window_push("win_upgrade_station_max_ammo")
end
