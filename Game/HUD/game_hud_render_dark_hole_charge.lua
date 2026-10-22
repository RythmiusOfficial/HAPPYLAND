function p.render_dark_hole_charge(wid)
    --Dark hole charge coloring screen.
    local dh_charge = ga_get_i("xar.player.gun0.charge")
    if( dh_charge > 0 ) then
        local alpha = 0.0
        if( dh_charge == 2 ) then alpha = 0.1 end
        if( dh_charge == 3 ) then alpha = 0.2 end
        if( dh_charge == 4 ) then alpha = 0.3 end
        if( dh_charge == 5 ) then alpha = 0.4 end
        if( dh_charge == 6 ) then alpha = 0.5 end
        if( dh_charge == 7 ) then alpha = 0.6 end
        if( dh_charge == 8 ) then alpha = 0.7 end
        if( dh_charge == 9 ) then alpha = 0.8 end
        if( dh_charge == 10 ) then alpha = 0.9 end
        if( dh_charge == 11 ) then alpha = 0.95 end
        if( dh_charge == 12 ) then alpha = 0.98 end
        if( dh_charge == 13 ) then alpha = 1.0 end
        local col_red = std.vec(1.0, 0.0, 0.0)
        ga_win_set_background(wid, col_red, alpha)
    end
end
