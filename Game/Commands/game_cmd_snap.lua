--This is called by the engine when the game is loaded.
function p.__load_game()
    local cmd_name = "snap"
    game_command_system.add_command(cmd_name, p.handler)
    game_command_system.add_help(cmd_name, p.get_help_str())
end

function p.handler(str)
    local fn = "chunk_snapshot.lua"
    local full_fn = "Output/FileOut/" .. fn
    ga_console_print("Writing snapshot of current chunk to the following file: ")
    ga_console_print(full_fn)
    --h is the file "handle".
    local h = ga_open_file_for_writing(fn);
    local level = ga_get_viewer_level()
    local chunk_id = ga_get_viewer_chunk_id()
    local vcp = ga_chunk_id_to_vcp(chunk_id)
    local default_bt = ga_get_most_common_bt_in_chunk(chunk_id)
    p.line(h, "function p.__get_is_solid() return false end")
    p.line(h, "function p.__get_tex() return \"\" end")
    p.line(h, "")
    p.line(h, "function p.__main()")
    p.line(h, "    set_default_block(\"" .. default_bt .. "\")")
    ---------------------------------------------
    --             Merging boxes
    ---------------------------------------------
    local box_data = {}
    game_merge_engine.init_boxes(box_data)
    for z = 0,15 do
    for x = 0,15 do
    for y = 0,15 do
        local lbp = std.bp(x,y,z)
        local bp = std.lbp_to_bp(vcp, lbp)
        local bt = ga_bp_to_bt(level, bp)
        if bt ~= default_bt then
            -- game_bt_merge_engine.add_cube_debug(box_data, bp, bt) --Does not merge.
            game_bt_merge_engine.add_cube(box_data, bp, bt)
        end
    end end end
    ---------------------------------------------
    --           Writing merged boxes
    ---------------------------------------------
    for bt,_ in pairs(box_data) do
        for box,_ in pairs(box_data[bt]) do
            local vol = game_merge_engine.get_box_volume(box)
            if vol == 1 then
                local bp = box.min
                p.line(h, "    set_pos("
                    .. tostring(bp.x) .. ","
                    .. tostring(bp.y) .. ","
                    .. tostring(bp.z) .. ", "
                    .. "\"" .. bt .. "\")")
            else
                p.line(h, "    create_rect(\"" .. bt .. "\", "
                    .. tostring(box.min.x) .. ","
                    .. tostring(box.min.y) .. ","
                    .. tostring(box.min.z) .. ", "
                    .. tostring(box.max.x) .. ","
                    .. tostring(box.max.y) .. ","
                    .. tostring(box.max.z) .. ")")
            end
        end
    end
    ---------------------------------------------
    --    Writing unmerged blocks (debugging)
    ---------------------------------------------
    -- for z = 0,15 do
    -- for x = 0,15 do
    -- for y = 0,15 do
    --     local lbp = std.bp(x,y,z)
    --     local bp = std.lbp_to_bp(vcp, lbp)
    --     local bt = ga_block_get(level, bp)
    --     if bt ~= default_bt then
    --         local str =
    --                "    set_pos("
    --             .. tostring(x) .. ","
    --             .. tostring(y) .. ","
    --             .. tostring(z) .. ","
    --             .. "\"" .. bt .. "\""
    --             .. ")"
    --         p.line(h, str)
    --     end
    -- end end end
    ---------------------------------------------
    --              Finishing up
    ---------------------------------------------
    p.line(h, "end")
    ga_close_file(h);
    return false
end

function p.line(handle, str)
    -- ga_print(str)
    ga_write(handle, str .. "\n")
end

function p.get_help_str()
    return
           "Usage: snap\n\n"
        .. "This will create a .lua block script file that partially "
        .. "represents the contents of the chunk which contains the player. "
end
