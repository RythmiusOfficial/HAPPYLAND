function p.render_icons(wid)
    if not ga_get_b("xar.hud.show_icons") then return end

    -- Icons.
    local icon_bot = 0.13
    local icon_top = icon_bot + 0.08
    local icon_width = 0.05

    local step_x = icon_width + 0.01
    local cur_x = 0.01

    local col_red  = std.vec(1.0, 0.0, 0.0)
    local col_green  = std.vec(0.0, 1.0, 0.0)

    if ga_get_sys_b("game.state.saving_in_progress") then
        local tex = "icon_save"
        ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
        cur_x = cur_x + step_x
    end

    --Chunk database icon.
    local db_icon = ""
    local db_dirs = ga_get_sys_s("game.save.chunk_db.dirs")
    if( db_dirs == "db_1"       ) then db_icon = "icon_db_1" end
    if( db_dirs == "db_2"       ) then
        --Not showing the db2 icon because it is implied.
        -- db_icon = "icon_db_2"
        db_icon = ""
    end
    if( db_dirs == "db_1_and_2" ) then db_icon = "icon_db_1_and_2" end
    -- if( db_dirs == "db_2"       ) then db_icon = "" end --Put this back in eventually!
    if db_icon ~= "" then
        local tex = db_icon
        ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
        cur_x = cur_x + step_x
    end

    --Hardcore modifier.
    if ga_get_hardcore_mode() then
        local tex = "icon_hardcore"
        ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
        cur_x = cur_x + step_x
    end

    --Pacifist modifier.
    if game_kill_count.is_trying_to_be_pacifist() then
        local tex = "icon_pacifist"
        local kill_count = game_kill_count.get_kill_count()
        ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
        local col = col_red
        if( game_kill_count.is_pacifist() ) then col = col_green end
        win_hud.txt_col(wid, col)
        local num_str = game_str.make_3_digit_big(kill_count)
        ga_win_txt_center_at_bg(wid, 
            cur_x + 0.5*icon_width,
            icon_top,
            num_str)
        cur_x = cur_x + step_x
    end

    --Game difficulty new way).
    -- ga_print("win_hud: pondering about difficulty...")
    if ga_get_b("xar.difficulty.custom") then
        --Using a customm difficulty.
        local icon_name = "icon_custom"
        ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, icon_name)
        cur_x = cur_x + step_x
    else
        local diff_num = game_difficulty.num()
        local e_diff_num = game_difficulty.easiest_num()
        -- ga_print("win_hud: diff_num = " .. tostring(diff_num))
        -- ga_print("win_hud: e_diff_num = " .. tostring(e_diff_num))
        if( diff_num == e_diff_num ) then
            --Only need to show the current difficult.
            local icon_name = game_difficulty.icon(diff_num)
            if( icon_name ~= "" ) then
                if not game_genesis.enabled() then
                    ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, icon_name)
                    cur_x = cur_x + step_x
                end
            end
        else
            --Need to show an icon from the easiest difficulty (in grey)
            --and the current difficulty.
            local e_icon_name = game_difficulty.icon_once(e_diff_num)
            ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, e_icon_name)
            cur_x = cur_x + step_x
            --
            local icon_name = game_difficulty.icon(diff_num)
            if( icon_name ~= "" ) then
                if not game_genesis.enabled() then
                    ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, icon_name)
                    cur_x = cur_x + step_x
                end
            end
        end
    end

    if ga_get_b("xar.movement.rocket") then
        local tex = "icon_rocket"
        ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
        cur_x = cur_x + step_x
    end

    if ga_get_b("xar.movement.brake") then
        local tex = "icon_brake"
        ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
        cur_x = cur_x + step_x
    end    

    if ga_exists("xar.key_time.yellow") then
        local key_time = ga_get_f("xar.key_time.yellow")
        if (key_time > 0.0) then
            local tex = "key_yellow"
            ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
            win_hud.txt_col(wid, col_green)
            ga_win_txt_center_at_bg(wid, 
                cur_x + 0.5*icon_width,
                icon_top,
                math.floor(key_time) )
            cur_x = cur_x + step_x
        end
    end
    
    if ga_exists("xar.key_time.blue") then
        local key_time = ga_get_f("xar.key_time.blue")
        if (key_time > 0.0) then
            local tex = "key_blue"
            ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
            win_hud.txt_col(wid, col_green)
            ga_win_txt_center_at_bg(wid, 
                cur_x + 0.5*icon_width,
                icon_top,
                math.floor(key_time) )
            cur_x = cur_x + step_x
        end
    end

    if ga_exists("xar.key_time.green") then
        local key_time = ga_get_f("xar.key_time.green")
        if (key_time > 0.0) then
            local tex = "key_green"
            ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
            win_hud.txt_col(wid, col_green)
            ga_win_txt_center_at_bg(wid, 
                cur_x + 0.5*icon_width,
                icon_top,
                math.floor(key_time) )
            cur_x = cur_x + step_x
        end
    end

    if ga_exists("xar.key_time.universe") then
        local key_time = ga_get_f("xar.key_time.universe")
        if (key_time > 0.0) then
            local tex = "ent_credits"
            ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
            win_hud.txt_col(wid, col_green)
            ga_win_txt_center_at_bg(wid, 
                cur_x + 0.5*icon_width,
                icon_top,
                math.floor(key_time) )
            cur_x = cur_x + step_x
        end
    end

    if ga_exists("xar.key_time.laser_genesis") then
        local key_time = ga_get_f("xar.key_time.laser_genesis")
        if (key_time > 0.0) then
            local tex = "key_laser_genesis"
            ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
            win_hud.txt_col(wid, col_green)
            ga_win_txt_center_at_bg(wid, 
                cur_x + 0.5*icon_width,
                icon_top,
                math.floor(key_time) )
            cur_x = cur_x + step_x
        end
    end

    if ga_exists("xar.key_time.dans_house") then
        local key_time = ga_get_f("xar.key_time.dans_house")
        if (key_time > 0.0) then
            local tex = "key_dans_house"
            ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
            win_hud.txt_col(wid, col_green)
            ga_win_txt_center_at_bg(wid, 
                cur_x + 0.5*icon_width,
                icon_top,
                math.floor(key_time) )
            cur_x = cur_x + step_x
        end
    end

    if ga_exists("xar.xp_5x_stacking_time") then
        local xp_time = ga_get_f("xar.xp_5x_stacking_time")
        if (xp_time > 0.0) then
            local tex = "icon_xp_5x"
            ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
            win_hud.txt_col(wid, col_green)
            ga_win_txt_center_at_bg(wid, 
                cur_x + 0.5*icon_width,
                icon_top,
                math.floor(xp_time) )
            cur_x = cur_x + step_x
        end
    end

    if ga_exists("xar.damage_5x_stacking_time") then
        local xp_time = ga_get_f("xar.damage_5x_stacking_time")
        if (xp_time > 0.0) then
            local tex = "icon_damage_5x"
            ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
            win_hud.txt_col(wid, col_green)
            ga_win_txt_center_at_bg(wid, 
                cur_x + 0.5*icon_width,
                icon_top,
                math.floor(xp_time) )
            cur_x = cur_x + step_x
        end
    end

    local invun_time = ga_get_f("xar.invun_stacking_time")
    if( invun_time > 0.0 ) then
        local tex = "icon_invun"
        ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
        win_hud.txt_col(wid, col_green)
        ga_win_txt_center_at_bg(wid, 
            cur_x + 0.5*icon_width,
            icon_top,
            math.floor(invun_time) )
        cur_x = cur_x + step_x
    end

    --Tracking marker (beacon).
    game_tracking_marker.refresh_attack_display()
    if game_tracking_marker.exists_and_enabled() then
        local tex = "icon_beacon"
        ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
        win_hud.txt_col(wid, col_green)
        local dist = game_tracking_marker.get_dist()
        local dist_str = game_str.make_3_digit_big(dist)
        ga_win_txt_center_at_bg(wid, 
            cur_x + 0.5*icon_width,
            icon_top,
            dist_str )
        cur_x = cur_x + step_x
    end

    if ga_exists("xar.emp_end_time") then
        local emp_end_time = ga_get_f("xar.emp_end_time")
        local game_time = ga_get_game_time()
        if( emp_end_time > game_time ) then
            local diff = math.floor(emp_end_time - game_time)
            local tex = "ammo_gun8"
            ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
            local emp_text_col = game_ment_emp.get_hud_emp_icon_text_color()
            win_hud.txt_col(wid, emp_text_col)
            ga_win_txt_center_at_bg(wid,
                cur_x + 0.5*icon_width,
                icon_top,
                diff)
            cur_x = cur_x + step_x
        end
    end

    if ga_get_b("xar.player.arcade.inside") then
        local tex = "icon_arcade"
        ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
        cur_x = cur_x + step_x
    end

    local game_time                 = ga_get_game_time()
    local quasar_drive_end_time     = ga_get_f("xar.player.gun0.quasar_drive_end")
    local black_hole_drive_end_time = ga_get_f("xar.player.gun0.black_hole_drive_end")
    if( game_time < quasar_drive_end_time ) then
        local diff = math.floor(quasar_drive_end_time - game_time)
        local tex = "icon_quasar_drive"
        ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
        win_hud.txt_col(wid, col_green)
        ga_win_txt_center_at_bg(wid,
            cur_x + 0.5*icon_width,
            icon_top,
            diff)
        cur_x = cur_x + step_x
    elseif( game_time < black_hole_drive_end_time ) then
        local diff = math.floor(black_hole_drive_end_time - game_time)
        local tex = "ammo_gun0"
        ga_win_quad(wid, cur_x, icon_bot, cur_x+icon_width, icon_top, tex)
        win_hud.txt_col(wid, col_green)
        ga_win_txt_center_at_bg(wid,
            cur_x + 0.5*icon_width,
            icon_top,
            diff)
        cur_x = cur_x + step_x
    end
end
