--This is the only funciton in this script
--which should be called from the outside.
function p.main(level, block_side_str)
    return p.color_xar_standard(level, block_side_str)

    -- return p.color_engine_default(level, block_side_str)
    -- return p.color_abs_fade_out(level, block_side_str)
    -- return p.color_local_fade_out(level, block_side_str)
end

-------------------------------------------------
--                  Helpers
-------------------------------------------------

--"shade" should be a float between 0 and 1.
function p.shade_to_color(shade)
    if( shade < 0.0 ) then shade = 0.0 end
    if( shade > 1.0 ) then shade = 1.0 end
    return std.vec(shade, shade, shade)
end

-------------------------------------------------
--          Standard direction colors
-------------------------------------------------

--This code agrees with the C++ version.
--Do not change this (but you can write your own version).
function p.shade_standard_dir(block_side_str)
    local shade = 1.0
    if( block_side_str == "x_pos" ) then shade = 0.8 end
    if( block_side_str == "x_neg" ) then shade = 0.8 end
    if( block_side_str == "y_pos" ) then shade = 0.6 end
    if( block_side_str == "y_neg" ) then shade = 0.6 end
    if( block_side_str == "z_pos" ) then shade = 1.0 end
    if( block_side_str == "z_neg" ) then shade = 0.4 end
    return shade
end

-------------------------------------------------
--           The standard side colors
-------------------------------------------------

--This ignores the level.
function p.color_engine_default(level, block_side_str)
    local shade = p.shade_standard_dir(block_side_str)
    return p.shade_to_color(shade)
end

-------------------------------------------------
--  Making it darker as we get to level 2000
-------------------------------------------------
--It starts to get dark at level 500.

--The logic of this component.
function p.shade_abs_fade_out(level)
    local frac = (level - 500) / 1500
    if( frac < 0.0 ) then frac = 0.0 end
    if( frac > 1.0 ) then frac = 1.0 end
    return (1.0 - frac)
end

--Assuming this is the only effect.
function p.color_abs_fade_out(level, block_side_str)
    local shade1 = p.shade_standard_dir(block_side_str)
    local shade2 = p.shade_abs_fade_out(level)
    local shade = shade1 * shade2
    return p.shade_to_color(shade)
end

-------------------------------------------------
--       Next coarser levels are darker
-------------------------------------------------
--Usually the game only renders 5 levels of detail.
--With this shading function, the viewer's level
--is the briglest, the level -1 from that is a
--little tarker, the level -1 from that is even
--tarker, etc.

--The logic of this component.
function p.shade_local_fade_out(level)
    local num_render_levels = ga_get_sys_i("engine.render.num_render_levels")
    local viewer_level = ga_get_viewer_level()
    local delta = viewer_level - level
    local frac = 1.0 - (1.0 / num_render_levels) * delta
    --delta = 0 -> frac = 1.0
    if( frac < 0.0 ) then frac = 0.0 end
    if( frac > 1.0 ) then frac = 1.0 end
    --
    local var1 = "render.levels_fade_out_local.max_level_shade"
    local var2 = "render.levels_fade_out_local.min_level_shade"
    ga_package_init_f(var1, 1.0)
    ga_package_init_f(var2, 1.0 / num_render_levels)
    local value1 = ga_package_get_f(var1)
    local value2 = ga_package_get_f(var2)
    local value = value1 * frac + value2 * (1.0 - frac)
    --
    return value
end

--The logic of this component,
--controlled by a package variable.
function p.shade_local_fade_out_maybe(level)
    local var = "render.levels_fade_out_local.enabled"
    ga_package_init_b(var, false)
    local enabled = ga_package_get_b(var)
    if( enabled ) then
        return p.shade_local_fade_out(level)
    else
        return 1.0
    end
end

--Assuming this is the only effect.
function p.color_local_fade_out(level, block_side_str)
    local shade1 = p.shade_standard_dir(block_side_str)
    local shade2 = p.shade_local_fade_out(level)
    local shade = shade1 * shade2
    return p.shade_to_color(shade)
end

-------------------------------------------------
--              Rainbow colors
-------------------------------------------------
--This is just an idea.
--A modder can implement this if they want.
--In a very old version of FBW (from 2012),
--the levels would change colors as your went deeper.
--They would gradually change from
--red to orange to yellow to green to blue to purple, and then
--red again (or something like that).
--This looked cool when there was only block
--texture (the usual cement texture).

-------------------------------------------------
--              Xar standard
-------------------------------------------------
--Mixing several effects together.

function p.color_xar_standard(level, block_side_str)
    local shade1 = p.shade_standard_dir(block_side_str)
    local shade2 = p.shade_abs_fade_out(level)
    local shade3 = p.shade_local_fade_out_maybe(level)
    local shade4 = game_block_blind.get_interpolated_shade()
    local shade = shade1 * shade2 * shade3 * shade4
    return p.shade_to_color(shade)
end
