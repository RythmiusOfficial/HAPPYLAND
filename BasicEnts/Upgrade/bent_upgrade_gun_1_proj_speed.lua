--Using a custom render function instead.
-- function p.__get_mesh() return "bent_ammo_gun_1" end
-- function p.__get_mesh2() return "gun_1_incr_proj_speed" end

function p.payload(level, bp)
    ga_srand(ga_block_seed_pos(level, bp))
    game_upgrades.plasma_proj_speed()
    game_bent.remove_perm(level, bp)
end

function p.__on_touch(level, bp)
    p.payload(level, bp)
end

function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Plasma Projectile Speed"
end

function p.__on_use(level, bp)
    p.payload(level, bp)
end

function p.on_telekinesis(level, bp)
    p.payload(level, bp)
end

--Testing.
function p.__on_render(level, bp)
    --Creating the classic "pulsating" look.
    --Could put in a helper function.
    local cur_time = ga_get_game_time()
    scale = 1.0 + math.cos(6.0 * cur_time) * 0.1
    ga_render_matrix_scaled(scale, scale, scale);
    --
    local mesh = "bent_ammo_gun_1"
    local tex = ga_mesh_get_tex(mesh)
    -- ga_render_mesh_with_tex_no_lighting(mesh, tex)
    -- ga_render_mesh_with_tex(mesh, tex)
    ga_render_mesh(mesh)
    --
    local mesh = "gun_1_incr_proj_speed"
    local tex = ga_mesh_get_tex(mesh)
    -- ga_render_mesh_with_tex_no_lighting(mesh, tex)
    -- ga_render_mesh_with_tex(mesh, tex)
    ga_render_mesh(mesh)
    --
end
