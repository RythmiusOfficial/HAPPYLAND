function p.time_str(time_total)
    time_total_sec = math.floor(time_total)
    time_sec = time_total_sec % 60
    time_total_min = math.floor( (time_total_sec - time_sec) / 60 )
    time_min = time_total_min % 60
    time_total_hrs = math.floor( (time_total_min - time_min) / 60 )
    return
        string.format("%03d",time_total_hrs) .. ":" ..
        string.format("%02d",time_min) .. ":" ..
        string.format("%02d",time_sec)
end
