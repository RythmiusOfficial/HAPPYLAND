--File: game_alt_level_radius.lua

function p.__update_discrete_pre()
    local old_using_alt_radius = ga_get_b("xar.movement.alt_level_radius.is_using")
    local new_using_alt_radius = p.get_new_using_alt_radius()
    if( new_using_alt_radius == old_using_alt_radius ) then return end
    --
    if( new_using_alt_radius and not old_using_alt_radius ) then
        --Turing on the alt radius effect.
        ga_set_b("xar.movement.alt_level_radius.is_using", true)
        --
        --Saving the cur level radius for when we end the effect later.
        local cur_radius = ga_get_level_radius(0)
        ga_set_i("xar.movement.alt_level_radius.old_radius", cur_radius)
        --
        --Setting the level radius to the alternate value.
        if( game_black_hole_drive.get_uses_alt_radius() ) then
            local alt_radius = game_black_hole_drive.get_alt_radius()
            ga_set_level_radius(0, alt_radius)
        end
        return
    end
    --
    if( not new_using_alt_radius and old_using_alt_radius ) then
        --Turning off the alt radius effect.
        ga_set_b("xar.movement.alt_level_radius.is_using", false)
        --
        --Getting the saved level radius from before the effect.
        local old_radius = ga_get_i("xar.movement.alt_level_radius.old_radius")
        --Setting the level radius to old_radius.
        ga_set_level_radius(0, old_radius)
        return
    end
end

function p.get_new_using_alt_radius()
    if p.get_in_black_hole_drive() then return true end
    if p.get_in_quasar_drive() then return true end
    return false
end

function p.get_in_black_hole_drive()
    local game_time = ga_get_game_time()
    local black_hole_drive_end_time = ga_get_f("xar.player.gun0.black_hole_drive_end")
    return ( game_time < black_hole_drive_end_time )
end

function p.get_in_quasar_drive()
    local game_time = ga_get_game_time()
    local quasar_drive_end_time = ga_get_f("xar.player.gun0.quasar_drive_end")
    return ( game_time < quasar_drive_end_time )
end
