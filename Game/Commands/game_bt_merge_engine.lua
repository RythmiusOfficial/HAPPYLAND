-------------------------------------------------
--                    API
-------------------------------------------------

--Silly function.
function p.init_data(data)
    data = {}
end

function p.add_cube(data, bp, bt)
    if data[bt] == nil then
        data[bt] = {}
    end
    game_merge_engine.add_cube(data[bt], bp)
end

--This turns the position into a 1x1x1 box
--and does NOT merge it.
function p.add_cube_debug(data, bp, bt)
    if data[bt] == nil then
        data[bt] = {}
    end
    ga_print("game_bt_merge_engine.add_cube_debug: " .. std.bp_to_str(bp) .. " -> " .. bt)
    game_merge_engine.add_cube_debug(data[bt], bp)
end

--To do: write this function!!!
function p.remove_cube(data, bp, bt)
    --MORE!!!
end
