function p.enable()
    --Setting the body.
    local tele = std.vec_zero()
    local new_radius     = 0.23
    local new_bot_to_eye = 1.3
    local new_eye_to_top = 0.6
    local body_worked = ga_move_set_body_ground(
        tele, new_radius,
        new_bot_to_eye, new_eye_to_top)
    if( not body_worked ) then
         --Aborting.
        ga_play_sound("xar_error")
        return false
    end
    ga_play_sound("oh_yeah")

    return true
end

function p.disable()
    --Setting the body.
    game_body.set_default_fly_mode()
end

function p.update_discrete_post()
    ga_set_s("xar.inf2.movement.mod", "") --Note this.
end

--This file does basic Q2MD2 animations, but it does not
--handle crouching.  For that, see Data/Packages/package_tutorial2.
function p.movement_update_discrete()
    local alt_mode = ga_get_s("xar.inf2.movement.mod")
    if( alt_mode ~= "" ) then
        p.update_discrete_alternate()
        return
    end

    local old_moving_in_plane = ga_get_b("xar.inf2.movement.moving_in_plane")
    local new_moving_in_plane = old_moving_in_plane
    local old_in_air = ga_get_b("xar.inf2.movement.in_air")

    --This is the one used by the engine.
    local time_step = 0.04

    local on_sure_footing = ga_move_get_on_sure_footing()

    local momentum = ga_get_sys_v("game.player.move.last_pos_diff")

    --Getting the acc due to pressing keys.
    local vec_look = ga_get_sys_v("game.player.camera.look")
    local vec_left = ga_get_sys_v("game.player.camera.left")

    local plane_look = {}
    plane_look.x = vec_look.x
    plane_look.y = vec_look.y
    plane_look.z = 0.0
    std.normalize(plane_look)

    local plane_left = {}
    plane_left.x = vec_left.x
    plane_left.y = vec_left.y
    plane_left.z = 0.0
    std.normalize(plane_left)

    local new_moving_in_plane = false
    local plane_acc = {x=0.0, y=0.0, z=0.0}
    if ga_get_b("xar.movement.forward") then
        plane_acc.x = plane_acc.x + plane_look.x
        plane_acc.y = plane_acc.y + plane_look.y
        ga_player_model_set_look()
        new_moving_in_plane = true
    end
    if ga_get_b("xar.movement.back") then
        plane_acc.x = plane_acc.x - plane_look.x
        plane_acc.y = plane_acc.y - plane_look.y
        ga_player_model_set_look()
        new_moving_in_plane = true
    end
    if ga_get_b("xar.movement.left") then
        plane_acc.x = plane_acc.x + plane_left.x
        plane_acc.y = plane_acc.y + plane_left.y
        ga_player_model_set_look()
        new_moving_in_plane = true
    end
    if ga_get_b("xar.movement.right") then
        plane_acc.x = plane_acc.x - plane_left.x
        plane_acc.y = plane_acc.y - plane_left.y
        ga_player_model_set_look()
        new_moving_in_plane = true
    end
    ga_set_b("xar.inf2.movement.moving_in_plane", new_moving_in_plane)

    --Animation
    local new_crouching = false
    if( new_crouching ) then
        if( new_moving_in_plane and not old_moving_in_plane ) then
            if( not old_in_air ) then
                ga_player_model_q2md2_set_cmd("crwalk")
            end
        end
        --
        if( not new_moving_in_plane and old_moving_in_plane ) then
            if( not old_in_air ) then
                ga_player_model_q2md2_set_cmd("crstand")
            end
        end
    else
        if( new_moving_in_plane and not old_moving_in_plane ) then
            if( not old_in_air ) then
                ga_player_model_q2md2_set_cmd("run")
            end
        end
        --
        if( not new_moving_in_plane and old_moving_in_plane ) then
            if( not old_in_air ) then
                ga_player_model_q2md2_set_cmd("stand")
            end
        end
    end

    --Q2MD2 animation command for being in air.
    if( not on_sure_footing and not old_in_air )
    then
        ga_player_model_q2md2_set_cmd("jump_up")
        local new_in_air = true
        ga_set_b("xar.inf2.movement.in_air", new_in_air)
    end

    --Q2MD2 animating command for landing form the air.
    if( on_sure_footing and old_in_air )
    then
        ga_player_model_q2md2_set_cmd("jump_down")
        local new_in_air = false
        ga_set_b("xar.inf2.movement.in_air", new_in_air)
    end

    local new_crouching = false
    --Q2MD2 State.
    if( new_crouching ) then
        if( new_moving_in_plane ) then
            ga_player_model_q2md2_set_state("crouch_run")
        else
            ga_player_model_q2md2_set_state("crouch")
        end
    else
        if( new_moving_in_plane ) then
            ga_player_model_q2md2_set_state("run")
        else
            ga_player_model_q2md2_set_state("")
        end
    end

    --Normalizing plane_acc vector.
    if ( std.length(plane_acc) < 0.0001 ) then
        plane_acc = {x=0.0, y=0.0, z=0.0}
    else
        std.normalize(plane_acc)
    end

    --Shrinking player acc if not on sure footing.
    if not on_sure_footing then
        local air_control = 0.1
        plane_acc.x = plane_acc.x * air_control
        plane_acc.y = plane_acc.y * air_control
    end

    --The "acceleration."
    local acc = {x=0.0, y=0.0, z=0.0}

    --Setting plane compoent of acc.
    local speed_mod = 0.07 --magic number.
    acc.x = plane_acc.x * speed_mod
    acc.y = plane_acc.y * speed_mod

    --Setting the z component of acc.
    --Jumping.
    if( ga_get_b("xar.movement.up") and
        on_sure_footing )
    then
        --Actually jumping.
        acc.z = 0.23
        ga_set_b("xar.movement.up", false)
    end

    local gravity = 0.02
    acc.z = acc.z - gravity

    --Drag
    local air_drag = 0.995
    local ground_drag = 0.0
    if on_sure_footing then
        ground_drag = 0.8
    else
        ground_drag = 0.98
    end

    --Scaled momentum.
    local sm = {}
    sm.x = momentum.x * ground_drag
    sm.y = momentum.y * ground_drag
    sm.z = momentum.z * air_drag

    --Setting the travel.
    local travel = {}
    travel.x = sm.x + acc.x
    travel.y = sm.y + acc.y
    travel.z = sm.z + acc.z

    --Ledge guards are used in other packages,
    --but not the in Infinifrag 2 easter egg in
    --the xar package.
    -- ga_move_set_ledge_guards(
    --     ga_get_b("tut2.movement.ledge_guard"))

    ga_move_set_desired_travel(travel)
end

function p.update_discrete_alternate()
    local mode = ga_get_s("xar.inf2.movement.mod")

    if  mode == "ladder_x_pos" or
        mode == "ladder_x_neg" or
        mode == "ladder_y_pos" or
        mode == "ladder_y_neg"
    then
        --It would not be hard to multiply lad_up
        --by -1 if the viewer is looking down, etc.
        lad_up = {x=0.0, y=0.0, z=0.3}

        if mode == "ladder_x_pos" then
            lad_left = {x=0.0, y=0.03, z=0.0}
            lad_off = {x=-0.2, y=0.0, z=0.0}
        end
        if mode == "ladder_x_neg" then
            lad_left = {x=0.0, y=-0.03, z=0.0}
            lad_off = {x=0.2, y=0.0, z=0.0} 
        end
        if mode == "ladder_y_pos" then
            lad_left = {x=-0.03, y=0.0, z=0.0}
            lad_off = {x=0.0, y=-0.2, z=0.0}
        end
        if mode == "ladder_y_neg" then
            lad_left = {x=0.03, y=0.0, z=0.0}
            lad_off = {x=0.0, y=0.2, z=0.0} 
        end

        --Inverting the movement vectors based on
        --where the player is facing.
        vec_look = ga_get_sys_v("game.player.camera.look")
        if vec_look.z < 0.0 then
            lad_up.x = lad_up.x * (-1.0)
            lad_up.y = lad_up.y * (-1.0)
            lad_up.z = lad_up.z * (-1.0)
        end
        if  (mode == "ladder_x_pos" and vec_look.x < 0.0) or
            (mode == "ladder_x_neg" and vec_look.x > 0.0) or
            (mode == "ladder_y_pos" and vec_look.y < 0.0) or
            (mode == "ladder_y_neg" and vec_look.y > 0.0)
        then
            lad_left.x = lad_left.x * (-1.0)
            lad_left.y = lad_left.y * (-1.0)
            lad_left.z = lad_left.z * (-1.0)
        end

        travel = {x = 0.0, y = 0.0, z = 0.0}

        if ga_get_b("xar.movement.forward") then
            travel.x = travel.x + lad_up.x
            travel.y = travel.y + lad_up.y
            travel.z = travel.z + lad_up.z
        end
        if ga_get_b("xar.movement.back") then
            travel.x = travel.x - lad_up.x
            travel.y = travel.y - lad_up.y
            travel.z = travel.z - lad_up.z
        end
        if ga_get_b("xar.movement.left") then
            travel.x = travel.x + lad_left.x
            travel.y = travel.y + lad_left.y
            travel.z = travel.z + lad_left.z
        end
        if ga_get_b("xar.movement.right") then
            travel.x = travel.x - lad_left.x
            travel.y = travel.y - lad_left.y
            travel.z = travel.z - lad_left.z
        end
        if ga_get_b("xar.movement.up") then
            travel.x = travel.x + lad_off.x
            travel.y = travel.y + lad_off.y
            travel.z = travel.z + lad_off.z
        end

        ga_move_set_desired_travel(travel)
    else
        ga_print("*** Error: unknown movement mode found: " .. mode)
        ga_exit()
    end
end

function p.draw_item(wid, num, tex_name)
    local item_y_min = 0.01
    local item_height = 0.086
    local item_width = 0.059
    local item_x_delta = 0.065

    local y_min = item_y_min
    local y_max = y_min + item_height

    local raw_num = num
    local x_min = 0.21 + item_x_delta * (raw_num-1)
    local x_max = x_min + item_width
    local cur_wep = ga_get_i("xar.player.cur_wep")
    if ( (raw_num%10) == cur_wep) then
        local add = 0.02
        y_min = y_min + add
        y_max = y_max + add
    end
    ga_win_quad(wid, x_min, y_min, x_max, y_max, tex_name)
end

function p.hud_render(wid)
    p.draw_item(wid, 1, "inf2_block_gun")
    p.draw_item(wid, 2, "inf2_get_type_gun");
    p.draw_item(wid, 3, "inf2_ladder_gun");

    -- Primary block type.
    local primary_bt = ga_get_s("xar.cheat.inf2.primary_bt")
    local primary_str = "PRIMARY BLOCK: " .. primary_bt
    ga_win_set_front_color(wid, std.vec(0.0, 1.0, 0.0))
    ga_win_set_char_size(wid, 0.015, 0.03)
    ga_win_txt_center(wid, 0.20, primary_str)

    local secondary_bt = ga_get_s("xar.cheat.inf2.secondary_bt")
    local secondary_str = "SECONDARY BLOCK: " .. secondary_bt
    ga_win_set_front_color(wid, std.vec(0.0, 1.0, 0.0))
    ga_win_set_char_size(wid, 0.015, 0.03)
    ga_win_txt_center(wid, 0.15, secondary_str)

    if( ga_get_sys_b("game.input.quick_cmd.entering") ) then
        local msg = "/" .. ga_get_sys_s("game.input.quick_cmd.partial")
        local min_x = 0.01
        local min_y = 0.3
        local front_alpha = 1.0
        ga_win_txt_alpha_bg(wid, min_x, min_y, front_alpha, msg)
    end
end

function p.try_shoot(cur_gun)
    local starting_shoot = ga_get_b("xar.inv_exec.starting_shoot")
    if( not starting_shoot ) then return end
    ga_set_b("xar.inv_exec.starting_shoot", false)

    local cur_gun = ga_get_i("xar.player.cur_wep")
    local primary = ga_get_b("xar.inv_exec.primary")
    local viewer_pos = ga_get_viewer_offset()
    local viewer_level = ga_get_viewer_level()
    local look = ga_get_sys_v("game.player.camera.look")

    if( cur_gun == 1 ) then
        --Block gun.
        local ent_type = (primary and "ment_block_gun_add" or "ment_block_gun_remove")

        local extend_len = 0.1
        local pos = std.vec_add(viewer_pos, std.vec_scale(look, extend_len))

        ga_ment_start(viewer_level, pos, ent_type)

        local speed = 1000.0
        local vel = std.vec_scale(look, speed)
        ga_ment_init_set_v("__vel", vel)

        ga_ment_end()
    end
    if( cur_gun == 2 ) then
        --Block gun.
        local ent_type = (primary and "ment_block_type_get_in" or "ment_block_type_get_out")

        local extend_len = 0.1
        local pos = std.vec_add(viewer_pos, std.vec_scale(look, extend_len))

        ga_ment_start(viewer_level, pos, ent_type)

        local speed = 1000.0
        local vel = std.vec_scale(look, speed)
        ga_ment_init_set_v("__vel", vel)

        ga_ment_end()
    end
    if cur_gun == 3 then
        --Ladder gun.
        local bent_type = "ment_ladder_gun_add"

        local extend_len = 0.1
        local pos = std.vec_add(viewer_pos, std.vec_scale(look, extend_len))

        ga_ment_start(viewer_level, pos, bent_type)

        local speed = 1000.0
        local vel = std.vec_scale(look, speed)
        ga_ment_init_set_v("__vel", vel)

        ga_ment_end()
    end
end

--bp1 is the position of the block.
--bp2 is the position of the player.
function p.can_build_block(level, bp1)
    return p.can_build_block_correct(level, bp1)
    -- return p.can_build_block_crude(level, bp1)
end

--The correct version.
function p.can_build_block_correct(level, block_bp)
    local viewer_level = ga_get_viewer_level()
    if( level ~= viewer_level ) then
        --We are not making a fractal mining game
        --in this package, just an Easter egg.
        return
    end
    --Seeing if bounding box of player
    --intersects the block.
    --vp = position of the player's eye.
    local vp = ga_get_viewer_offset()
    local radius = 0.15    --Too much.
    local bot_to_eye = 1.0 --Too much.
    local eye_to_top = 0.5 --Too much.
    local bbox_min_v = std.vec(
        vp.x - radius,
        vp.y - radius,
        vp.z - bot_to_eye)
    local bbox_max_v = std.vec(
        vp.x + radius,
        vp.y + radius,
        vp.z + eye_to_top)
    local bbox_min_bp = std.lp_to_bp(bbox_min_v)
    local bbox_max_bp = std.lp_to_bp(bbox_max_v)
    for x = bbox_min_bp.x, bbox_max_bp.x do
    for y = bbox_min_bp.y, bbox_max_bp.y do
    for z = bbox_min_bp.z, bbox_max_bp.z do
        local player_part_bp = std.bp(x,y,z)
        local str1 = std.vec_to_str(player_part_bp)
        local str2 = std.vec_to_str(block_bp)
        if( std.bp_eq(block_bp, player_part_bp) ) then
            --The block intersects the bounding
            --box of the player.
            return false
        end
    end end end
    return true
end

--The crude version.
--This algorithm is too cautious,
--but it is easy to program.
function p.can_build_block_crude(level, bp1)
    local viewer_level = ga_get_viewer_level()
    if( level ~= viewer_level ) then
        --We are not making a fractal mining game
        --in this package, just an Easter egg.
        return
    end

    local bp2 = ga_get_viewer_bp(viewer_level)
    local dist = std.dist_linf(bp1, bp2)
    if dist <= 1 then
        return false
    end
    return true
end