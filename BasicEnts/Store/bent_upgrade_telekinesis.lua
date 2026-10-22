--File: bent_upgrade_telekinesis.lua

function p.upgrade_name(level, bp)
    return ga_bent_get_param_s(level, bp)
end

function p.get_var_name(level, bp)
    local name = p.upgrade_name(level, bp)
    return "game.globals.xar.player.telekinesis." .. name
end

function p.has_upgrade(level, bp)
    return ga_get_b( p.get_var_name(level, bp) )
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    if( p.has_upgrade(level,bp) ) then
        return "^xffff00View Telekinesis Upgrades"
    else
        return "Upgrade Telekinesis"
    end    
end

function p.__on_use(level, bp)
    if( p.has_upgrade(level,bp) ) then
        --Displaying the window.
        ga_play_sound_menu("use")
        ga_window_push("win_upgrade_telekinesis")
    else
        --Upgrading the telekinesis ability.
        local var = p.get_var_name(level, bp)
        ga_set_b(var, true)
        ga_play_sound("oh_yeah")
    end
end
