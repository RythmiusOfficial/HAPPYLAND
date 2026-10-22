local time_scale_1 = 0.1 --Tweek.
local time_scale_2 = 0.1 --Tweek.

function p.advance_shade(old_shade, old_time, got_a_hit)
    local cur_time = ga_get_game_time()
    local time_delta = cur_time - old_time
    if( time_delta < -1.0 ) then
        --Safety. --Time travel must have occured.
        --Ressting everything.
        ga_set_f("xar.visual_effect.block_blind.last_time", cur_time)
        ga_set_b("xar.visual_effect.block_blind.got_a_hit_old", false)
        local next_shade = 1.0
        ga_set_f("xar.visual_effect.block_blind.cur_shade", next_shade)
        return next_shade
    end
    local next_shade
    if( got_a_hit ) then
        next_shade = old_shade - time_scale_1 * time_delta
    else
        next_shade = old_shade + time_scale_2 * time_delta
    end
    if( next_shade < 0 ) then next_shade = 0 end
    if( next_shade > 1 ) then next_shade = 1 end
    return next_shade
end

function p.process_update()
    local time_interval_len = 1.0
    local cur_time = ga_get_game_time()
    local last_effect_time = ga_get_f("xar.visual_effect.block_blind.last_time")
    if( cur_time < last_effect_time + time_interval_len ) then return end
    --
    ga_set_f("xar.visual_effect.block_blind.last_time", cur_time)
    local time_delta = cur_time - last_effect_time
    local got_a_hit_old = ga_get_b("xar.visual_effect.block_blind.got_a_hit_old")
    local got_a_hit = ga_get_b("xar.visual_effect.block_blind.got_a_hit")
    --
    local old_shade = ga_get_f("xar.visual_effect.block_blind.cur_shade")
    local next_shade = p.advance_shade(old_shade, last_effect_time, got_a_hit_old)
    ga_set_f("xar.visual_effect.block_blind.cur_shade", next_shade)
    --
    ga_set_b("xar.visual_effect.block_blind.got_a_hit_old", got_a_hit)
    ga_set_b("xar.visual_effect.block_blind.got_a_hit", false)
end

--CHECK THIS!!!
function p.get_interpolated_shade()
    local cur_time = ga_get_game_time()
    local last_logic_time = ga_get_f("xar.visual_effect.block_blind.last_time")
    local got_a_hit_old = ga_get_b("xar.visual_effect.block_blind.got_a_hit_old")
    local last_logic_shade = ga_get_f("xar.visual_effect.block_blind.cur_shade")
    local interp_shade = p.advance_shade(last_logic_shade, last_logic_time, got_a_hit_old)
    return interp_shade
end
