--File: game_version.lua

--Helper function.
--For example, if the str is "1.01.30",
--this function will return 10130.
--So, we need to be careful about having 100 or more versions!
--For example, "1.01.216" should not be a valid version.
function p.fbw_version_str_to_int(str)
    local str_nums_only = str:gsub('%.', '')
    local int_value = tonumber(str_nums_only)
    return int_value
end

--Gets the first version of the engine that was used for this saved game.
--This is needed to grandfather certain features.
--

function p.get_first_engine_version_int()
    local str = ga_get_sys_s("game.version.first_engine_version")
    return p.fbw_version_str_to_int(str)
end
