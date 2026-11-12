function p.__get_mesh() return "bent_ammo_gun_1" end
function p.__get_mesh2() return "gun_1_incr_fire_speed" end

function p.payload(level, bp)
    if p.get_num(level, bp) == 1 then
        ga_get_i("worldgen.state.tgaplasma")
        std.set_bydelta_i("worldgen.state.tgaplasma", -1)
        ga_worldgen_refresh_state_var("tgaplasma")
    end
    ga_srand(ga_block_seed_pos(level, bp))
    game_upgrades.plasma_fire_rate()
    game_bent.remove_perm(level, bp)
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Plasma Fire Rate"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end

function p.get_num(level, bp)
    return ga_bent_get_param_i(level, bp)
end
