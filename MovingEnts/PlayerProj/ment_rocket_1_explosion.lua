-------------------------------------------------
--            Type Init Function
-------------------------------------------------

function p.__type_init(id)
    game_ment_type_init.player_proj(id)
    ia_ment_set_builtin_var_i(id, "__extra_min_levels", 2)
    ia_ment_set_builtin_var_f(id, "__radius", 0.0) --Will set.
    ia_ment_set_builtin_var_s(id, "__mesh", "rocket1_explosion")
    ia_ment_set_builtin_var_b(id, "__force_no_lighting", true) --Weird.
    ia_ment_set_builtin_var_f(id, "__ttl", 1.0)

    --The level in which the rocket was launched.
    ia_ment_new_var_f(id, "launch_level", -1, 60*60)
end

-------------------------------------------------
--              Inst Functions
-------------------------------------------------

--There might be a frame where it is rendered before this
--is called.  Hence, the radius should initially be set to zero.
function p.__on_add_to_live_world(inst_id)
    local mode = 1
    p.spawn_helper1(inst_id, mode)
end

function p.spawn_helper1(inst_id, mode)
    local wep = 4
    local base_radius = game_wep_modes.get_radius(wep, mode)
    base_radius = base_radius * 0.25
    p.spawn_helper2(inst_id, base_radius)
end

function p.spawn_helper2(inst_id, base_radius)
    local radius = base_radius
    local launch_level = ga_ment_get_f(inst_id, "launch_level")
    local ment_start_level = ga_ment_get_start_level(inst_id)
    -- local ment_level = ga_ment_get_level(inst_id)
    local scale_factor = ga_level_scale_factor(launch_level, ment_start_level)
    radius = radius * scale_factor.value
    ga_ment_set_f(inst_id, "__radius", radius)
    --
    -- ga_print("**********************************************")
    -- ga_print("ment_rocket_1_explosion.spawn_helper2:")
    -- ga_print("  launch_level = " .. tostring(launch_level))
    -- ga_print("  ment_start_level = " .. tostring(ment_start_level))
    -- ga_print("  ment_level = " .. tostring(ment_level))
    -- ga_print("  scale_factor = " .. tostring(scale_factor.value))
    -- ga_print("  final radius = " .. tostring(radius))
    --
    local duration = 1.0
    p.start_death_animation(inst_id, duration)
end

function p.start_death_animation(inst_id, duration)
    if ga_ment_get_s(inst_id, "__death_anim") ~= "" then return end
    --
    ga_ment_set_s(inst_id, "__death_anim", "alpha_fade")
    ga_ment_set_f(inst_id, "__death_anim_alpha_fade_alpha1", 0.75)
    ga_ment_set_f(inst_id, "__death_anim_alpha_fade_alpha2", 0.0)
    local game_time = ga_get_game_time()
    ga_ment_set_f(inst_id, "__death_anim_start", game_time)
    ga_ment_set_f(inst_id, "__death_anim_end", game_time + duration)
end

--Eventually it would be nice to have a custom render function for this ment.
--However, a challenge is there is a special death animation.
-- function p.__render(inst_id, radius)
--     -- ga_render_ment_typical(inst_id)

--     ga_render_matrix_frame_from_ment(inst_id)
--     -- ga_render_matrix_scaled(radius, radius, radius)
--     ga_render_mesh("rocket1_explosion")
-- end
