--Will never have two flashes in this period of time.
local epilepsy_delay = 1.0

function p.flashes_enabled()
    ga_package_init_b("flashes.enable", true)
    return ga_package_get_b("flashes.enable")
end

function p.add_flash_now(color, alpha, duration)
    local cur_time = ga_get_game_time()

    --Seeing if should disable flashes entirely.
    ga_package_init_b("flashes.enable", true)
    local flashes_enabled = ga_package_get_b("flashes.enable")
    if( not flashes_enabled ) then return end

    --Saftey check (for epilepsy):
    if( not p.safe_for_flash_and_reg() ) then
        --Not making a flash.
        return
    end

    --Setting vars for the hud.
    ga_set_v("xar.hud.flash.color", color)
    ga_set_f("xar.hud.flash.alpha", alpha)
    ga_set_f("xar.hud.flash.last_time", cur_time)
    ga_set_f("xar.hud.flash.duration", duration)
end

--Returns false if cannot make a flash.
--If a flash can be made, it registers that
--a flash has been made and it returns true.
function p.safe_for_flash_and_reg()
    --Saftey check (for epilepsy):
    local cur_time = ga_get_game_time()
    local last_flash = ga_get_f("xar.hud.flash.last_time")
    if( cur_time < last_flash + epilepsy_delay ) then return false end
    
    --Registering a flash.
    ga_set_f("xar.hud.flash.last_time", cur_time)
    --Dummy flash vars, can be changed by caller.
    ga_set_v("xar.hud.flash.color", std.vec(1.0, 1.0, 1.0))
    ga_set_f("xar.hud.flash.alpha", 0.0)
    ga_set_f("xar.hud.flash.last_time", cur_time)
    ga_set_f("xar.hud.flash.duration", 1.0)

    return true
end
